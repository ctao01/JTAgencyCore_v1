//
//  User.h
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/24/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ACMessage, ACPatient, ACTask, ACUser;

@interface ACUser : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * home;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSDate * lastUpdate;
@property (nonatomic, retain) NSString * middleName;
@property (nonatomic, retain) NSString * mobile;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSString * zipcode;
@property (nonatomic, retain) NSSet *contacts;
@property (nonatomic, retain) ACMessage *messageForm;
@property (nonatomic, retain) NSSet *messagesTo;
@property (nonatomic, retain) NSSet *patients;
//@property (nonatomic, retain) ACPatient *patientsAssigned;
@property (nonatomic, retain) NSSet *tasks;
@end

@interface ACUser (CoreDataGeneratedAccessors)

- (void)addContactsObject:(ACUser *)value;
- (void)removeContactsObject:(ACUser *)value;
- (void)addContacts:(NSSet *)values;
- (void)removeContacts:(NSSet *)values;

- (void)addMessagesToObject:(ACMessage *)value;
- (void)removeMessagesToObject:(ACMessage *)value;
- (void)addMessagesTo:(NSSet *)values;
- (void)removeMessagesTo:(NSSet *)values;

- (void)addPatientsObject:(ACUser *)value;
- (void)removePatientsObject:(ACUser *)value;
- (void)addPatients:(NSSet *)values;
- (void)removePatients:(NSSet *)values;

- (void)addTasksObject:(ACTask *)value;
- (void)removeTasksObject:(ACTask *)value;
- (void)addTasks:(NSSet *)values;
- (void)removeTasks:(NSSet *)values;

@end

