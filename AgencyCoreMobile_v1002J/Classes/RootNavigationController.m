//
//  RootNavigationController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/4/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "RootNavigationController.h"
#import "LogInViewController.h"
#import "LockScreenViewController.h"
#import "KKPasscodeLock.h"
#import "InitialSlidingViewController.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController

- (void) displayLockedScreen
{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"HasLoggedIn"]== YES && [[KKPasscodeLock sharedLock] isPasscodeRequired])
    {
        LockScreenViewController * vcLocked = [[LockScreenViewController alloc]init];
        [self presentModalViewController:vcLocked animated:NO];
    }
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    UIViewController * vc;
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"HasLoggedIn"] == YES)
        vc = rootViewController;
    else
    {
        vc = [[UIViewController alloc]init];
        vc.view.backgroundColor = [UIColor whiteColor];
    }
    self = [super initWithRootViewController:vc];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationBarHidden = YES;
}

- (void) viewDidAppear:(BOOL)animated
{
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"HasLoggedIn"]== NO)
    {
        if (self.viewControllers != nil && self.viewControllers.count > 0)
        {
//            NSLog(@"rootviewcontroller exists!");
            NSMutableArray * viewcontrollers = [NSMutableArray arrayWithArray:self.viewControllers];
            [viewcontrollers removeAllObjects];
            
            UIViewController * vcBlank = [[UIViewController alloc]init];
            vcBlank.view.backgroundColor = [UIColor whiteColor];
            [viewcontrollers insertObject:vcBlank atIndex:0];
            
            self.viewControllers = viewcontrollers;
        }
        LogInViewController * vc = [[LogInViewController alloc]init];
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nc animated:YES completion:^{
            InitialSlidingViewController * vcHome = [[InitialSlidingViewController alloc]init];
            [self pushViewController:vcHome animated:NO];
        }];
        
    }
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification"  object:self];
    return YES;
}

- (BOOL) shouldAutorotate
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification"  object:self];
    return YES;
}

@end
