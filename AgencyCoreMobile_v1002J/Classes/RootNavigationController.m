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

@interface RootNavigationController ()

@end

@implementation RootNavigationController

- (void) displayLockedScreen
{
    if ([[KKPasscodeLock sharedLock] isPasscodeRequired])
    {
        LockScreenViewController * vcLocked = [[LockScreenViewController alloc]init];
        [self presentModalViewController:vcLocked animated:NO];
    }
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    NSLog(@"RootNavigationController-init");
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
    [super viewDidAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"HasLoggedIn"]== NO)
    {
        LogInViewController * vc = [[LogInViewController alloc]init];
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentModalViewController:nc animated:YES];
    }
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
