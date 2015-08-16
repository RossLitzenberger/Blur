#import "TestRecorder.h"

static NSFileHandle *__handle;

@implementation TestRecorder

+ (void)recordTestRun:(XCTestRun *)aRun;
{
    NSDictionary *info = @{
                           @"testCaseCount": @(aRun.testCaseCount),
                           @"totalFailureCount": @(aRun.totalFailureCount),
                           @"testName": aRun.test.name
                           };
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:info options:0 error:nil];
    
    [__handle writeData:data];
    [__handle writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (void) load
{
    NSString *path = [[[[NSProcessInfo processInfo] environment] objectForKey:@"DYLD_LIBRARY_PATH"] stringByAppendingPathComponent:@"test_results.log"];
    
    [@"" writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    __handle = [NSFileHandle fileHandleForWritingAtPath:path];
}


@end