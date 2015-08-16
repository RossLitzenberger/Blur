#import "SideDismissalTransition.h"

@implementation SideDismissalTransition


- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}

- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:0 animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.8 animations:^{
            CGRect currentFrame = CGRectMake(
                                             -60,
                                             CGRectGetMinY(initialFrame),
                                             CGRectGetWidth(initialFrame),
                                             CGRectGetHeight(initialFrame)
                                             );
            
            fromVC.view.frame = currentFrame;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            CGRect currentFrame = CGRectMake(
                                             CGRectGetWidth(initialFrame) + 16,
                                             CGRectGetMinY(initialFrame),
                                             CGRectGetWidth(initialFrame),
                                             CGRectGetHeight(initialFrame)
                                             );
            
            fromVC.view.frame = currentFrame;
        }];
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
