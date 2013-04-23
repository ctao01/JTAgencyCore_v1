//
//  NewTaskViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/9/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "NewTaskViewController.h"
//#import "TasksTableViewController.h"
#import "UserListViewController.h"
#import "TaskCategoriesViewController.h"

@interface NewTaskViewController ()
{
    UIDatePicker * datePicker;
}

@end

@implementation NewTaskViewController

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
    
    UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelAddingTask)];
    self.navigationItem.rightBarButtonItem = cancelItem;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.navigationItem.title = @"New Task";
    self.tableView.scrollsToTop = YES;
    
    CGRect bounds = [[UIScreen mainScreen]bounds];
    if (UserInterface_Portrait) datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y + bounds.size.height + 44.0f, bounds.size.width, bounds.size.height)];
    else if (UserInterface_Landscape) datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y + bounds.size.width + 44.0f, bounds.size.height, bounds.size.width)];

    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    datePicker.date = [NSDate date];
    datePicker.maximumDate =  [[NSDate date] dateByAddingTimeInterval:60 * 60 * 24 * 60];
    [datePicker addTarget:self action:@selector(scheduleTaskDate) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.view addSubview:datePicker];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];
    
}

- (void) dealloc
{
    self.selectedPatient = nil;
    self.selectedUser = nil;
    self.selectedDate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - NSNotification Center

- (void) receiveTestNotification:(NSNotification*)notification
{
    if ([[notification name]isEqualToString:@"TestNotification" ])
    {
        CGRect bounds = [[UIScreen mainScreen]bounds];
        if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Done"])
        {
            if(UserInterface_Landscape) [datePicker setFrame:CGRectMake(bounds.origin.x, bounds.size.width - 250.0f + 44.0f, bounds.size.height, 250.0f)];
            else [datePicker setFrame:CGRectMake(bounds.origin.x, bounds.size.height - 250.0f + 44.0f, bounds.size.width, 250.0f)];
        }
    }
}

#pragma mark - Private Actions

- (void) cancelAddingTask
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}

- (void)scheduleTaskDate
{
    self.selectedDate = datePicker.date;
    [self.tableView reloadData];
}

- (void) selectDateDone
{
    CGRect bounds = [[UIScreen mainScreen]bounds];

    [UIView animateWithDuration:0.3f delay:0.0f options:(UIViewAnimationOptions)UIViewAnimationCurveEaseIn
                     animations:^{
                         if (UserInterface_Landscape) [datePicker setFrame:CGRectMake(bounds.origin.x, bounds.origin.y + bounds.size.width, bounds.size.height, bounds.size.width)];
                         else [datePicker setFrame:CGRectMake(bounds.origin.x, bounds.origin.y + bounds.size.height, bounds.size.width, bounds.size.height)];
                     }
                     completion:^(BOOL finished){
                         UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelAddingTask)];
                         self.navigationItem.rightBarButtonItem = cancelItem;
                         self.navigationItem.leftBarButtonItem = nil;
//                         [self scheduleTaskDate];
                     }];
}

- (void) selectDateCancel
{
    self.selectedDate = nil;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 5;
    else if (section == 1) return 1;
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (indexPath.section == 0)
    {
        if (cell == nil) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];

        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"Patient";
            cell.detailTextLabel.text = self.selectedPatient ? self.selectedPatient:nil;
        }
        else if (indexPath.row == 1)
            cell.textLabel.text = @"Episode";
        else if (indexPath.row == 2)
        {
            cell.textLabel.text = @"Date";
            cell.detailTextLabel.text = self.selectedDate ? [NSString shortDateAndTimeStyleStringFromDate:self.selectedDate]:nil;
        }
        else if (indexPath.row == 3)
        {
            cell.textLabel.text = @"Task";
            cell.detailTextLabel.text = self.selectedTask ? self.selectedTask : nil;
        }
        else
        {
            cell.textLabel.text = @"User";
            cell.detailTextLabel.text = self.selectedUser ? self.selectedUser : nil;
            
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;

    }
    else if (indexPath.section == 1)
    {
        if (cell == nil) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        cell.textLabel.text = @"Add";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        
        cell.textLabel.center = cell.center;
    }
   
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) return 42.0f;
    else return 44.0f;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        cell.backgroundView = [[UIImageView alloc]init];

        ((UIImageView*) cell.backgroundView).image = nil;
        UIImage * backgroundImage = [[UIImage imageNamed:@"btn_Red"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 0.0f, 6.0f)];
        ((UIImageView*) cell.backgroundView).image = backgroundImage;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect bounds = [[UIScreen mainScreen]bounds];
    if (indexPath.section == 0)
    {
        if (indexPath.row != 2) [self selectDateDone];
        else
        {
            [UIView animateWithDuration:0.4f delay:0.0f options:(UIViewAnimationOptions)UIViewAnimationCurveEaseIn
                             animations:^{
                                 if(UserInterface_Landscape) [datePicker setFrame:CGRectMake(bounds.origin.x, bounds.size.width - 250.0f + 44.0f, bounds.size.height, 250.0f)];
                                 else [datePicker setFrame:CGRectMake(bounds.origin.x, bounds.size.height - 250.0f + 44.0f, bounds.size.width, 250.0f)];
                             }
                             completion:^(BOOL finished){
                                 UIBarButtonItem * doneItem = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(selectDateDone)];
                                 self.navigationItem.rightBarButtonItem = doneItem;
                                 
                                 UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc]initWithTitle:@"Reset" style:UIBarButtonItemStyleBordered target:self action:@selector(selectDateCancel)];
                                 self.navigationItem.leftBarButtonItem = cancelItem;
                                 self.selectedDate = datePicker.date;
                                 [self.tableView reloadData];
                             }];
        }
        
        if (indexPath.row == 0)
        {
            UserListViewController * vc = [[UserListViewController alloc]initWithStyle:UITableViewStylePlain];
            vc.navigationItem.title = @"Patient List";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 3)
        {
            TaskCategoriesViewController * vc = [[TaskCategoriesViewController alloc]initWithStyle:UITableViewStylePlain];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 4)
        {
            UserListViewController * vc = [[UserListViewController alloc]initWithStyle:UITableViewStylePlain];
            vc.navigationItem.title = @"User List";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (indexPath.section == 1)
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
    }

}

@end
