//
//  Task.h
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/24/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ACComments, ACEpisode, ACPatient, ACUser;

@interface ACTask: NSManagedObject

@property (nonatomic, retain) NSDate * scheduledDate;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * taskID;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) ACUser *assignee;
@property (nonatomic, retain) ACComments *comments;
//@property (nonatomic, retain) ACEpisode *episode;
//@property (nonatomic, retain) ACPatient *patient;

@end
