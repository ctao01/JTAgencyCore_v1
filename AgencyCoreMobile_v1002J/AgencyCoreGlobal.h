//
//  AgencyCoreGlobal.h
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/1/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "UIButton+Additons.h"
#import "UILabel+Additons.h"
#import "NSString+Additions.h"
#import "NSDate+Additions.h"
#import "UIImageView+Additions.h"
#import "NSDictionary+Additions.h"
#import "UINavigationController+Rotation.h"

#ifndef AgencyCoreMobile_v1002J_AgecyCoreGlobal_h
#define AgencyCoreMobile_v1002J_AgecyCoreGlobal_h

#define iPAD_UI (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define iPHONE_UI (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define DEVICE_ORIENTATION [[UIDevice currentDevice]orientation]
#define DEVICE_LANDSCAPE (DEVICE_ORIENTATION == UIDeviceOrientationLandscapeLeft || DEVICE_ORIENTATION == UIDeviceOrientationLandscapeRight)
#define DEVICE_PORTRAIT (DEVICE_ORIENTATION == UIDeviceOrientationPortrait || DEVICE_ORIENTATION == UIDeviceOrientationPortraitUpsideDown)

#define UserInterface_Oreientation [[UIApplication sharedApplication]statusBarOrientation]
//#define UserInterface_Oreientation [[UIApplication sharedApplication]statusBarOrientation]
#define UserInterface_Landscape (UserInterface_Oreientation == UIInterfaceOrientationLandscapeLeft || UserInterface_Oreientation == UIInterfaceOrientationLandscapeRight)
#define UserInterface_Portrait (UserInterface_Oreientation == UIInterfaceOrientationPortrait || UserInterface_Oreientation == UIInterfaceOrientationPortraitUpsideDown)

#define DEVICE_VERSION  [[[UIDevice currentDevice]systemVersion] floatValue]

#define Bounds_Screen  [[UIScreen mainScreen]bounds]
#define width(frame) frame.size.width
#define height(frame) frame.size.height
#define origin_x(frame) frame.origin.x
#define origin_y(frame) frame.origin.y


// Constant
// ACTableViewController.h
#define REFRESH_HEADER_HEIGHT 52.0f
#define LOADMORE_FOOTER_HEIGHT 52.0f
#define UISEARCH_BAR_HEIGHT 44.0f
#define UINAVIGATION_BAR_HEIGHT 44.0f


// UIColor
#define ACColorRed [UIColor colorWithRed:164.0/255.0 green:26.0f/255.0 blue:54.0f/255.0 alpha:1.0]
#define ACColorTaskMissedRed [UIColor colorWithRed:178.0f/255.0 green:14.0f/255.0 blue:14.0f/255.0 alpha:1.0f]
#define ACColorTaskCompletedGreen [UIColor colorWithRed:62.0f/255.0 green:161.0f/255.0 blue:35.0f/255.0 alpha:1.0f]
#define ACColorTaskScheduledBlue [UIColor colorWithRed:62.0f/255.0 green:121.0f/255.0 blue:156.0f/255.0 alpha:1.0f]
#define ACColorTaskScheduledMultiplePurple [UIColor colorWithRed:97.0f/255.0 green:63.0f/255.0 blue:186.0f/255.0 alpha:1.0f]

#define ACColorMenuSeparatorGray [UIColor colorWithRed:70.0f/255.0 green:70.0f/255.0 blue:70.0f/255.0 alpha:0.4f]
#define ACColorGray80 [UIColor colorWithRed:80.0f/255.0 green:80.0f/255.0 blue:80.0f/255.0 alpha:1.0f]
#define ACColorGray80Alpha [UIColor colorWithRed:80.0f/255.0 green:80.0f/255.0 blue:80.0f/255.0 alpha:0.5f]


#define ACColorSystemBlue [UIColor colorWithRed:82.0f/255.0 green:102.0f/255.0 blue:145.0f/255.0 alpha:1.0f]

// UIFont
#define ACFontDefault8                      [UIFont fontWithName:@"HelveticaNeue" size:8.0f]
#define ACFontDefaultBold8                  [UIFont fontWithName:@"HelveticaNeue-Bold" size:8.0f]
#define ACFontDefault9                      [UIFont fontWithName:@"HelveticaNeue" size:9.0f]
#define ACFontDefaultBold9                  [UIFont fontWithName:@"HelveticaNeue-Bold" size:9.0f]
#define ACFontDefault10                     [UIFont fontWithName:@"HelveticaNeue" size:10.0f]
#define ACFontDefaultBold10                 [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f]
#define ACFontDefault11                     [UIFont fontWithName:@"HelveticaNeue" size:11.0f]
#define ACFontDefaultBold11                 [UIFont fontWithName:@"HelveticaNeue-Bold" size:11.0f]
#define ACFontDefault12                     [UIFont fontWithName:@"HelveticaNeue" size:12.0f]
#define ACFontDefaultBold12                 [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f]
#define ACFontDefault13                     [UIFont fontWithName:@"HelveticaNeue" size:13.0f]
#define ACFontDefaultBold13                 [UIFont fontWithName:@"HelveticaNeue-Bold" size:13.0f]
#define ACFontDefault14                     [UIFont fontWithName:@"HelveticaNeue" size:14.0f]
#define ACFontDefaultBold14                 [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0f]
#define ACFontDefault15                     [UIFont fontWithName:@"HelveticaNeue" size:15.0f]
#define ACFontDefaultBold15                 [UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f]
#define ACFontDefault16                     [UIFont fontWithName:@"HelveticaNeue" size:16.0f]
#define ACFontDefaultBold16                 [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f]
#define ACFontDefault18                     [UIFont fontWithName:@"HelveticaNeue" size:18.0f]
#define ACFontDefaultBold18                 [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f]
#define ACFontDefault20                     [UIFont fontWithName:@"HelveticaNeue" size:20.0f]
#define ACFontDefaultBold20                 [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f]
#define ACFontDefault22                     [UIFont fontWithName:@"HelveticaNeue" size:22.0f]
#define ACFontDefaultBold22                 [UIFont fontWithName:@"HelveticaNeue-Bold" size:22.0f]
#define ACFontDefault24                     [UIFont fontWithName:@"HelveticaNeue" size:24.0f]
#define ACFontDefaultBold24                 [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0f]
#define ACFontDefault28                     [UIFont fontWithName:@"HelveticaNeue" size:28.0f]
#define ACFontDefaultBold28                 [UIFont fontWithName:@"HelveticaNeue-Bold" size:28.0f]
#define ACFontDefault30                     [UIFont fontWithName:@"HelveticaNeue" size:30.0f]
#define ACFontDefaultBold30                 [UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0f]
#define ACFontDefault32                     [UIFont fontWithName:@"HelveticaNeue" size:32.0f]
#define ACFontDefaultBold32                 [UIFont fontWithName:@"HelveticaNeue-Bold" size:32.0f]
#endif
