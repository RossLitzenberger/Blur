//
//  BadgesViewController+OverridePresent.m
//  Level3-AnimatedTransition
//
//  Created by Eric Allam on 9/14/13.
//  Copyright (c) 2013 Code School. All rights reserved.
//

#import "UIViewController+OverridePresent.h"
#import "CSSwizzler.h"
#import "AppDelegate+TestAdditions.h"

@implementation UIViewController (OverridePresent)

+ (void) load
{
    [CSSwizzler swizzleClass:[UIViewController class]
               replaceMethod:@selector(presentViewController:animated:completion:)
                  withMethod:@selector(custom_presentViewController:animated:completion:)];

}

- (void)custom_presentViewController:(UIViewController *)viewControllerToPresent
                            animated:(BOOL)flag
                          completion:(void (^)(void))completion;
{
    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDel.presentedViewController = viewControllerToPresent;
    
    [self custom_presentViewController:viewControllerToPresent animated:flag completion:completion];
}
@end
