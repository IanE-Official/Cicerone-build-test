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

#import "DCOTransparentScroller.h"
#import "DCOTransparentScrollView.h"

FOUNDATION_EXPORT double DCOTransparentScrollerVersionNumber;
FOUNDATION_EXPORT const unsigned char DCOTransparentScrollerVersionString[];

