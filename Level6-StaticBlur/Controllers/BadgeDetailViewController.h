#import <UIKit/UIKit.h>

@interface BadgeDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *badgeView;
@property (strong, nonatomic) IBOutlet UIWebView *courseView;
@property (strong, nonatomic) IBOutlet UILabel *titleView;

@property (strong, nonatomic) NSDictionary *badge;

@end
