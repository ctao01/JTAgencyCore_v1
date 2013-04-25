//
//  HomeTableViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/17/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "HomeTableViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface HomeTableViewController ()
@property (nonatomic , strong)  UIView * headerView;
@end

@implementation HomeTableViewController
- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
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
   
    if (iPHONE_UI && UserInterface_Portrait) self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, Bounds_Screen.size.width, Bounds_Screen.size.height * 0.66f)];
    else if (iPHONE_UI && UserInterface_Landscape)
        self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, Bounds_Screen.size.height, Bounds_Screen.size.width * 0.45f)];
    else if (iPAD_UI && UserInterface_Portrait)
        self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, Bounds_Screen.size.width, Bounds_Screen.size.height * 0.6f )];

    else if (iPAD_UI && UserInterface_Landscape)
        self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, Bounds_Screen.size.height, Bounds_Screen.size.width * 0.6f)];
       
    self.headerView.backgroundColor = [UIColor grayColor];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.scrollEnabled = NO;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSNotification Center

- (void) receiveTestNotification:(NSNotification*)notice
{
    if ([[notice name]isEqualToString:@"TestNotification" ])
    {
        if (iPHONE_UI && UserInterface_Portrait)
            self.headerView.frame = CGRectMake(0.0f, 0.0f, Bounds_Screen.size.width, Bounds_Screen.size.height * 0.66f);
        else if (iPHONE_UI && UserInterface_Landscape)
            self.headerView.frame = CGRectMake(0.0f, 0.0f, Bounds_Screen.size.height, Bounds_Screen.size.width * 0.45f);
        else if (iPAD_UI && UserInterface_Portrait )
            self.headerView.frame = CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, self.tableView.frame.size.height * 0.8f);

        else if (iPAD_UI && UserInterface_Landscape )
            self.headerView.frame = CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, self.tableView.frame.size.height * 0.75f);
    }
    self.tableView.tableHeaderView = self.headerView;

    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
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
    UILabel * badgeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 24.0f, 24.0f)];
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.layer.cornerRadius = 4.0f;
    badgeLabel.backgroundColor = ACColorRed;
    badgeLabel.textColor = [UIColor whiteColor];
    badgeLabel.font = ACFontDefaultBold16;

    if (indexPath.section == 0)
    {
        cell.textLabel.text = @"My Messages";
        badgeLabel.text = @"4";
    }
    else if (indexPath.section == 1)
    {
        cell.textLabel.text = @"My Schedule";
        badgeLabel.text = @"11";
    }
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.accessoryView = badgeLabel;
    // Configure the cell...
    
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section  == 0 )
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Messages"];
    else if (indexPath.section == 1)
        self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Schedule"];

}

@end
