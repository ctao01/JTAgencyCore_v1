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

    UIBarButtonItem * calItem = [[UIBarButtonItem alloc]initWithTitle:@"Cal" style:UIBarButtonItemStyleBordered target:self action:@selector(gotoMontlyView)];
    self.navigationItem.rightBarButtonItem = calItem;
//    if (iPHONE_UI && DEVICE_VERSION >= 6.0f)self.navigationItem.rightBarButtonItem = calItem;
//    self.navigationItem.title = @"My Schedule Tasks";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
//        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
//    }
//    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    NavigationToolBarController * nav = (NavigationToolBarController*)self.navigationController;
    [nav.navToolBar setHidden:NO];

    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UILabel * updatedLabel = [[UILabel alloc]initWithFrame:UIEdgeInsetsInsetRect(nav.navToolBar.frame, UIEdgeInsetsMake(10.0f, nav.navToolBar.frame.size.width / 5.0f, 10.0f, nav.navToolBar.frame.size.width / 5.0f))];
    [updatedLabel setFont:ACFontDefault14];
    [updatedLabel setTextColor:[UIColor whiteColor]];
    [updatedLabel setText:[NSString updateLabelDateStringFromDate:[NSDate date]]];
    [updatedLabel setTextAlignment:NSTextAlignmentCenter];
    [updatedLabel setBackgroundColor:[UIColor clearColor]];
    UIBarButtonItem * labelItem = [[UIBarButtonItem alloc]initWithCustomView:updatedLabel];
    
    UIBarButtonItem * composeItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeTask)];
    nav.navToolBar.items = [NSArray arrayWithObjects:spaceItem,labelItem,spaceItem,composeItem, nil];
}

//- (void) viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
////    double lastRow = ceil([[UIScreen mainScreen]bounds].size.height / self.tableView.rowHeight);
////    int rows = [[NSNumber numberWithDouble:lastRow] intValue];
////    if ([self.tableView numberOfRowsInSection:0] < rows) self.loadMoreFooter.hidden = YES;
//    
//}
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

#pragma mark - NSNotification

- (void) receiveTestNotification:(NSNotification*)notification
{
    if ([[notification name]isEqualToString:@"TestNotification" ])
    {
        [self.tableView reloadData];
    }
}


#pragma mark - UITableView Datasource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    cell.dateLabel.text = [NSString customizedCellDateStringFromDate:[NSDate date]];
    cell.taskLabel.text = @"HHA Visit";
    cell.statusLabel.text = @"Upcoming";

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
    VisitViewController * vc = [[VisitViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
