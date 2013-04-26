//
//  ScheduleViewController.m
//  AgencyCoreMobile_v1002
//
//  Created by Iggy Mwangi on 3/15/13.
//
//

#import "ScheduleViewController.h"
#import "CalendarMonthViewController.h"
#import "NavigationControllerWithoutRotation.h"
#import "NavigationToolBarController.h"
#import "BasicTwoLinesCell.h"
#import "VisitViewController.h"
#import "NewTaskViewController.h"


@interface ScheduleViewController ()
@property (nonatomic , strong) UISegmentedControl * segmentControl;

@end

@implementation ScheduleViewController

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - Programmatically

- (void) gotoMontlyView
{
    CalendarMonthViewController * cvc = [[CalendarMonthViewController alloc]initWithSunday:YES];
    NavigationControllerWithoutRotation * cnv = [[NavigationControllerWithoutRotation alloc]initWithRootViewController:cvc];
    cnv.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController presentViewController:cnv animated:YES completion:^{
        [[NSNotificationCenter defaultCenter] removeObserver:self.navigationController];

    }];
}

#pragma mark -

- (void) viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 49.0f, 0.0f);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.navigationItem.title = @"Scheduled";

    UIBarButtonItem * calItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_calendar"] style:UIBarButtonItemStyleBordered target:self action:@selector(gotoMontlyView)];
    self.navigationItem.rightBarButtonItem = calItem;

    self.segmentControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"Upcoming",@"Missed",@"Completed", nil]];
    self.segmentControl.frame = CGRectMake(0.0f, 0.0f, width(self.tableView.frame), 44.0f);
    self.segmentControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [self.segmentControl addTarget:self action:@selector(refreshScheduleTasks) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.tableHeaderView = self.segmentControl;
    self.segmentControl.selectedSegmentIndex = 0;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupColorForSegmentControl];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NavigationToolBarController * nav = (NavigationToolBarController*)self.navigationController;
    [nav.navToolBar setHidden:NO];

    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UILabel * updatedLabel = [[UILabel alloc]initWithFrame:UIEdgeInsetsInsetRect(nav.navToolBar.frame, UIEdgeInsetsMake(10.0f, nav.navToolBar.frame.size.width / 5.0f, 10.0f, nav.navToolBar.frame.size.width / 5.0f))];
    [updatedLabel setFont:ACFontDefaultBold14];
    [updatedLabel setTextColor:[UIColor whiteColor]];
    [updatedLabel setText:[NSString updateLabelDateStringFromDate:[NSDate date]]];
    [updatedLabel setTextAlignment:NSTextAlignmentCenter];
    [updatedLabel setBackgroundColor:[UIColor clearColor]];
    UIBarButtonItem * labelItem = [[UIBarButtonItem alloc]initWithCustomView:updatedLabel];
    
    UIBarButtonItem * composeItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeTask)];
    nav.navToolBar.items = [NSArray arrayWithObjects:spaceItem,labelItem,spaceItem,composeItem, nil];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 

