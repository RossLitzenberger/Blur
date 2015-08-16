#import <UIKit/UIKit.h>

@interface StatsViewController : UIViewController

- (IBAction) goodJob:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *badgesView;
@property (strong, nonatomic) IBOutlet UILabel *earnedBadgeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundView;
@property (strong, nonatomic) NSArray *badges;

@end
