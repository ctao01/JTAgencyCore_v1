//
//  NSDate+Additions.h
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/19/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

+ (NSDate*) dateWithoutTimePortionFromDate:(NSDate*)date;

+ (NSDate *) localTimeConvertedFromDate:(NSDate*)date;
+ (NSDate *) dateFromString:(NSString*)dateString;
@end
