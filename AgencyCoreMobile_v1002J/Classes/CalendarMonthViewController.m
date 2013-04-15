//
//  CalendarMonthViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/29/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "CalendarMonthViewController.h"
#import "NewTaskViewController.h"

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
- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate{
	[self generateRandomDataForStartDate:startDate endDate:lastDate];
	return self.dataArray;
}
- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date{
	[self.tableView reloadData];
}
- (void) calendarMonthView:(TKCalendarMonthView*)mv monthDidChange:(NSDate*)d animated:(BOOL)animated{
	[super calendarMonthView:mv monthDidChange:d animated:animated];
	[self.tableView reloadData];
}


#pragma mark UITableView Delegate & DataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSArray *ar = self.dataDictionary[[self.monthView dateSelected]];
	if(ar == nil) return 0;
	return [ar count];
}
- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
	
    
	NSArray *ar = self.dataDictionary[[self.monthView dateSelected]];
	cell.textLabel.text = ar[indexPath.row];
	
    return cell;
	
}


- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end{
	// this function sets up dataArray & dataDictionary
	// dataArray: has boolean markers for each day to pass to the calendar view (via the delegate function)
	// dataDictionary: has items that are associated with date keys (for tableview)

	self.dataArray = [NSMutableArray array];
	self.dataDictionary = [NSMutableDictionary dictionary];
	
	NSDate *d = start;
	while(YES){
		
		int r = arc4random();
		if(r % 3==1){
			[self.dataDictionary setObject:@[@"Item one",@"Item two"] forKey:d];
			[self.dataArray addObject:[NSNumber numberWithInt:2]];
			
		}else if(r%4==1){
			[self.dataDictionary setObject:@[@"Item one"] forKey:d];
			[self.dataArray addObject:[NSNumber numberWithInt:1]];
			
		}else
			[self.dataArray addObject:[NSNumber numberWithInt:0]];
		
		
//		NSDateComponents *info = [d dateComponentsWithTimeZone:self.monthView.timeZone];
//		info.day++;
//		d = [NSDate dateWithDateComponents:info];
//		if([d compare:end]==NSOrderedDescending) break;
        TKDateInformation info = [d dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
		info.day++;
		d = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
		if([d compare:end]==NSOrderedDescending) break;
	}
	
}

//-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    [self updateTableOffset:YES];
//}
//
//
//- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//	return YES;
//}

@end
