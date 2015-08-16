#import "AppDelegate.h"
#import "BadgesViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    BadgesViewController *badgesVC = [[BadgesViewController alloc] initWithStyle:UITableViewStylePlain];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:badgesVC];
    
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
