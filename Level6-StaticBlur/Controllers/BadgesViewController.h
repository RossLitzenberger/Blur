#import <UIKit/UIKit.h>

@interface BadgesViewController : UITableViewController <UIViewControllerTransitioningDelegate, NSURLSessionDelegate>
@property (strong, nonatomic) NSArray *badges;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *myInteractiveTransition;
@property (assign, nonatomic) BOOL interactive;
@property (strong, nonatomic) NSURLSession *imageSession;
@end
