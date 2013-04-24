//
//  ACMessage.h
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/24/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ACUser;

@interface ACMessage : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * lastUpdate;
@property (nonatomic, retain) NSString * messageID;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) ACUser *receivers;
@property (nonatomic, retain) ACUser *sender;

@end
