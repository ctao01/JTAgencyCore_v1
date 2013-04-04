//
//  ACNavigationController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/3/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "ACNavigationController.h"

@interface ACNavigationController ()

@end

@implementation ACNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        NSLog(@"YES");
        [self shouldAutorotate];
    }
    else
        NSLog(@"NO");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}

- (BOOL) shouldAutorotate
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Rotation_Notification"  object:self];
//    return YES;
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) return YES;
    else return NO;
}

- (NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation
{
    if (iPHONE_UI) return UIInterfaceOrientationPortrait;
    else if (iPAD_UI) return UIInterfaceOrientationLandscapeRight;
    else return UIInterfaceOrientationPortrait;
}


@end
