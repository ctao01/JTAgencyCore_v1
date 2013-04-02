//
//  CalendarMonthViewController.h
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/29/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "TapkuLibrary.h"

@interface CalendarMonthViewController : TKCalendarMonthTableViewController
@
property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableDictionary *dataDictionary;

- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end;

@end
