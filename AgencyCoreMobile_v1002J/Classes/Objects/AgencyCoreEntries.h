//
//  AgencyCoreEntries.h
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/23/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AgencyCoreEntries : NSObject

+ (ACCurrentUser *) createCurrentUser;
+ (ACUser*) createUserWithFirstName:(NSString*)firstName andLastName:(NSString*)lastName;

+ (ACTask*) createTaskWithScheduleDate:(NSDate*)date andTaskStatus:(NSString*)status;
+ (NSArray*) createTasks;

+ (ACComments*) creatComments;

+ (ACMessage*) createMessage;


@end
