//
//  ViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/20/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "RootViewController.h"
#import "InitialSlidingViewController.h"
#import "LogInViewController.h"
#import "LockScreenViewController.h"
//#import "ABPadLockScreenController.h"
#import "KKPasscodeLock.h"

#define AGENCYCORE_LOGIN_VIEW_TAG 20001
#define AGENCYCORE_LOCKEDSCREEN_VIEW_TAG 30001

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize currentViewController = _currentViewController;

- (void) displayScreen:(BOOL)existUser
{
//    existUser = [[NSUserDefaults standardUserDefaults]boolForKey:@"HasLoggedIn"];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        NSLog(@"%@",NSStringFromCGRect(self.view.frame));
        
    UIView * view = [self.view viewWithTag:AGENCYCORE_LOGIN_VIEW_TAG];
    if ([view respondsToSelector:@selector(removeFromSuperview)])
        [view removeFromSuperview];
    
    if (existUser == YES)
    {
        _currentViewController = [[InitialSlidingViewController alloc]init];
        _currentViewController.view.frame = CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    else
    {
        LogInViewController * vc = [[LogInViewController alloc]init];
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:vc];
        nc.navigationBar.barStyle = UIBarStyleBlackOpaque;
        _currentViewController = (UINavigationController*)nc;
        _currentViewController.view.frame = CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    _currentViewController.view.tag = AGENCYCORE_LOGIN_VIEW_TAG;
    _currentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
   
    if ([self.view respondsToSelector:@selector(addSubview:)])
        [self.view addSubview:_currentViewController.view];
}

- (void) addLockedScreen
{
   if ([[NSUserDefaults standardUserDefaults]boolForKey:@"HasLoggedIn"]== YES && [[KKPasscodeLock sharedLock] isPasscodeRequired])
   {
       NSLog(@"Locked");
//       self.lockedViewController = [[LockScreenViewController alloc]initWithDelegate:self];
//       self.lockedViewController.pin = @"2222";
//       self.lockedViewController.attemptLimit = 0.0f;
       self.lockedViewController = [[LockScreenViewController alloc]init];
       
       self.lockedViewController.view.frame = [[UIScreen mainScreen]bounds];
       self.lockedViewController.view.tag = AGENCYCORE_LOCKEDSCREEN_VIEW_TAG;
       [self.view addSubview:self.lockedViewController.view];
   }
}

- (void) removeLockedScreen
{
    NSLog(@"removeLockedScreen");
    UIView * view = [self.view viewWithTag:AGENCYCORE_LOCKEDSCREEN_VIEW_TAG];
    if ([view respondsToSelector:@selector(removeFromSuperview)])
        [view removeFromSuperview];
}

- (id) init
{
    self = [super init];
    return self; 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self displayScreen:[[NSUserDefaults standardUserDefaults]boolForKey:@"HasLoggedIn"]];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    return YES;
//}
//
- (BOOL) shouldAutorotate
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification"  object:self];
    return YES;
}

@end
