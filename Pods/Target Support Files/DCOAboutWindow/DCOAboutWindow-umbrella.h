#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "DCOAboutWindow.h"
#import "DCOAboutWindowController.h"
#import "DCOBackgroundView.h"

FOUNDATION_EXPORT double DCOAboutWindowVersionNumber;
FOUNDATION_EXPORT const unsigned char DCOAboutWindowVersionString[];

