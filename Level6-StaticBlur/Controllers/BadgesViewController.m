#import "BadgesViewController.h"
#import "BadgeDetailViewController.h"
#import "StatsViewController.h"
#import "SideTransition.h"
#import "SideDismissalTransition.h"
#import "SideDismissalAnimated.h"

static NSString *const badgesURL = @"http://www.codeschool.com/users/rubymaverick.json";

@implementation BadgesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"rubymaverick's Badges";
        
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(displayStats:)];
        
        barButton.accessibilityLabel = @"Display Stats";
        
        self.navigationItem.rightBarButtonItem = barButton;
        
        NSURLSessionConfiguration *imageConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        imageConfig.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
        imageConfig.HTTPMaximumConnectionsPerHost = 10;
        
        self.imageSession = [NSURLSession
                             sessionWithConfiguration:imageConfig
                             delegate:self
                             delegateQueue:nil];
        
        self.imageSession.sessionDescription = @"Session for requesting badge images";
    }
    return self;
}

// Present the StatsViewController as a modal
- (void) displayStats:(id)sender{
    
    StatsViewController *statsVC = [[StatsViewController alloc] init];
    statsVC.badges = _badges;
    
    statsVC.modalPresentationStyle = UIModalPresentationCustom;
    statsVC.transitioningDelegate = self;
    
    [self presentViewController:statsVC animated:YES completion:^{
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [statsVC.view addGestureRecognizer:gesture];
    }];
}

- (void) handleGesture: (UIPanGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            self.interactive = YES;
            
            [self dismissViewControllerAnimated:YES completion:^{
                self.interactive = NO;
            }];
            
            break;
        }
        case UIGestureRecognizerStateChanged:{
            UIView *view = gesture.view.superview;
            CGPoint translation = [gesture translationInView:view];
            CGFloat percentTransitioned = (translation.x / (CGRectGetWidth(view.frame)));
            
            [self.myInteractiveTransition updateInteractiveTransition:percentTransitioned];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            
            if (self.myInteractiveTransition.percentComplete > 0.25) {
                [self.myInteractiveTransition finishInteractiveTransition];
            }else{
                [self.myInteractiveTransition cancelInteractiveTransition];
            }
            
            break;
        }
        case UIGestureRecognizerStateCancelled:
        {
            [self.myInteractiveTransition cancelInteractiveTransition];
            
            break;
        }
        default:
            break;
    }
}

- (id <UIViewControllerInteractiveTransitioning>) interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    if (self.interactive) {
        self.myInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        return self.myInteractiveTransition;
    }
    
    return nil;
}

- (id <UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented
                                                                    presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    SideTransition *transition = [[SideTransition alloc] init];
    
    return transition;
}

- (id <UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed
{
    id <UIViewControllerAnimatedTransitioning> transition;
    
    if (self.interactive) {
        transition = [[SideDismissalAnimated alloc] init];
    }else{
        transition = [[SideDismissalTransition alloc] init];
    }
    
    
    return transition;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"rubymaverick" ofType:@"json"];

    self.badges = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jsonPath]
                                                  options:0
                                                    error:nil][@"badges"];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _badges.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *badge = self.badges[indexPath.row];

    cell.textLabel.text = badge[@"name"];
    
    cell.imageView.image = [UIImage imageNamed:@"placeholder"];
    
    NSURL *secureBadgeURL = [NSURL URLWithString:badge[@"badge"]];
    NSURL *badgeURL = [[NSURL alloc] initWithScheme:@"http" host:secureBadgeURL.host path:secureBadgeURL.path];
    
    NSURLRequest *badgeRequest = [NSURLRequest requestWithURL:badgeURL];
    
    NSURLSessionDataTask *task = [self.imageSession dataTaskWithRequest:badgeRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                cell.imageView.image = [UIImage imageWithData:data];
            }];
        }
    }];
    
    [task resume];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSDictionary *badge = _badges[indexPath.row];
    
    BadgeDetailViewController *badgeDetail = [[BadgeDetailViewController alloc] init];
    badgeDetail.badge = badge;
    
    [self.navigationController pushViewController:badgeDetail animated:YES];
}


@end
