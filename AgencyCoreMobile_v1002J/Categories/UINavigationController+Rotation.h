//
//  UINavigationController+Rotation.h
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/4/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Rotation)

- (BOOL) shouldAutorotate;
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;

@end
