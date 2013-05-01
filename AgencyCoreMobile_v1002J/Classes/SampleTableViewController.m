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

//#import "TaskWithSectionsViewController.h"
//#import "TaskWithSegmentCotrolViewController.h"
//#import "TaskWithSearchViewController.h"

@interface SampleTableViewController()
@end

@implementation SampleTableViewController


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
  return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = @"SampleCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
  }
    NSArray * sampleItems = [NSArray arrayWithObjects:@"Tasks with sections", @"Tasks with segment control", @"Tasks with Search Bar",@"Original home screen", @"Account with avtivity log", nil];
    cell.textLabel.text = [sampleItems objectAtIndex:indexPath.row];
    
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

#pragma mark - 

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0)
//    {
//        TaskWithSectionsViewController * vc = [[TaskWithSectionsViewController alloc]initWithStyle:UITableViewStylePlain];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else if (indexPath.row == 1)
//    {
//        TaskWithSegmentCotrolViewController * vc = [[TaskWithSegmentCotrolViewController alloc]initWithStyle:UITableViewStylePlain];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else if (indexPath.row == 2)
//    {
//        TaskWithSearchViewController * vc = [[TaskWithSearchViewController alloc]initWithStyle:UITableViewStylePlain];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    
    if (indexPath.row == 3)
    {
        HomeViewController * vc = [[HomeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 4)
    {
        Account2ViewController * ac = [[Account2ViewController alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:ac animated:YES];
    }
}

@end
