//
//  CurrentUser.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/24/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "ACCurrentUser.h"


@implementation ACCurrentUser

@dynamic accessToken;
@dynamic password;
@dynamic signature;
@dynamic username;

@end

@implementation ACUser (Additions)

- (NSString*) location
{
    NSString * result = @"";
    if (self.address) result = [result stringByAppendingString:self.address];
    if (self.city) result = [result stringByAppendingString:self.city];
    if (self.state) result = [result stringByAppendingString:self.state];
    if (self.zipcode) result = [result stringByAppendingString:self.zipcode];
    if (self.country) result = [result stringByAppendingString:self.country];
    return result;
}
@end