//
//  NSDictionary+UIAdditions.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/22/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "NSDictionary+Additions.h"

@implementation NSDictionary (Additions)

+ (NSDictionary*) dictionaryFromArray:(NSArray*)array andKey:(NSString*)key
{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    for(NSDictionary * object in array)
    {
        if ([dict.allKeys count] >0)
        {
            if (![dict.allKeys containsObject:[NSDate dateWithoutTimePortionFromDate:[object objectForKey:key]]])
            {
                NSArray * array = [NSArray arrayWithObjects:object, nil];
                [dict setObject:array forKey:[NSDate dateWithoutTimePortionFromDate:[object objectForKey:key]]];
            }
            else
            {
                id obj = [dict objectForKey:[NSDate dateWithoutTimePortionFromDate:[object objectForKey:key]]];
                NSMutableArray * array = [NSMutableArray arrayWithArray:obj];
                [array addObject:object];
                [dict setObject:array forKey:[NSDate dateWithoutTimePortionFromDate:[object objectForKey:key]]];
                
            }
        }
        else
        {
            NSArray * array = [NSArray arrayWithObjects:object, nil];
            [dict setObject:array forKey:[NSDate dateWithoutTimePortionFromDate:[object objectForKey:key]]];
        }
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
