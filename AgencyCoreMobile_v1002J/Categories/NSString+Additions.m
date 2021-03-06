//
//  NSString+Additions.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/25/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "NSString+Additions.h"
//#import "NSDate+Additions.h"

@implementation NSString (Additions)

+ (NSString*) detailDateStringFromDate:(NSDate*)date
{
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"EEEE,LLLL d,yyyy,h:mm:ss a"];
    NSString * string = [df stringFromDate:date];
    return string;
}

+ (NSString*) customizedCellDateStringFromDate:(NSDate*)date
{
    NSString * todayString = [[[NSDate date] description] substringToIndex:10];
    
    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow: -(60.0f*60.0f*24.0f)];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    NSString * string;
    
    if ([dateString isEqualToString:todayString])
    {
        NSDateFormatter * df = [[NSDateFormatter alloc]init];
        [df setTimeStyle:NSDateFormatterShortStyle];
        string = [df stringFromDate:date];
    }
    else if ([dateString isEqualToString:yesterdayString])
        string = @"Yesterday";
    else
    {
        NSDateFormatter * df = [[NSDateFormatter alloc]init];
        [df setDateStyle:NSDateFormatterShortStyle];
        string = [df stringFromDate:date];
    }
    return string;
}

+ (NSString*) updateLabelDateStringFromDate:(NSDate*)date
{
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateStyle:NSDateFormatterShortStyle];
    NSString * dateString = [df stringFromDate:date];
    
    NSDateFormatter * tformatter = [[NSDateFormatter alloc]init];
    tformatter.dateFormat = @"HH:mm a";
    NSString * timeString = [tformatter stringFromDate:date];
    
    return [NSString stringWithFormat:@"Last Update %@ at %@",dateString,timeString];
    
}

+ (NSString*) shortDateStyleStringFromDate:(NSDate*)date
{
    
    NSDateFormatter * df = [[NSDateFormatter alloc]init];   
    [df setDateStyle:NSDateFormatterShortStyle];   
    
    NSString * string = [df stringFromDate:date];
    return string;
}

+ (NSString*) shortTimeStyleStringFromDate:(NSDate*)date
{
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setTimeZone:[NSTimeZone localTimeZone]];

    NSString * string = [df stringFromDate:date];
    return string;
}

+ (NSString*) shortDateAndTimeStyleStringFromDate:(NSDate*)date

{
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateStyle:NSDateFormatterShortStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setTimeZone:[NSTimeZone systemTimeZone]];

    
    NSString * string = [df stringFromDate:date];
    return string;
}

@end
