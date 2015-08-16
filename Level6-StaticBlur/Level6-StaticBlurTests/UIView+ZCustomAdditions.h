//
//  UIView+ZCustomAdditions.h
//  Level6-StaticBlur
//
//  Created by Eric Allam on 10/28/13.
//  Copyright (c) 2013 Code School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZCustomAdditions)
- (BOOL)custom_drawViewHierarchyInRect:(CGRect)rect afterScreenUpdates:(BOOL)afterUpdates;
@end
