//
//  FirstTopViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "HomeViewController.h"
#import "LogInViewController.h"
#import <QuartzCore/QuartzCore.h>

#define AGENCYCORE_MESSAGE_BUTTON_TAG 7001
#define AGENCYCORE_SCHEDULE_BUTTON_TAG 7002

#define AGENCYCORE_BADGE_ICON_VIEW_TAG 7005
#define AGENCYCORE_BADGE_ICON_LABEL_TAG 7006


@interface HomeViewController ()

//- (void) setupMessagesBadgeNumberLabel:(UILabel*)label onBadgeImageView:(UIImageView*)image;
//- (void) setupTasksBadgeNumberLabel:(UILabel*)label onBadgeImageView:(UIImageView*)image;
@end

@implementation HomeViewController

#pragma mark - 

- (void) setupBadgeNumberWithIdentifier:(NSString*)identifier withFrame:(CGRect)frame
{
    UIView * view = [[UIView alloc]initWithFrame:UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(20.0f, 250.0f, 10.0f, 20.0f))];
    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, 24.0f, 24.0f)];
    [view setBackgroundColor:[UIColor colorWithRed:164.0/255.0f green:26.0f/255.0f blue:54.0f/255.0f alpha:1.0f]];
    [view.layer setCornerRadius:4.0f];
    view.tag = AGENCYCORE_BADGE_ICON_VIEW_TAG;
//
    UILabel * badgeLabel = [[UILabel alloc]initWithFrame:view.frame];
    [badgeLabel setTextColor:[UIColor whiteColor]];
    [badgeLabel setBackgroundColor:[UIColor clearColor]];
    [badgeLabel setFont:ACFontDefaultBold16];
    if ([identifier isEqualToString:@"message"])[badgeLabel setText:@"3"];
    else if ([identifier isEqualToString:@"schedule"]) [badgeLabel setText:@"15"];
    [badgeLabel setTextAlignment:NSTextAlignmentCenter];
    badgeLabel.tag = AGENCYCORE_BADGE_ICON_LABEL_TAG;

    [self.view addSubview:view];
    [self.view addSubview:badgeLabel];

}

- (UIView*)setupBadgeViewWithIdentifier:(NSString*)identifier withFrame:(CGRect)frame
{
    UIView * view = [[UIView alloc]initWithFrame:UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(20.0f, 250.0f, 10.0f, 20.0f))];
    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, 24.0f, 24.0f)];
    [view setBackgroundColor:[UIColor colorWithRed:164.0/255.0f green:26.0f/255.0f blue:54.0f/255.0f alpha:1.0f]];
    [view.layer setCornerRadius:4.0f];
    view.tag = AGENCYCORE_BADGE_ICON_VIEW_TAG;
    //
    UILabel * badgeLabel = [[UILabel alloc]initWithFrame:view.bounds];
    [badgeLabel setTextColor:[UIColor whiteColor]];
    [badgeLabel setBackgroundColor:[UIColor clearColor]];
    [badgeLabel setFont:ACFontDefaultBold16];
    if ([identifier isEqualToString:@"message"])[badgeLabel setText:@"3"];
    else if ([identifier isEqualToString:@"schedule"]) [badgeLabel setText:@"15"];
    [badgeLabel setTextAlignment:NSTextAlignmentCenter];
    badgeLabel.tag = AGENCYCORE_BADGE_ICON_LABEL_TAG;
    
    [view addSubview:badgeLabel];
    return view;
    
}

#pragma mark -

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
  // You just need to set the opacity, radius, and color.
  self.view.layer.shadowOpacity = 0.75f;
  self.view.layer.shadowRadius = 10.0f;
  self.view.layer.shadowColor = [UIColor blackColor].CGColor;
  
  if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
    self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
  }
  [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIView * view1 = [self.view viewWithTag:AGENCYCORE_MESSAGE_BUTTON_TAG];
    if (view1)
    {
        UIView * msgBadge = [self setupBadgeViewWithIdentifier:@"message" withFrame:view1.frame];
        msgBadge.tag  = 7008;
        [self.view addSubview:msgBadge];

    }
    UIView * view2 = [self.view viewWithTag:AGENCYCORE_SCHEDULE_BUTTON_TAG];
    if (view2 )
    {
        UIView * scheduleBadge = [self setupBadgeViewWithIdentifier:@"schedule" withFrame:view2.frame];
        scheduleBadge.tag = 7009;
        [self.view addSubview:scheduleBadge];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];

}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    if (iPHONE_UI && UserInterface_Portrait)
    {
        if (self.view.frame.size.height >= 548.0f)
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"agencycore_bg-568h"]];
        else
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"agencycore_bg"]];
    }
    else if (iPAD_UI && UserInterface_Portrait)
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"agencycore_bg_ipad"]];
    else if (iPAD_UI && UserInterface_Landscape)
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"agencycore_bg_landscape_ipad"]];
    
    
    float button_position_y;
    if (iPHONE_UI && UserInterface_Portrait) button_position_y = self.view.bounds.size.height * 4/7 - 44.0f;
    else if (iPAD_UI && UserInterface_Portrait) button_position_y = self.view.bounds.size.height * 4/5 - 44.0f;
    else if (UserInterface_Landscape) button_position_y = self.view.bounds.size.width - 66.0f;
    else button_position_y = 0.0f;
    
    UIButton * btnMsg = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * imgMsg = [UIImage imageNamed:@"button_messages"];
    [btnMsg setBackgroundImage:imgMsg forState:UIControlStateNormal];
    [btnMsg setFrame:CGRectMake(0.0f, self.view.frame.origin.y + button_position_y , imgMsg.size.width, imgMsg.size.height)];

    if (UserInterface_Portrait) [btnMsg setCenter:CGPointMake(self.view.center.x, btnMsg.center.y)];
    else if (UserInterface_Landscape) [btnMsg setCenter:CGPointMake(self.view.frame.size.height / 4, btnMsg.center.y)];

    [btnMsg addTarget:self action:@selector(gotoMyMessages) forControlEvents:UIControlEventTouchUpInside];
    [btnMsg setTag:AGENCYCORE_MESSAGE_BUTTON_TAG];
    [self.view addSubview:btnMsg];
    
    UIButton * btnSchedule = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * imgSchedule = [UIImage imageNamed:@"button_schedule"];
    btnSchedule.frame = btnMsg.frame;
    [btnSchedule setBackgroundImage:imgSchedule forState:UIControlStateNormal];
    if (UserInterface_Portrait) [btnSchedule setFrame:CGRectOffset(btnSchedule.frame, 0.0f, btnSchedule.frame.size.height)];
    else if (UserInterface_Landscape) [btnSchedule setFrame:CGRectOffset(btnSchedule.frame, self.view.frame.size.height /2 , 0.0f)];
    [btnSchedule addTarget:self action:@selector(gotoMySchedule) forControlEvents:UIControlEventTouchUpInside];
    [btnSchedule setTag:AGENCYCORE_SCHEDULE_BUTTON_TAG];
    [self.view addSubview:btnSchedule];
    
}

