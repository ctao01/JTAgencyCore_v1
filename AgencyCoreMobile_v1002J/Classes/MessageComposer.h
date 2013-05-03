//
//  MessageComposer.h
//  AgencyCoreMobile_v1002
//
//  Created by Joy Tao on 3/20/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TITokenField.h"



@interface MessageComposer : UIViewController < TITokenFieldDelegate , UITextViewDelegate , UITextFieldDelegate>
@property (nonatomic , copy) NSString * selectedContact;

@property (nonatomic , strong) NSDictionary * messageObject;
@end
