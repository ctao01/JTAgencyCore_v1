//
//  VisitViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/8/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "ScheduleDetailViewController.h"
#import "VisitHeaderView.h"
#import "CommentsViewController.h"
#import "NavigationToolBarController.h"
#import "NewTaskViewController.h"

@interface ScheduleDetailViewController ()
@property (nonatomic , strong) VisitHeaderView * visitHeaderView;
@property (nonatomic , strong) UILabel * updatedLabel;

@property (nonatomic , strong) UIActivityIndicatorView * activityIndicator;
@property (nonatomic , strong) UIView * overlayView;

@end

@implementation ScheduleDetailViewController
@synthesize taskObject = _taskObject;

- (void) setTaskObject:(NSDictionary *)newObject
{
    if (_taskObject == newObject) return;
    
    _taskObject = newObject;
    self.visitHeaderView.taskObject = newObject;
    [self.visitHeaderView layoutIfNeeded];
    
    [self.tableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 49.0f, 0.0f);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    self.visitHeaderView = [[VisitHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 90.0f)];
    self.visitHeaderView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.tableHeaderView = self.visitHeaderView;

    self.navigationItem.title = @"My Schedule";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NavigationToolBarController * nav = (NavigationToolBarController*)self.navigationController;
    [nav.navToolBar setHidden:NO];
    
//    UIBarButtonItem * syncItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(manualSyncData)];
    
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.updatedLabel = [UILabel updatedLabelWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 44.0f)];
    [self.updatedLabel setText:[NSString updateLabelDateStringFromDate:[NSDate date]]];
    UIBarButtonItem * labelItem = [[UIBarButtonItem alloc]initWithCustomView:self.updatedLabel];
    
    UIBarButtonItem * composeItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeTask)];
    nav.navToolBar.items = [NSArray arrayWithObjects:spaceItem,labelItem,spaceItem,composeItem, nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NavigationToolBarController * nav = (NavigationToolBarController*)self.navigationController;
    [nav.navToolBar setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void) composeTask
{
    NewTaskViewController * vc = [[NewTaskViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self presentViewController:nc animated:YES completion:^{}];
}


#pragma mark - Manual Sync Method

//- (void) manualSyncData
//{
//    self.overlayView.backgroundColor = [UIColor colorWithRed:80.0f/255.0 green:80.0f/255.0 blue:80.0f/255.0 alpha:0.4f];
//    
//    self.activityIndicator.hidden = NO;
//    [self.activityIndicator startAnimating];
//    [self performSelector:@selector(completeLoadingData) withObject:nil afterDelay:5.0f];
//}
//
//- (void)completeLoadingData
//{
//    self.updatedLabel.text = [NSString updateLabelDateStringFromDate:[NSDate date]];
//    [self.updatedLabel layoutIfNeeded];
//    [self.activityIndicator stopAnimating];
//    self.overlayView.backgroundColor = [UIColor clearColor];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([[self.taskObject objectForKey:@"task_status"] isEqualToString:@"Missed"])  return 3;
    else return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    if (indexPath.section == 0) cell.textLabel.text = @"Episode Comments";
    else if (indexPath.section == 1) cell.textLabel.text = @"Visit Comments";
    else cell.textLabel.text = @"Missed Visited Form";
    
    if (iPHONE_UI) cell.textLabel.font = ACFontDefaultBold16;
    else cell.textLabel.font = ACFontDefaultBold18;
    return cell;
}
#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundView = [[UIImageView alloc]init];
    cell.selectedBackgroundView = [[UIImageView alloc]init];
    ((UIImageView*) cell.backgroundView).image = nil;
    ((UIImageView*) cell.selectedBackgroundView).image = nil;
    UIImage * backgroundImage = [[UIImage imageNamed:@"btn_Gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 0.0f, 6.0f)];
    UIImage * selectedBackgroundImage = [[UIImage imageNamed:@"btn_Red"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 0.0f, 6.0f)];
    ((UIImageView*) cell.backgroundView).image = backgroundImage;
    ((UIImageView*) cell.selectedBackgroundView).image = selectedBackgroundImage;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentsViewController * vc = [[CommentsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    if (indexPath.row == 0)
        vc.title = @"Episode Comments";
    else if (indexPath.row == 1)
        vc.title = @"Visit Comments";
    else
        vc.title = @"Missed Visited Form";
    
    [vc setTaskObject:self.taskObject];
}


@end
