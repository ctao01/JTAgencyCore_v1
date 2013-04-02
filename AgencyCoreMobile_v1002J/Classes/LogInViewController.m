//
//  LogInViewController.m
//  AgencyCoreMobile_v1002
//
//  Created by Joy Tao on 3/18/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "LogInViewController.h"
#import "LoginFieldView.h"
#import "InitialSlidingViewController.h"
#import "AppDelegate.h"

#define LOGINFIELD_VIEW_TAG 6001
#define LOGO_VIEW_TAG 6002
#define SIGN_IN_BTN_TAG 6003
#define PASSWORD_LABEL_TAG 6004
#define PASSWORD_BTN_TAG 6004

@interface LogInViewController ()
{
    LoginFieldView * loginFieldView;
    BOOL moved;
}

@end

@implementation LogInViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        UIImage * logoImg = [UIImage imageNamed:@"axxess_logo"];
        UIImageView * logoView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 20.0f, logoImg.size.width, logoImg.size.height)];
        logoView.backgroundColor = [UIColor clearColor];
         logoView.center = CGPointMake(self.view.center.x, logoView.center.y);
        [logoView setImage:logoImg];
        [self.view addSubview:logoView];
        
        loginFieldView = [[LoginFieldView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 280.0f, 88.0f) andRadius:6.0f];
        loginFieldView.center = CGPointMake(self.view.center.x, 180.0f);
        loginFieldView.parentViewController = self;
        
        [self.view addSubview:loginFieldView];
        
        UIButton * btnLogIn = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLogIn.frame = CGRectMake(0.0f, 0.0f, 280.0f, 44.0f);
        btnLogIn.center = CGPointMake(self.view.center.x, 260.0f);
        [btnLogIn setBackgroundImage:[[UIImage imageNamed:@"btn_Red"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 0.0f, 6.0f)]forState:UIControlStateNormal];
        [btnLogIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnLogIn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0f]];
        [btnLogIn setTitle:@"Sign In" forState:UIControlStateNormal];
        [btnLogIn addTarget:self action:@selector(userSignIn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnLogIn];
        
        UILabel * pwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 20.0f)];
        [pwdLabel setFrame:CGRectOffset(pwdLabel.frame, 0.0f, 290.0f)];
        [pwdLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f]];
        [pwdLabel setTextColor:[UIColor blackColor]];
        [pwdLabel setText:@"Forgot Password ?"];
        [pwdLabel setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:pwdLabel];
        
        UIButton * pwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        pwdBtn.frame = CGRectMake(pwdLabel.frame.origin.x, pwdLabel.frame.origin.y, pwdLabel.frame.size.width, pwdLabel.frame.size.height);
        [pwdBtn addTarget:self action:@selector(userForgotPwd) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:pwdBtn];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"Log In";
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];

}

- (void) receiveTestNotification:(NSNotification*)notification
{
//    UIView * view1 = [self.view viewWithTag:LOGINFIELD_VIEW_TAG];
//    UIView * view2 = [self.view viewWithTag:LOGO_VIEW_TAG];
//    UIView * view3 = [self.view viewWithTag:SSI];
//    UIView * view4 = [self.view viewWithTag:LOGO_VIEW_TAG];

    
    if ([[notification name]isEqualToString:@"TestNotification" ])
    {
        for (UIView * subview in self.view.subviews)
            subview.center = CGPointMake(self.view.center.x, subview.center.y);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- 

- (void) userSignIn
{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"HasLoggedIn"];
    AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [delegate displayScreen:[[NSUserDefaults standardUserDefaults]boolForKey:@"HasLoggedIn"]];
}

- (void) userForgotPwd
{
    NSLog(@"userForgotPwd");
}

#pragma mark - 

- (void) animatedViewUp:(BOOL)UP
{
    moved = UP;
    const int movementDistance = 120.0f;
    
    int movement = (UP ? -movementDistance : movementDistance);
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.view.frame = CGRectOffset(self.view.frame, 0.0f, movement);
    }
                     completion:^(BOOL successful){}];
    
}

#pragma mark -

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    if (iPHONE_UI)
    {
        if (textField.tag == 2001 && !moved)[self animatedViewUp:YES];
        else if (textField.tag == 2002 && !moved) [self animatedViewUp:YES];
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
     if (textField.tag == 2002)
     {
         [textField resignFirstResponder];
         if (iPHONE_UI)[self animatedViewUp:NO];
     }
     else if (textField.tag == 2001)
    {
        UITextField * tf = (UITextField*)[loginFieldView viewWithTag:2002];
        [tf becomeFirstResponder];

    }
    return YES;
}

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

//- (void) textFieldDidEndEditing:(UITextField *)textField
//{
//    if (textField.tag == 2002 && moved) 
//}

@end
