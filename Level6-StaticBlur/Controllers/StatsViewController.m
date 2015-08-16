#import "StatsViewController.h"
#import "ParallaxEffect.h"
#import "UIImage+ImageEffects.h"

@implementation StatsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.accessibilityLabel = @"Stats View";
    
    self.earnedBadgeLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.badges.count];
}

- (void)viewDidAppear:(BOOL)animated
{
    CGRect viewInPresentingViewBounds = [self.view convertRect:self.view.bounds toView:self.presentingViewController.view];
    
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 2.0);
    
    CGRect drawingRect = CGRectOffset(self.presentingViewController.view.bounds, -viewInPresentingViewBounds.origin.x, -viewInPresentingViewBounds.origin.y);
    
    [self.presentingViewController.view drawViewHierarchyInRect:drawingRect afterScreenUpdates:YES];
    
    UIImage *newBGImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImage *lightImage = [newBGImage applyExtraLightEffect];
    
    self.backgroundView.image = lightImage;
}

- (IBAction) goodJob:(id)sender;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
