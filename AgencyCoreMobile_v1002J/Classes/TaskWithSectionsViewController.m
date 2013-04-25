//
//  TaskWithSectionsViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/25/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "TaskWithSectionsViewController.h"
#import "BasicTwoLinesCell.h"

@interface TaskWithSectionsViewController ()

@end

@implementation TaskWithSectionsViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableView Data Source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 10;
    else if (section == 1) return 3;
    else return 28;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    cell.taskLabel.text = @"HHA Visit";
    if (indexPath.section == 0){
        cell.dateLabel.text = [NSString customizedCellDateStringFromDate:[NSDate dateFromString:@"2013-04-30 10:00:00 -0500"]];
        cell.statusLabel.text = @"Upcoming";
    }
    else if (indexPath.section == 1)
    {
        cell.dateLabel.text = [NSString customizedCellDateStringFromDate:[NSDate dateFromString:@"2013-04-11 10:00:00 -0500"]];
        cell.statusLabel.text = @"Missed";
    }
    else
    {
        cell.dateLabel.text = [NSString customizedCellDateStringFromDate:[NSDate dateFromString:@"2013-04-02 10:00:00 -0500"]];
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

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32.0f;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, width(self.view.frame), 32.0f)];
    
    UILabel * label = [[UILabel alloc]initWithFrame:UIEdgeInsetsInsetRect(header.frame, UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f))];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = ACFontDefaultBold18;
    
    if (section == 0 )
    {
        header.backgroundColor = ACColorTaskScheduledBlue;
        label.text = @"Upcoming";
    }
    else if (section == 1 )
    {
        header.backgroundColor = ACColorTaskMissedRed;
        label.text = @"Missed";
    }
    else if (section == 2 )
    {
        header.backgroundColor = ACColorTaskCompletedGreen;
        label.text = @"Completed";
    }
    [header addSubview:label];
    
    return header;
}

//- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) return @"Upcoming";
//    else if (section == 1) return @"Missed";
//    else return @"Completed";
//}
@end
