//
//  BadgesViewController+OverridePresent.h
//  Level3-AnimatedTransition
//
//  Created by Eric Allam on 9/14/13.
//  Copyright (c) 2013 Code School. All rights reserved.
//

@interface UIViewController (OverridePresent)
- (void)custom_presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion;
@end
