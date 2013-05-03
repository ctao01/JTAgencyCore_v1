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
#import "ScheduleDetailViewController.h"
#import "NewTaskViewController.h"
#import "PatientProfileViewController.h"


@interface ScheduleViewController () <UISearchDisplayDelegate , UISearchBarDelegate>
{
    BOOL isSearching;
}
@property (nonatomic , strong) UISegmentedControl * segmentControl;
@property (nonatomic , strong) UISearchDisplayController * searchController;
@property (nonatomic , strong) UISearchBar * searchBar;
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

#pragma mark - Life Cycle Delegate

- (void) viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 49.0f, 0.0f);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.navigationItem.title = @"Scheduled";

    UIBarButtonItem * search = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchDisplayController)];
    self.navigationItem.rightBarButtonItem = search;
    
    self.segmentControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"Upcoming",@"Missed",@"Completed", nil]];
    if (iPHONE_UI) self.segmentControl.frame = CGRectMake(0.0f, 0.0f, width(self.tableView.frame), 32.0f);
    else if (iPAD_UI) self.segmentControl.frame = CGRectMake(0.0f, 0.0f, width(self.tableView.frame), 44.0f);
    self.segmentControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [self.segmentControl addTarget:self action:@selector(refreshScheduleTasks) forControlEvents:UIControlEventValueChanged];

    self.tableView.tableHeaderView = self.segmentControl;
    self.segmentControl.selectedSegmentIndex = 0;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupColorForSegmentControl];

    isSearching = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NavigationToolBarController * nav = (NavigationToolBarController*)self.navigationController;
    [nav.navToolBar setHidden:NO];
    
    UIBarButtonItem * calItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_calendar"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoMontlyView)];
    
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UILabel * updatedLabel = [UILabel updatedLabelWithFrame:UIEdgeInsetsInsetRect(nav.navToolBar.frame, UIEdgeInsetsMake(10.0f, 40.0f, 10.0f, 40.0f))];
    [updatedLabel setText:[NSString updateLabelDateStringFromDate:[NSDate date]]];
    UIBarButtonItem * labelItem = [[UIBarButtonItem alloc]initWithCustomView:updatedLabel];
    
    UIBarButtonItem * composeItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeTask)];
    nav.navToolBar.items = [NSArray arrayWithObjects:calItem,spaceItem,labelItem,spaceItem,composeItem, nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NavigationToolBarController * nav = (NavigationToolBarController*)self.navigationController;
    nav.navToolBar.items = nil;
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
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
        else
        {
            if (iPHONE_UI) [[self.segmentControl.subviews objectAtIndex:i] setTintColor:[UIColor grayColor]];
            else [[self.segmentControl.subviews objectAtIndex:i] setTintColor:nil];
        }
    }
}
- (void) refreshScheduleTasks
{
    [self.tableView reloadData];
    if ([self.tableView numberOfRowsInSection:0] > 20) [self addLoadMoreFooter];
    else [self.loadMoreFooter removeFromSuperview];
    
    [self setupColorForSegmentControl];
}

#pragma mark - UISearchBar & UISearchDisplayController

- (void) showSearchDisplayController
{ 
    isSearching = YES;
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, width(self.tableView.frame), 44.0f)];
    self.searchBar.tintColor = ACColorGray80;
    self.searchController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.delegate = self;
    self.searchBar.delegate = self;
    
    self.tableView.tableHeaderView = self.searchBar;
    [self.searchBar becomeFirstResponder];
}

- (void) filterContentForSearchText:(NSString*)searchText andScope:(NSString*)scope
{
//    NSPredicate * result = [NSPredicate predicateWithFormat:@"SELF contains[cd]%@",searchText];
//    self.searchedContacts = [self.contacts filteredArrayUsingPredicate:result];
}


- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    NSLog(@"searchDisplayControllerDidEndSearch");
    isSearching = NO;
    self.tableView.tableHeaderView = self.segmentControl;
}

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString andScope:nil];
    return YES;
}

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[controller.searchBar text] andScope:nil];
    return YES;
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

//    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView * view = [[UIView alloc]initWithFrame:cell.backgroundView.frame];
    view.backgroundColor = ACColorGray80Alpha;
    cell.selectedBackgroundView = view;
}

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    PatientProfileViewController * vc = [[PatientProfileViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TEMP: Testing Object
    BasicTwoLinesCell * cell = (BasicTwoLinesCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSDictionary * comment = [NSDictionary dictionaryWithObjectsAndKeys:NULL,@"episode_comment",NULL,@"visit_comment",NULL,@"missed_visited_form", nil];
    NSDictionary * object = [NSDictionary dictionaryWithObjectsAndKeys:cell.titleLabel.text, @"patient",cell.dateLabel.text, @"schedule_date",cell.taskLabel.text, @"task_title", cell.statusLabel.text, @"task_status",comment, @"task_notes" ,nil];
//    NSLog(@"Task Object:%@",object);
    //
    ScheduleDetailViewController * vc = [[ScheduleDetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
    [vc setTaskObject:object];
    
}

@end
