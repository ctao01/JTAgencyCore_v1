//
//  LockScreenViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/25/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "LockScreenViewController.h"
//#import "ABPadLockScreenController.h"
#import "KKPasscodeViewController.h"
#import "AppDelegate.h"

@interface LockScreenViewController()<KKPasscodeViewControllerDelegate>
@property (nonatomic, strong) KKPasscodeViewController * pinScreen;

@end

@implementation LockScreenViewController

- (id) init
{
    if (!self.pinScreen)
    {
        self.pinScreen = [[KKPasscodeViewController alloc] initWithNibName:nil bundle:nil];
        self.pinScreen.delegate = self;
        self.pinScreen.mode = KKPasscodeModeEnter;
    }
    self = [super initWithRootViewController:self.pinScreen];
    return self;
        
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"Passcode";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didPasscodeEnteredCorrectly:(KKPasscodeViewController*)viewController
{
//    AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
//    [delegate removeLockedScreen];
    [self dismissModalViewControllerAnimated:YES];

}


- (void) unlockWasSuccessful
{
//    AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
//    [delegate removeLockedScreen];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)unlockWasUnsuccessful:(NSString *)falsePin afterAttemptNumber:(NSInteger)attemptNumber
{
    NSLog(@"unlockWasUnsuccessful");
}

- (void)unlockWasCancelled
{
    NSLog(@"unlockWasCancelled");

}

- (void) askForHelps
{
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Forget Passcode" message:@"To reset your passcode, enter your email address and we'll send you instructions on how to reset a passcode" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
    [alertView show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        if ([alertView.title isEqualToString:@"Forget Passcode"])
        {
            UIAlertView * confirmView = [[UIAlertView alloc]initWithTitle:@"Confirm" message:@"We'll send you the instruction on how to reset a new passcode, thank you." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [confirmView show];
        }
    }
}

@end
