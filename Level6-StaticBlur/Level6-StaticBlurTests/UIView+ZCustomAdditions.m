//
//  UIView+ZCustomAdditions.m
//  Level6-StaticBlur
//
//  Created by Eric Allam on 10/28/13.
//  Copyright (c) 2013 Code School. All rights reserved.
//

#import "UIView+ZCustomAdditions.h"
#import "AppDelegate+TestAdditions.h"
#import "CSSwizzler.h"

@implementation UIView (ZCustomAdditions)
+ (void)load
{
    [CSSwizzler swizzleClass:[UIView class]
               replaceMethod:@selector(drawViewHierarchyInRect:afterScreenUpdates:)
                  withMethod:@selector(custom_drawViewHierarchyInRect:afterScreenUpdates:)];
}

- (BOOL)custom_drawViewHierarchyInRect:(CGRect)rect afterScreenUpdates:(BOOL)afterUpdates;
{
    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDel.drawingRect = rect;
    appDel.snapshottedView = self;
    
    return [self custom_drawViewHierarchyInRect:rect afterScreenUpdates:afterUpdates];
}
@end
