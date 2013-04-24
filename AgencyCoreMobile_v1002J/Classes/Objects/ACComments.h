//
//  ACComments.h
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/24/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ACTask;

@interface ACComments : NSManagedObject

@property (nonatomic, retain) NSString * episodeComment;
@property (nonatomic, retain) NSString * missedVisitedForm;
@property (nonatomic, retain) NSString * taskComment;
@property (nonatomic, retain) ACTask *task;

@end
