//
//  BPFormulaOption.m
//  Cicerone
//
//  Created by Marek Hrusovsky on 09/10/14.
//  Copyright (c) 2014 Bruno Philipe. All rights reserved.
//

#import "BPFormulaOption.h"

static NSString *const kBPFormulaOptionNameKey = @"formulaOptionName";
static NSString *const kBPFormulaOptionExplanationKey = @"formulaOptionExplanation";

@implementation BPFormulaOption

+ (BOOL)supportsSecureCoding
{
	return YES;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (self) {
		_name = [aDecoder decodeObjectOfClass:[NSString class] forKey:kBPFormulaOptionNameKey];
		_explanation = [aDecoder decodeObjectOfClass:[NSString class] forKey:kBPFormulaOptionExplanationKey];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.name forKey:kBPFormulaOptionNameKey];
	[aCoder encodeObject:self.explanation forKey:kBPFormulaOptionExplanationKey];
}

- (instancetype)copyWithZone:(NSZone *)zone
{
	BPFormulaOption *option = [[[self class] allocWithZone:zone] init];
	if (option)
	{
		option->_name = [self->_name  copy];
		option->_explanation = [self->_explanation copy];
	}
	return option;
}

@end
