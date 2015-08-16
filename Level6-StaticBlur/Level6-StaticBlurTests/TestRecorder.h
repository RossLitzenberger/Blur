//
//  NSLogToFile.h
//  CoreiOS7ExampleProject
//
//  Created by Eric Allam on 8/9/13.
//  Copyright (c) 2013 Eric Allam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTestRun.h>

@interface TestRecorder : NSObject
+ (void)recordTestRun:(XCTestRun *)aRun;
@end