- (void) receiveTestNotification:(NSNotification*)notification
{
    NSLog(@"HomeViewController receiveTestNotification");
    
    UIView * view1 = [self.view viewWithTag:AGENCYCORE_MESSAGE_BUTTON_TAG];
    UIView * view2 = [self.view viewWithTag:AGENCYCORE_SCHEDULE_BUTTON_TAG];
    UIView * subview1 = [self.view viewWithTag:7008];
    UIView * subview2 = [self.view viewWithTag:7009];
    
    if ([[notification name]isEqualToString:@"TestNotification" ])
    {
        if (iPHONE_UI && UserInterface_Portrait)
        {
            if (self.view.frame.size.height >= 548.0f)
                self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"agencycore_bg-568h"]];
            else
                self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"agencycore_bg"]];
        }
        else if (iPAD_UI && UserInterface_Portrait)
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"agencycore_bg_ipad"]];
        else if (iPAD_UI && UserInterface_Landscape)
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"agencycore_bg_landscape_ipad"]];
        float button_position_y;
        if (iPHONE_UI && UserInterface_Portrait) button_position_y = self.view.bounds.size.height * 4/7;
        else if (iPAD_UI && UserInterface_Portrait) button_position_y = self.view.frame.size.height * 4/5;
        else if (UserInterface_Landscape) button_position_y = self.view.frame.size.height - 66.0f;
        else button_position_y = 0.0f;
        
        [view1 setFrame:CGRectMake(0.0f, self.view.frame.origin.y + button_position_y , view1.frame.size.width, view1.frame.size.height)];
        if (UserInterface_Portrait) [view1 setCenter:CGPointMake(self.view.center.x, view1.center.y)];
        else if (UserInterface_Landscape) [view1 setCenter:CGPointMake(self.view.frame.size.width / 4, view1.center.y)];
        subview1.frame = UIEdgeInsetsInsetRect(view1.frame, UIEdgeInsetsMake(20.0f, 250.0f, 10.0f, 20.0f));
        [subview1 setFrame:CGRectMake(subview1.frame.origin.x, subview1.frame.origin.y, 24.0f, 24.0f)];
        
        view2.frame = view1.frame;
        if (UserInterface_Portrait) [view2 setFrame:CGRectOffset(view2.frame, 0.0f, view1.frame.size.height)];
        else if (UserInterface_Landscape) [view2 setFrame:CGRectOffset(view2.frame, self.view.frame.size.width /2 , 0.0f)];
        subview2.frame = UIEdgeInsetsInsetRect(view2.frame, UIEdgeInsetsMake(20.0f, 250.0f, 10.0f, 20.0f));
        [subview2 setFrame:CGRectMake(subview2.frame.origin.x, subview2.frame.origin.y, 24.0f, 24.0f)];
        
        /*
        view1.center = CGPointMake(self.view.center.x, view1.center.y);
        if (view1)
        {
            subview1.frame = UIEdgeInsetsInsetRect(view1.frame, UIEdgeInsetsMake(20.0f, 250.0f, 10.0f, 20.0f));
             [subview1 setFrame:CGRectMake(subview1.frame.origin.x, subview1.frame.origin.y, 24.0f, 24.0f)];
        }
//        if (view1) [self setupBadgeNumberWithIdentifier:@"message" withFrame:view1.frame];
        view2.center = CGPointMake(self.view.center.x, view2.center.y);
//        if (view2 )[self setupBadgeNumberWithIdentifier:@"schedule" withFrame:view2.frame];
        if (view2 )
        {
            subview2.frame = UIEdgeInsetsInsetRect(view2.frame, UIEdgeInsetsMake(20.0f, 250.0f, 10.0f, 20.0f));
            [subview2 setFrame:CGRectMake(subview2.frame.origin.x, subview2.frame.origin.y, 24.0f, 24.0f)];
        }*/
    }
}


#pragma mark - Temp

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)revealUnderRight:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECLeft];
}

- (void) gotoMyMessages
{
    self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Messages"];

}

- (void) gotoMySchedule
{
    self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Schedule"];
    
}

- (void) userLogin
{
    LogInViewController * vc = [[LogInViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end