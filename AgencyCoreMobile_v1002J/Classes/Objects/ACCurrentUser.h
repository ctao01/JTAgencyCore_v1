//
//  CurrentUser.h
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/24/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ACUser.h"


@interface ACCurrentUser : ACUser

@property (nonatomic, retain) NSString * accessToken;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * signature;
@property (nonatomic, retain) NSString * username;
@end

@interface ACCurrentUser (Additions)
- (NSString*) location;
@end
