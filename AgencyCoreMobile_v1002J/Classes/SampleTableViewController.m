//
//  SampleTableViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 2/13/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "SampleTableViewController.h"
#import "Account2ViewController.h"
#import "HomeViewController.h"

#import "TaskWithSectionsViewController.h"

@interface SampleTableViewController()
@property (nonatomic, strong) NSArray *sampleItems;
@end

@implementation SampleTableViewController
@synthesize sampleItems;

- (void)awakeFromNib
{
  self.sampleItems = [NSArray arrayWithObjects:@"Tasks With Sections", @"Tasks With Segment Control", @"Account With Activity Log",@"Original Home Screen", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
  return self.sampleItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = @"SampleCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
  }
  
  cell.textLabel.text = [self.sampleItems objectAtIndex:indexPath.row];
  
  return cell;
}

- (IBAction)revealMenu:(id)sender
{
  [self.slidingViewController anchorTopViewTo:ECRight];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

#pragma mark - UITableView Data Source

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        TaskWithSectionsViewController * vc = [[TaskWithSectionsViewController alloc]initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 1)
    {
        
    }
    else if (indexPath.row == 2)
    {
        Account2ViewController * ac = [[Account2ViewController alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:ac animated:YES];
    }
    else if (indexPath.row == 3)
    {
        HomeViewController * vc = [[HomeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    }

}



@end
