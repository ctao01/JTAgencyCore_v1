//
//  AgencyCoreEntries.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/23/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "AgencyCoreEntries.h"
#import "ObjectManager.h"
#import "TapkuLibrary.h"

@implementation AgencyCoreEntries

+ (ACCurrentUser *) createCurrentUser
{
    ACCurrentUser * user = [NSEntityDescription insertNewObjectForEntityForName:@"ACCurrentUser" inManagedObjectContext:[[ObjectManager sharedManager]managedObjectContext]];
    user.firstName = @"ALY";
    user.middleName = @"";
    user.lastName = @"SARA";
    user.gender = @"F";
    user.lastUpdate = [NSDate date];
    
    user.address = @"1120 Forest Lane";
    user.city = @"Dallas";
    user.country = @"TX";
    user.zipcode = @"75211";
    
    user.home = @"(233) 445-7051";
    user.mobile = @"";
    
    user.userID = @"utest0004";
    
    return user;
}

+ (ACUser*) createUserWithFirstName:(NSString*)firstName andLastName:(NSString*)lastName
{
    ACUser * user = [NSEntityDescription insertNewObjectForEntityForName:@"ACUser" inManagedObjectContext:[[ObjectManager sharedManager]managedObjectContext]];
    user.firstName = firstName;
    user.lastName = lastName;
    user.gender = @"M";
    user.lastUpdate = [NSDate date];

    return user;
}

+ (ACMessage*) createMessage
{
    ACMessage * message = [NSEntityDescription insertNewObjectForEntityForName:@"ACMessage" inManagedObjectContext:[[ObjectManager sharedManager]managedObjectContext]];
    message.lastUpdate = [NSDate date];
    message.sender = [self createUserWithFirstName:@"Edem" andLastName:@"Jimbo"];
    message.receivers = [self createCurrentUser];
    message.content = @"This is testinf content";
    message.subject = @"This is testing subject";
    return message;
}


+ (ACTask*) createTaskWithScheduleDate:(NSDate*)date andTaskStatus:(NSString*)status
{
    ACTask * task = [NSEntityDescription insertNewObjectForEntityForName:@"ACTask" inManagedObjectContext:[[ObjectManager sharedManager]managedObjectContext]];
    task.scheduledDate = date;
    task.status = status;
    task.title = @"SN Visit";
    task.assignee = [self createCurrentUser];
    
    return task;
}

+ (NSArray*) createTasks
{
    NSDate * date = [NSDate date];
    NSMutableArray * tasksArray = [[NSMutableArray alloc]init];
    NSDate * end = [date dateByAddingTimeInterval:60 *  24 * 60 * 60];
    NSDate * d = [date dateByAddingTimeInterval:-30 *  24 * 60 * 60];
	while(YES){
		
		int r = arc4random();
		if(r % 3==1){
			if (r%5 == 1)
                [tasksArray addObject:[self createTaskWithScheduleDate:d andTaskStatus:@"Completed"]];
            else
                [tasksArray addObject:[self createTaskWithScheduleDate:d andTaskStatus:@"Missed"]];
		}
        else if(r%4==1){
            if (r%7 == 2)[tasksArray addObject:[self createTaskWithScheduleDate:d andTaskStatus:@"Missed"]];
            else if (r%7 == 1)[tasksArray addObject:[self createTaskWithScheduleDate:d andTaskStatus:@"Completed"]];
			
		}else
            [tasksArray addObject:[self createTaskWithScheduleDate:d andTaskStatus:@"Upcoming"]];
				
		TKDateInformation info = [d dateInformationWithTimeZone:[NSTimeZone localTimeZone]];
		info.day++;
		d = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone localTimeZone]];
		if([d compare:end]==NSOrderedDescending) break;
	}
    return tasksArray;


}

+ (ACComments*) creatComments
{
    ACComments * comments = [NSEntityDescription insertNewObjectForEntityForName:@"ACComments" inManagedObjectContext:[[ObjectManager sharedManager]managedObjectContext]];
    return comments;
}


@end
