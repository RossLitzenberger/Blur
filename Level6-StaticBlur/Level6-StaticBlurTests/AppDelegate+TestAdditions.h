//
//  AppDelegate+TestAdditions.h
//  Level3-AnimatedTransition
//
//  Created by Eric Allam on 9/14/13.
//  Copyright (c) 2013 Code School. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (TestAdditions)
@property (strong, nonatomic) UIViewController *presentedViewController;
@property (assign, nonatomic) CGRect drawingRect;
@property (strong, nonatomic) UIView *snapshottedView;
@end
