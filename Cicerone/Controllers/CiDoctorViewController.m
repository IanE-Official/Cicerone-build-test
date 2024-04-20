//
//  CiDoctorViewController.m
//  Cicerone
//
//  Created by Marek Hrusovsky on 21/08/14.
//	Copyright (c) 2014 Bruno Philipe. All rights reserved.
//
//	This program is free software: you can redistribute it and/or modify
//	it under the terms of the GNU General Public License as published by
//	the Free Software Foundation, either version 3 of the License, or
//	(at your option) any later version.
//
//	This program is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
//	GNU General Public License for more details.
//
//	You should have received a copy of the GNU General Public License
//	along with this program.	If not, see <http://www.gnu.org/licenses/>.
//

#import "CiDoctorViewController.h"
#import "CiHomebrewInterface.h"
#import "CiAppDelegate.h"
#import "CiStyle.h"

@interface CiDoctorViewController ()

@property (unsafe_unretained, nonatomic) IBOutlet NSTextView *doctorTextView;
@property (weak, nonatomic) IBOutlet NSProgressIndicator *progressIndicator;
@property (assign) BOOL isPerformingDoctor;

@end

@implementation CiDoctorViewController

- (void)awakeFromNib {
	NSFont *font = [CiStyle defaultFixedWidthFont];
	[self.doctorTextView setFont:font];
	self.isPerformingDoctor = NO;
}

- (NSString *)nibName {
	return @"CiDoctorView";
}

- (IBAction)runStopDoctor:(id)sender {
	CiAppDelegate *appDelegate = CiAppDelegateRef;
	
	if (appDelegate.isRunningBackgroundTask)
	{
		[appDelegate displayBackgroundWarning];
		return;
	}
	[appDelegate setRunningBackgroundTask:YES];
	
	[self.doctorTextView setString:@""];
	self.isPerformingDoctor = YES;
	[self.progressIndicator startAnimation:sender];

	NSString *previousString = [self.doctorTextView string];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
		[[CiHomebrewInterface sharedInterface] runDoctorWithReturnBlock:^(NSString *output) {
			[self.doctorTextView performSelectorOnMainThread:@selector(setString:)
												  withObject:[previousString stringByAppendingString:output]
											   waitUntilDone:YES];
		}];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			NSLog(@"Finished doctor");
			[self.progressIndicator stopAnimation:sender];
			self.isPerformingDoctor = NO;
			[appDelegate setRunningBackgroundTask:NO];
			
			NSString *title = [NSLocalizedString(@"Homebrew_Task_Finished", nil) capitalizedString];
			NSString *desc = NSLocalizedString(@"Notification_Update", nil);
			[CiAppDelegateRef requestUserAttentionWithMessageTitle:title andDescription:desc];
		});
	});
}

- (IBAction)clearLogDoctor:(id)sender {
	self.doctorTextView.string = @"";
}

@end
