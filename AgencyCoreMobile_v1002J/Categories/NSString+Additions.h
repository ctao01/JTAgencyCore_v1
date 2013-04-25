//
//  NSString+Additions.h
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/25/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

// Account
+ (NSString*) userLocationWithUser:(id)user;

// Date + Time
+ (NSString*) detailDateStringFromDate:(NSDate*)date;
+ (NSString*) customizedCellDateStringFromDate:(NSDate*)date;
+ (NSString*) updateLabelDateStringFromDate:(NSDate*)date;
+ (NSString*) shortDateStyleStringFromDate:(NSDate*)date;
+ (NSString*) shortDateAndTimeStyleStringFromDate:(NSDate*)date;

+ (NSString*) shortTimeStyleStringFromDate:(NSDate*)date;

@end
