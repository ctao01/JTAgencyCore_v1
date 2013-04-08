//
//  VisitViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/8/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "VisitViewController.h"
#import "VisitHeaderView.h"
#import "CommentsViewController.h"
#import "NavigationToolBarController.h"

@interface VisitViewController ()
@property (nonatomic , strong) VisitHeaderView * visitHeaderView;
@end

@implementation VisitViewController

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

    self.visitHeaderView = [[VisitHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 90.0f)];
    self.visitHeaderView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.tableHeaderView = self.visitHeaderView;

    self.navigationItem.title = @"Schedule";
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NavigationToolBarController * nav = (NavigationToolBarController*)self.navigationController;
    [nav.navToolBar setHidden:NO];

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
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
    
    return cell;
}
#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundView = [[UIImageView alloc]init];
    ((UIImageView*) cell.backgroundView).image = nil;
    UIImage * backgroundImage = [[UIImage imageNamed:@"btn_Gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 0.0f, 6.0f)];
    ((UIImageView*) cell.backgroundView).image = backgroundImage;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentsViewController * vc = [[CommentsViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
