//
//  AppDelegate+TestAdditions.m
//  Level3-AnimatedTransition
//
//  Created by Eric Allam on 9/14/13.
//  Copyright (c) 2013 Code School. All rights reserved.
//

#import "AppDelegate+TestAdditions.h"
#import <objc/objc-runtime.h>

static char presentedKey;
static char drawingRectKey;
static char snapshottedViewKey;

@implementation AppDelegate (TestAdditions)

- (void)setSnapshottedView:(UIView *)snapshottedView
{
    objc_setAssociatedObject(self, &snapshottedViewKey, snapshottedView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)snapshottedView
{
    return objc_getAssociatedObject(self, &snapshottedViewKey);
}

- (void)setDrawingRect:(CGRect)drawingRect
{
    objc_setAssociatedObject(self, &drawingRectKey, [NSValue valueWithCGRect:drawingRect], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)drawingRect
{
    id drawingRectValue = objc_getAssociatedObject(self, &drawingRectKey);
    
    return [drawingRectValue CGRectValue];
}

- (void) setPresentedViewController:(UIViewController *)presentedViewController
{
    objc_setAssociatedObject(self, &presentedKey, presentedViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)presentedViewController
{
    return (UIViewController *)objc_getAssociatedObject(self, &presentedKey);
}

@end
