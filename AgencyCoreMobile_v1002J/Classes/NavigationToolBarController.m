//
//  MessageNavgationViewController.m
//  AgencyCoreMobile_v1002
//
//  Created by Joy Tao on 3/20/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "NavigationToolBarController.h"
@interface NavigationToolBarController ()

@end

@implementation NavigationToolBarController

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navToolBar = [[UIToolbar alloc]init];
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    {
        self.navToolBar.frame = CGRectMake(0.0f, 0.0f, self.view.bounds.size.height, 44.0f);
        self.navToolBar.barStyle = UIBarStyleBlackTranslucent;
        self.navToolBar.frame = CGRectOffset(self.navToolBar.frame, 0.0f, self.view.bounds.size.width - self.navToolBar.frame.size.height - 20.0f);
    }
    else
    {
        self.navToolBar.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 44.0f);
        self.navToolBar.barStyle = UIBarStyleBlackTranslucent;
        self.navToolBar.frame = CGRectOffset(self.navToolBar.frame, 0.0f, self.view.frame.size.height - self.navToolBar.frame.size.height - 20.0f);
    }
    [self.view addSubview:self.navToolBar];

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];

//    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    self.navToolBar.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 44.0f);
    self.navToolBar.barStyle = UIBarStyleBlackOpaque;
    self.navToolBar.frame = CGRectOffset(self.navToolBar.frame, 0.0f, self.view.frame.size.height - self.navToolBar.frame.size.height );
}

- (void) receiveTestNotification:(NSNotification*)notification
{
    if ([[notification name]isEqualToString:@"TestNotification" ])
    {
        NSLog(@"MessageNavgationViewController receiveTestNotification");
        self.navToolBar.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 44.0f);
        self.navToolBar.frame = CGRectOffset(self.navToolBar.frame, 0.0f, self.view.frame.size.height - self.navToolBar.frame.size.height );
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
