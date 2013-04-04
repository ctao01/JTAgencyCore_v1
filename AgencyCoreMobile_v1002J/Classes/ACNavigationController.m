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
    self = [super initWithRootViewController:rootViewController];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    if (DEVICE_VERSION < 6.0f) [self shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortrait];
    else [self shouldAutorotate];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}

- (BOOL) shouldAutorotate
{
    NSLog(@"shouldAutorotate");
    return NO;
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
