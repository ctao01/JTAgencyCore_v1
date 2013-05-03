//
//  PatientProfileViewController.h
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 5/1/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <UIKit/UIKit.h>

// For temp
typedef enum { 
    ACPatientStatusActive = 0,
    ACPatientStatusDischarge,
    ACPatientStatusPending,
    ACPatientStatusNonAdmit
    }ACPatientStatus ;

@interface PatientProfileViewController : UITableViewController

@end
