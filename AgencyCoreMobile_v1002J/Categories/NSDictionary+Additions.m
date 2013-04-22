//
//  NSDictionary+UIAdditions.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/22/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "NSDictionary+Additions.h"

@implementation NSDictionary (Additions)

+ (NSDictionary*) dictionaryFromArray:(NSArray*)array
{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    for(NSDictionary * object in array)
    {
        NSLog(@"%i",[dict.allKeys count]);
        if ([dict.allKeys count] >0)
        {
            if (![dict.allKeys containsObject:[object objectForKey:@"time_key"]])
                [dict setObject:object forKey:[object objectForKey:@"time_key"]];
            else
            {
                NSMutableArray * array = [[NSMutableArray alloc]initWithObjects:[dict objectForKey:[object objectForKey:@"time_key"]], nil];
                [array addObject:object];
                [dict setObject:array forKey:[object objectForKey:@"time_key"]];
            }
        }
        else
            [dict setObject:object forKey:[object objectForKey:@"time_key"]];
        
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