- (void) composeTask
{
    NewTaskViewController * vc = [[NewTaskViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self presentViewController:nc animated:YES completion:^{}];
}

- (void) setupColorForSegmentControl
{
    NSLog(@"index %i", self.segmentControl.selectedSegmentIndex);
//    int index = self.segmentControl.selectedSegmentIndex;
//    int segments = [self.segmentControl.subviews count];
//    
//    for( int i = 0; i < segments; i++ )
//    {
//        // reset color
//        [[self.segmentControl.subviews objectAtIndex:i] setTintColor:nil];
//    }
//    
//    if( hasSetSelectedIndexOnce )
//    {
//        // this is super weird - the subviews array is backwards... so deal with it like that
//        if (self.segmentControl.selectedSegmentIndex == 0)
//            [[self.segmentControl.subviews objectAtIndex:segments -1-index]  setTintColor:ACColorTaskScheduledBlue];
//        else if (self.segmentControl.selectedSegmentIndex == 1)
//            [[self.segmentControl.subviews objectAtIndex:segments -1-index]  setTintColor:ACColorTaskMissedRed];
//        else if (self.segmentControl.selectedSegmentIndex == 2)
//            [[self.segmentControl.subviews objectAtIndex:segments -1-index]  setTintColor:ACColorTaskCompletedGreen];
//    }
//    else
//    {
//        if (self.segmentControl.selectedSegmentIndex == 0)
//            [[self.segmentControl.subviews objectAtIndex:index]  setTintColor:ACColorTaskScheduledBlue];
//        else if (self.segmentControl.selectedSegmentIndex == 1)
//            [[self.segmentControl.subviews objectAtIndex:index]  setTintColor:ACColorTaskMissedRed];
//        else if (self.segmentControl.selectedSegmentIndex == 2)
//            [[self.segmentControl.subviews objectAtIndex:index]  setTintColor:ACColorTaskCompletedGreen];
//        hasSetSelectedIndexOnce = YES;
//    }
    for (int i=0; i<[self.segmentControl.subviews count]; i++)
    {
        if ([[self.segmentControl.subviews objectAtIndex:i]isSelected] )
        {
            NSLog(@"objectAtIndex%i",i);
            UIColor * tintcolor;
            if (self.segmentControl.selectedSegmentIndex == 0) tintcolor = ACColorTaskScheduledBlue;
            else if (self.segmentControl.selectedSegmentIndex == 1) tintcolor = ACColorTaskMissedRed;
            else if (self.segmentControl.selectedSegmentIndex == 2) tintcolor = ACColorTaskCompletedGreen;
            
            [[self.segmentControl.subviews objectAtIndex:i] setTintColor:nil];
            [[self.segmentControl.subviews objectAtIndex:i] setTintColor:tintcolor];
        }
        else [[self.segmentControl.subviews objectAtIndex:i] setTintColor:nil];
    }
}
- (void) refreshScheduleTasks
{
    [self.tableView reloadData];
    if ([self.tableView numberOfRowsInSection:0] > 20) [self addLoadMoreFooter];
    else [self.loadMoreFooter removeFromSuperview];
    
    [self setupColorForSegmentControl];
    
//    [self.segmentControl setTag:kTagFirst forSegmentAtIndex:0];
//    [self.segmentControl setTag:kTagSecond forSegmentAtIndex:1];
//    [self.segmentControl setTag:kTagThird forSegmentAtIndex:2];
//    
//    [self.segmentControl setTintColor:ACColorTaskScheduledBlue forTag:kTagFirst];
//    [self.segmentControl setTintColor:ACColorTaskMissedRed forTag:kTagSecond];
//    [self.segmentControl setTintColor:ACColorTaskCompletedGreen forTag:kTagThird];

}

#pragma mark - NSNotification

- (void) receiveTestNotification:(NSNotification*)notification
{
    if ([[notification name]isEqualToString:@"TestNotification" ])
    {
        [self layoutRotated];
    }
}


#pragma mark - UITableView Datasource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmentControl.selectedSegmentIndex == 0) return 11;
    else if (self.segmentControl.selectedSegmentIndex == 1) return 5;
    else if (self.segmentControl.selectedSegmentIndex == 2) return 32;
    
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *cellIdentifier = @"SampleCell";
    static NSString * iPhone_portrait_cell = @"iPhone_Portrait_Cell";
    static NSString * iPhone_landscape_cell = @"iPhone_Landscape_Cell";
    static NSString * iPad_portrait_cell = @"iPad_Portrait_Cell";
    static NSString * iPad_landscape_cell = @"iPad_Landscape_Cell";
    
    BasicTwoLinesCell * cell;
    if (iPHONE_UI && UserInterface_Portrait)
        cell = [tableView dequeueReusableCellWithIdentifier:iPhone_portrait_cell];
    else if (iPHONE_UI && UserInterface_Landscape)
        cell = [tableView dequeueReusableCellWithIdentifier:iPhone_landscape_cell];
    else if (iPAD_UI && UserInterface_Portrait)
        cell = [tableView dequeueReusableCellWithIdentifier:iPad_portrait_cell];
    else if (iPAD_UI && UserInterface_Landscape)
        cell = [tableView dequeueReusableCellWithIdentifier:iPad_landscape_cell];
    
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
    cell.titleLabel.text = @"Patient Name";
//    cell.dateLabel.text = [NSString customizedCellDateStringFromDate:[NSDate date]];
    cell.taskLabel.text = @"HHA Visit";
    if (self.segmentControl.selectedSegmentIndex == 0){
        cell.dateLabel.text = [NSString customizedCellDateStringFromDate:[NSDate dateFromString:@"2013-04-18 10:00:00 -0500"]];
        cell.statusLabel.text = @"Upcoming";
    }
    else if (self.segmentControl.selectedSegmentIndex == 1)
    {
        cell.dateLabel.text = [NSString customizedCellDateStringFromDate:[NSDate dateFromString:@"2013-04-11 10:00:00 -0500"]];
        cell.statusLabel.text = @"Missed";
    }
    else
    {
        cell.dateLabel.text = [NSString customizedCellDateStringFromDate:[NSDate dateFromString:@"2013-04-30 10:00:00 -0500"]];
        cell.statusLabel.text = @"Completed";
    }

    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    cell.selectedBackgroundView = [[UIView alloc]init];
//    cell.selectedBackgroundView.backgroundColor = ACColorRed;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TEMP: Testing Object
    BasicTwoLinesCell * cell = (BasicTwoLinesCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSDictionary * comment = [NSDictionary dictionaryWithObjectsAndKeys:NULL,@"episode_comment",NULL,@"visit_comment",NULL,@"missed_visited_form", nil];
    NSDictionary * object = [NSDictionary dictionaryWithObjectsAndKeys:cell.titleLabel.text, @"patient",cell.dateLabel.text, @"schedule_date",cell.taskLabel.text, @"task_title", cell.statusLabel.text, @"task_status",comment, @"task_notes" ,nil];
//    NSLog(@"Task Object:%@",object);
    //
    VisitViewController * vc = [[VisitViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
    [vc setTaskObject:object];
    
}

@end
