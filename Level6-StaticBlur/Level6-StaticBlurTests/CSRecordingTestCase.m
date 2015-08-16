//
//  CSRecordingTestCase.m
//  CoreiOS7ExampleProject
//
//  Created by Eric Allam on 8/29/13.
//  Copyright (c) 2013 Eric Allam. All rights reserved.
//

#import "CSRecordingTestCase.h"
#import "TestRecorder.h"

@implementation CSRecordingTestCase

- (void) performTest:(XCTestRun *) aRun;
{
    [super performTest:aRun];
    
    [TestRecorder recordTestRun:aRun];
}

#pragma mark - KIFTestActorDelegate protocol implementation

- (void)failWithException:(NSException *)exception stopTest:(BOOL)stop
{
    [self failWithExceptions:@[exception] stopTest:NO];
}

- (void)failWithExceptions:(NSArray *)exceptions stopTest:(BOOL)stop
{
    NSException *lastException = exceptions.lastObject;
    
    [self recordExceptionFailure:lastException];
    
}

- (void)recordExceptionFailure:(NSException *)exception
{
    [self recordFailureWithDescription:[exception description]
                                inFile:exception.filename
                                atLine:[exception.lineNumber integerValue]
                              expected:YES];
}

@end
