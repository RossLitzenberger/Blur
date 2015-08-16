#import "SideDismissalAnimated.h"

@implementation SideDismissalAnimated

- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}

- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        fromVC.view.frame = CGRectMake(
                                       CGRectGetWidth(initialFrame),
                                       CGRectGetMinY(initialFrame),
                                       CGRectGetWidth(initialFrame),
                                       CGRectGetHeight(initialFrame)
                                       );
        
    } completion:^(BOOL finished) {
        // TODO: pass in NO if the transition was cancelled, YES if it was finished
        [transitionContext completeTransition:YES];
    }];
}

@end
