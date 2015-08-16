#import <XCTest/XCTest.h>
#import "CSRecordingTestCase.h"
#import "AppDelegate+TestAdditions.h"
#import "StatsViewController.h"
#import "BadgesViewController.h"
#import <QuartzCore/QuartzCore.h>

typedef struct RGBAPixel {
    char r;
    char g;
    char b;
    char a;
} RGBAPixel;


@interface Level6_StaticBlurTests : CSRecordingTestCase {
    AppDelegate *_appDel;
}
@end

@implementation Level6_StaticBlurTests

- (void)setUp
{
    [super setUp];
    
    _appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testImageEffectsAddition
{
    UIImage *image = [[UIImage alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    XCTAssert([image respondsToSelector:@selector(applyLightEffect)], @"Did not add the UIImage+ImageEffects category to the project");
    
#pragma clang diagnostic pop
}

- (void)testGraphicSnapshot
{
    [tester tapViewWithAccessibilityLabel:@"Display Stats"];
    [tester waitForViewWithAccessibilityLabel:@"Stats View"];
    
    CGRect expectedDrawingRect = CGRectMake(-20, -20, 320, 568);
    CGRect actualDrawingRect = _appDel.drawingRect;
    
    XCTAssert(!CGRectEqualToRect(actualDrawingRect, CGRectZero), @"Did not call drawViewHierarchyInRect:afterScreenUpdates: in viewDidAppear");
    
    UIView *expectedSnapshottedView = _appDel.presentedViewController.presentingViewController.view;
    
    XCTAssertEqualObjects(expectedSnapshottedView, _appDel.snapshottedView, @"Did not send drawViewHierarchyInRect:afterScreenUpdates: to the correct view. Should have been the presentedViewController's view");
    
    XCTAssertEqual(expectedDrawingRect.origin.x, actualDrawingRect.origin.x, @"The rect passed into drawViewHierarchyInRect:afterScreenUpdates: should have an origin.x value of -20, but instead was %f", actualDrawingRect.origin.x);
    
    XCTAssertEqual(expectedDrawingRect.origin.y, actualDrawingRect.origin.y, @"The rect passed into drawViewHierarchyInRect:afterScreenUpdates: should have an origin.y value of -20, but instead was %f", actualDrawingRect.origin.y);
    
    XCTAssertEqual(expectedDrawingRect.size.width, actualDrawingRect.size.width, @"The rect passed into drawViewHierarchyInRect:afterScreenUpdates: should have an width of 320, but instead was %f", actualDrawingRect.size.width);
    
    XCTAssertEqual(expectedDrawingRect.size.height, actualDrawingRect.size.height, @"The rect passed into drawViewHierarchyInRect:afterScreenUpdates: should have a height of 568, but instead was %f", actualDrawingRect.size.height);
    
    [tester tapViewWithAccessibilityLabel:@"Good Job"];
}

- (void)testExtraLightEffectAndAssign
{
    [tester runBlock:^KIFTestStepResult(NSError *__autoreleasing *error) {
        
        BadgesViewController *badgesVC = (BadgesViewController *)[(UINavigationController *)_appDel.window.rootViewController topViewController];
        
        if ([badgesVC.badges count] > 0) {
            return KIFTestStepResultSuccess;
        }else{
            return KIFTestStepResultWait;
        }
        
    } complete:^(KIFTestStepResult result, NSError *error) {
        [tester tapViewWithAccessibilityLabel:@"Display Stats"];
        [tester waitForViewWithAccessibilityLabel:@"Stats View"];
        
        StatsViewController *statsVC = (StatsViewController *)_appDel.presentedViewController;
        
        UIImage *actual = statsVC.backgroundView.image;
        
        // Extra light effect expected with the badges loading
        UIImage *expected = [UIImage imageNamed:@"extraLightEffect"];
      
        BOOL result1 = [self compareReferenceImage:actual toImage:expected];
      
        XCTAssert(result1, @"Did not apply the extra light effect to the snapshot image before setting it on the self.backgroundView.image property");
        
        [tester tapViewWithAccessibilityLabel:@"Good Job"];
    } timeout:5.0];
    
    

}

#pragma mark - Image comparison methods
- (BOOL)compareReferenceImage:(UIImage *)referenceImage toImage:(UIImage *)image
{
    if (CGSizeEqualToSize(referenceImage.size, image.size)) {
        
        __block BOOL imagesEqual = YES;
        [self _enumeratePixelsInReferenceImage:referenceImage
                                     testImage:image
                                    usingBlock:^(RGBAPixel *referencePixelPtr, RGBAPixel *testPixelPtr, BOOL *stop){
                                        BOOL equal =
                                        (referencePixelPtr->r == testPixelPtr->r &&
                                         referencePixelPtr->g == testPixelPtr->g &&
                                         referencePixelPtr->b == testPixelPtr->b &&
                                         referencePixelPtr->a == testPixelPtr->a);
                                        if (!equal) {
                                            imagesEqual = NO;
                                            *stop = YES;
                                        }
                                    }];

        return imagesEqual;
    }
    

    return NO;
}


- (void)_enumeratePixelsInReferenceImage:(UIImage *)referenceImage
                               testImage:(UIImage *)testImage
                              usingBlock:(void (^)(RGBAPixel *referencePixel, RGBAPixel *testPixel, BOOL *stop))block
{
    NSAssert(CGSizeEqualToSize(referenceImage.size, testImage.size), @"Images must be same size.");
    
    RGBAPixel *referenceData = NULL;
    CGContextRef referenceContext = NULL;
    UIGraphicsBeginImageContextWithOptions(referenceImage.size, NO, 0);
    {
        [referenceImage drawAtPoint:CGPointZero];
        referenceContext = CGContextRetain(UIGraphicsGetCurrentContext());
        referenceData = (RGBAPixel *)CGBitmapContextGetData(referenceContext);
    }
    UIGraphicsEndImageContext();
    
    RGBAPixel *testData = NULL;
    CGContextRef testContext = NULL;
    UIGraphicsBeginImageContextWithOptions(testImage.size, NO, 0);
    {
        [testImage drawAtPoint:CGPointZero];
        testContext = CGContextRetain(UIGraphicsGetCurrentContext());
        testData = (RGBAPixel *)CGBitmapContextGetData(testContext);
    }
    UIGraphicsEndImageContext();
    
    RGBAPixel *referencePixelPtr = referenceData;
    RGBAPixel *testPixelPtr = testData;
    NSUInteger max = referenceImage.size.width * referenceImage.size.height;
    BOOL stop = NO;
    for (NSUInteger i = 0 ; i < max ; ++i) {
        block(referencePixelPtr++, testPixelPtr++, &stop);
        if (stop) {
            break;
        }
    }
    
    CGContextRelease(referenceContext);
    CGContextRelease(testContext);
}

@end
