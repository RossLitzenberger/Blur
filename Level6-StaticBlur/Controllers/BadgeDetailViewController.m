#import "BadgeDetailViewController.h"

@interface BadgeDetailViewController ()
+ (NSOperationQueue *)queue;
@end

@implementation BadgeDetailViewController

-(void) viewWillAppear:(BOOL)animated;
{
    self.title = _badge[@"name"];
}

+ (NSOperationQueue *)queue;
{
    static NSOperationQueue *downloadQueue = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadQueue = [[NSOperationQueue alloc] init];
    });
    
    return downloadQueue;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_badge[@"course_url"]]];
    
    [self.courseView loadRequest:request];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *badgeURL = [NSURL URLWithString:_badge[@"badge"]];
    
    NSURLRequest *badgeRequest = [NSURLRequest requestWithURL:badgeURL];
    
    [NSURLConnection sendAsynchronousRequest:badgeRequest queue:[[self class] queue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.badgeView.image = [UIImage imageWithData:data];
        }];
    }];
}

@end
