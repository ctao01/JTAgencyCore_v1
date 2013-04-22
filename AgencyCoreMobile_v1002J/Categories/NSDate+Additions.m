//
//  NSDate+Additions.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/19/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate (Additions)

+ (NSDate*) dateWithoutTimePortionFromDate:(NSDate*)date
{
    NSCalendar * calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    
    NSDateComponents * components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | kCFCalendarUnitWeekday | kCFCalendarUnitWeekdayOrdinal fromDate:date];
    
    NSDateComponents * newComponents = [[NSDateComponents alloc]init];
    [newComponents setYear:components.year];
    [newComponents setMonth:components.month];
    [newComponents setDay:components.day];
    [newComponents setWeekday:components.weekday];
    [newComponents setWeekdayOrdinal:components.weekdayOrdinal];
    
    return [calendar dateFromComponents:newComponents];
}


+(NSDate*) localTimeConvertedFromDate:(NSDate*)date
{
    
    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    
    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:date];
    NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:date];
    NSTimeInterval gmtInterval = currentGMTOffset - gmtOffset;
    
    NSDate *localDate = [[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:date];
    
    return localDate;
}

+ (NSDate *) dateFromString:(NSString*)string
{
    
//    NSString * dStr = @"04-10-2013 1:00:00";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy-MM-dd H:mm:ss Z"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate * date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:string];
    //
//    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
//    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
//    
//    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:date];
//    NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:date];
//    NSTimeInterval gmtInterval = currentGMTOffset - gmtOffset;
//    
//    NSDate *destinationDate = [[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:date];
//
    return date;
}


@end
