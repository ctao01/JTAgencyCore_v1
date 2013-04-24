//
//  CalendarMonthViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/29/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "CalendarMonthViewController.h"
#import "NewTaskViewController.h"
#import "BasicTwoLinesCell.h"

@interface CalendarMonthViewController ()

@end

@implementation CalendarMonthViewController

//#pragma mark - CalendarMonthViewController
//- (NSUInteger) supportedInterfaceOrientations{
//	return  UIInterfaceOrientationMaskPortrait;
//}
//- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
//}


#pragma mark View Lifecycle
- (void) viewDidLoad{
	[super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.navigationItem.title = @"Monthly View";
    
    UIBarButtonItem * listItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(backToScheduleList)];
    self.navigationItem.leftBarButtonItem = listItem;
    
    UIBarButtonItem * composeItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeNewTask)];
    self.navigationItem.rightBarButtonItem = composeItem;
    
	[self.monthView selectDate:[NSDate date]];
    self.view.backgroundColor = [UIColor clearColor];
}
#pragma mark -

- (void) backToScheduleList
{
    self.navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void) composeNewTask
{
    NewTaskViewController * vc = [[NewTaskViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self presentViewController:nc animated:YES completion:^{}];
}


#pragma mark MonthView Delegate & DataSource

- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate
{
    //	[self generateRandomDataForStartDate:startDate endDate:lastDate];
    [self generateDataForStartDate:startDate endDate:lastDate];
    
    return self.dataArray;
}
- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date{
	[self.tableView reloadData];
}
- (void) calendarMonthView:(TKCalendarMonthView*)mv monthDidChange:(NSDate*)d animated:(BOOL)animated{
	[super calendarMonthView:mv monthDidChange:d animated:animated];
	[self.tableView reloadData];
}


#pragma mark -  UITableView DataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSArray *ar = self.dataDictionary[[self.monthView dateSelected]];
	if(ar == nil) return 0;
	return [ar count];
}
- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"now %@",[NSDate localTimeConvertedFromDate:[NSDate date]]);
    //    static NSString *CellIdentifier = @"Cell";
    //    BasicTwoLinesCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (cell == nil) cell = [[BasicTwoLinesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    static NSString * iPhone_portrait_cell = @"iPhone_Portrait_Cell";
    static NSString * iPhone_landscape_cell = @"iPhone_Landscape_Cell";
    static NSString * iPad_portrait_cell = @"iPad_Portrait_Cell";
    static NSString * iPad_landscape_cell = @"iPad_Landscape_Cell";
    
    BasicTwoLinesCell * cell;
    if (iPHONE_UI && UserInterface_Portrait)
        cell = [tv dequeueReusableCellWithIdentifier:iPhone_portrait_cell];
    else if (iPHONE_UI && UserInterface_Landscape)
        cell = [tv dequeueReusableCellWithIdentifier:iPhone_landscape_cell];
    else if (iPAD_UI && UserInterface_Portrait)
        cell = [tv dequeueReusableCellWithIdentifier:iPad_portrait_cell];
    else if (iPAD_UI && UserInterface_Landscape)
        cell = [tv dequeueReusableCellWithIdentifier:iPad_landscape_cell];
    
    if (cell == nil)
    {
        if (iPHONE_UI && UserInterface_Portrait)
            cell = [[BasicTwoLinesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPhone_portrait_cell];
        else if (iPHONE_UI && UserInterface_Landscape)
            cell = [[BasicTwoLinesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPhone_landscape_cell];
        else if (iPAD_UI && UserInterface_Portrait)
            cell = [[BasicTwoLinesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPad_portrait_cell];
        else if (iPAD_UI && UserInterface_Landscape)
            cell = [[BasicTwoLinesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPad_landscape_cell];
        else
            cell = nil;
    }
    
    NSArray *ar = self.dataDictionary[[self.monthView dateSelected]];
    NSLog(@"%@",ar);
    cell.titleLabel.text = @"Patient Name";
    cell.dateLabel.text = [NSString shortDateAndTimeStyleStringFromDate:[ar[indexPath.row] objectForKey:@"time_key"]];
    cell.taskLabel.text = @"HHA Visit";
    cell.statusLabel.text = @"Upcoming";
	
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
	
}
#pragma mark -  UITableView Delegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
- (void) generateDataForStartDate:(NSDate*)start endDate:(NSDate*)end
{
    NSLog(@"%@",[NSDate dateWithoutTimePortionFromDate:[NSDate dateFromString:@"2013-04-18 16:33:24 +0000"]]);
    
    NSArray * array = [NSArray arrayWithObjects:
                       [NSDictionary dictionaryWithObjectsAndKeys:@"A",@"key_1", [NSDate dateFromString:@"2013-04-09 10:00:00 -0500"], @"time_key", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"B",@"key_1", [NSDate dateFromString:@"2013-04-21 10:00:00 -0500"], @"time_key", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"C",@"key_1", [NSDate dateFromString:@"2013-04-18 10:00:00 -0500"], @"time_key", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"D",@"key_1", [NSDate dateFromString:@"2013-04-29 10:00:00 -0500"], @"time_key", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"E",@"key_1", [NSDate dateFromString:@"2013-04-21 14:00:00 -0500"], @"time_key", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"F",@"key_1", [NSDate dateFromString:@"2013-04-09 17:00:00 -0500"], @"time_key", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"G",@"key_1", [NSDate dateFromString:@"2013-04-11 13:00:00 -0500"], @"time_key", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"H",@"key_1", [NSDate dateFromString:@"2013-04-09 21:00:00 -0500"], @"time_key", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"H",@"key_1", [NSDate date], @"time_key", nil],nil];
    NSDictionary * dict = [NSDictionary dictionaryFromArray:array andKey:@"time_key"];
    
    NSLog(@"Dict %@",dict);
    
    self.dataArray = [NSMutableArray array];
    self.dataDictionary = [NSMutableDictionary dictionary];
    NSDate *d = start;
    NSLog(@"description%@",d);
    NSLog(@"keys%@",[dict.allKeys  description]);
    
    while (YES)
    {
        if ([dict.allKeys containsObject:d])
        {
            NSArray * array = [dict objectForKey:d];
            NSLog(@"count-%i",[array count]);
            [self.dataDictionary setObject:array forKey:d];
            
            [self.dataArray addObject:[NSNumber numberWithInt:[array count]]];
        }
        else
            [self.dataArray addObject:[NSNumber numberWithInt:0]];
        
        
        TKDateInformation info = [d dateInformationWithTimeZone:[NSTimeZone localTimeZone]];
		info.day++;
		d = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone localTimeZone]];
		if([d compare:end]==NSOrderedDescending) break;
    }
}

- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end
{
    
    
	// this function sets up dataArray & dataDictionary
	// dataArray: has boolean markers for each day to pass to the calendar view (via the delegate function)
	// dataDictionary: has items that are associated with date keys (for tableview)
    //	self.dataArray = [NSMutableArray array];
    //	self.dataDictionary = [NSMutableDictionary dictionary];
    //	NSDate *d = start;
    //	while(YES){
    //        NSCalendar *cal = [NSCalendar currentCalendar];
    //        [cal setTimeZone:[NSTimeZone localTimeZone]];
    //
    //        NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit) fromDate:d];
    //        if (comp.year == 2013 && comp.month == 4 && comp.day == 22)
    //        {
    //            NSArray * array = [NSArray arrayWithObjects:[NSDate date],[NSDate date], nil];
    //            [self.dataDictionary setObject:array forKey:d];
    //			[self.dataArray addObject:[NSNumber numberWithInt:2]];
    //        }
    //        if (comp.year == 2013 && comp.month == 4 && comp.day == 18)
    //        {
    //            NSArray * array =[NSArray arrayWithObjects:[NSDate dateFromString:@"2013-04-18 16:33:24 -0500 "], nil];
    //            [self.dataDictionary setObject:array forKey:d];
    //			[self.dataArray addObject:[NSNumber numberWithInt:1]];
    //        }
    //        else
    //			[self.dataArray addObject:[NSNumber numberWithInt:0]];
    //
    //		/*int r = arc4random();
    //		if(r % 3==1){
    //			[self.dataDictionary setObject:@[@"Item one",@"Item two"] forKey:d];
    //			[self.dataArray addObject:[NSNumber numberWithInt:2]];
    //
    //		}else if(r%4==1){
    //			[self.dataDictionary setObject:@[@"Item one"] forKey:d];
    //			[self.dataArray addObject:[NSNumber numberWithInt:1]];
    //
    //		}else
    //			[self.dataArray addObject:[NSNumber numberWithInt:0]];*/
    //        TKDateInformation info = [d dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    //		info.day++;
    //		d = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    //       
    //
    //		if([d compare:end]==NSOrderedDescending) break;
    //	}
    
}


@end
