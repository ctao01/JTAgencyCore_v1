//
//  AgecyCoreGlobal.h
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/1/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#ifndef AgencyCoreMobile_v1002J_AgecyCoreGlobal_h
#define AgencyCoreMobile_v1002J_AgecyCoreGlobal_h

#define iPAD_UI (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define iPHONE_UI (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define DEVICE_ORIENTATION [[UIDevice currentDevice]orientation]
#define DEVICE_LANDSCAPE (DEVICE_ORIENTATION == UIDeviceOrientationLandscapeLeft || DEVICE_ORIENTATION == UIDeviceOrientationLandscapeRight)
#define DEVICE_PORTRAIT (DEVICE_ORIENTATION == UIDeviceOrientationPortrait || DEVICE_ORIENTATION == UIDeviceOrientationPortraitUpsideDown)

#endif
