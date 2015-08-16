#import "SideTransition.h"

@implementation SideTransition

- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}

- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] addSubview:toVC.view];
    
    CGRect fullFrame = [transitionContext initialFrameForViewController:fromVC];
    
    toVC.view.frame = CGRectMake(fullFrame.size.width + 16, 20, fullFrame.size.width - 40, fullFrame.size.height - 40);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:0.6f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        toVC.view.frame = CGRectMake(20, 20, fullFrame.size.width - 40, fullFrame.size.height - 40);
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
