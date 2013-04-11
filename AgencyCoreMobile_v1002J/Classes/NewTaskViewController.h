//
//  NewTaskViewController.h
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/9/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTaskViewController : UITableViewController
@property (nonatomic , copy) NSString * selectedPatient;
@property (nonatomic , copy) NSString * selectedTask;
@property (nonatomic , copy) NSString * selectedUser;
@property (nonatomic , copy) NSDate * selectedDate;

@end
