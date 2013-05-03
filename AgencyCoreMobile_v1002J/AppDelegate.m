//
//  AppDelegate.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/20/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "InitialSlidingViewController.h"

@interface AppDelegate ()
@property (nonatomic , strong) RootViewController * viewController;

@end

@implementation AppDelegate

- (void) displayScreen:(BOOL)existUser
{
    [self.viewController displayScreen:existUser];
}

- (void) removeLockedScreen
{
    NSLog(@"removed");
    [self.viewController removeLockedScreen];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
//    self.viewController = [[RootViewController alloc]init];
////    self.window.rootViewController = self.viewController;
//    [self.viewController displayScreen:[[NSUserDefaults standardUserDefaults]boolForKey:@"HasLoggedIn"]];
    InitialSlidingViewController * rv = [[InitialSlidingViewController alloc]init];
    
    self.navigation = [[RootNavigationController alloc]initWithRootViewController:rv];
    self.window.rootViewController = self.navigation;
    
    // Initialize TestFlight
    [TestFlight takeOff:TESTFLIGHT_TEAM_TOKEN];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"applicationWillResignActive");

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"applicationDidEnterBackground");

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"applicationDidBecomeActive");
//    self.navigation = [[UINavigationController alloc]initWithRootViewController:vc];
//    self.window.rootViewController = self.navigation;
//    [self.viewController showLockedScreenForExistingUser:[[NSUserDefaults standardUserDefaults]boolForKey:@"HasLoggedIn"]];
//    [self.viewController addLockedScreen];
    [self.navigation displayLockedScreen];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSUInteger) application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskAll;
}

@end
