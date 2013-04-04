//
//  UINavigationController+Rotation.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/4/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "UINavigationController+Rotation.h"

@implementation UINavigationController (Rotation)

- (BOOL)shouldAutorotate {
    return YES;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
