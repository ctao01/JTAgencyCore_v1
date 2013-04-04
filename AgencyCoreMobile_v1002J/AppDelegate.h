//
//  AppDelegate.h
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/20/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong , nonatomic )RootNavigationController * navigation;

- (void) displayScreen:(BOOL)existUser;
- (void) removeLockedScreen;

@end
