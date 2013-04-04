//
//  SecondTopViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "AccountViewController.h"
#import "BasicCustomCell.h"
#import "LogInViewController.h"
#import "MenuViewController.h"
#import "SettingViewController.h"
#import "ACNavigationController.h"

@interface AccountViewController ()
{
    NSDictionary * tempUser; 
}
//@property (nonatomic , strong) UITableView * tableView;
@end

@implementation AccountViewController

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
    self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
  }
  self.slidingViewController.underRightViewController = nil;
  
  [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (IBAction)revealMenu:(id)sender
{
  [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - Programmatically

- (void) gotoSettings
{
    SettingViewController * vcSettings = [[SettingViewController alloc]initWithStyle:UITableViewStyleGrouped];
//    ACNavigationController * ncSettings = [[ACNavigationController alloc]initWithRootViewController:vcSettings];
    
    [self.navigationController pushViewController:vcSettings animated:YES];
//    [self.navigationController presentViewController:ncSettings animated:YES completion:^{}];
}

- (void) receiveTestNotification:(NSNotification*)notification
{
    if ([[notification name]isEqualToString:@"TestNotification" ])
        [self.tableView reloadData];
}

#pragma mark -

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * menuItem = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(revealMenu:)];
    self.navigationItem.leftBarButtonItem = menuItem;
    self.title = @"My Account";
    
    UIBarButtonItem * settingsItem = [[UIBarButtonItem alloc]initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(gotoSettings) ];
    self.navigationItem.rightBarButtonItem = settingsItem;
    
    CGRect footerFrame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 120.0f);
    UIView * footerView = [[UIView alloc]initWithFrame:footerFrame];
    footerView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = footerView;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 44.0f, 0.0f);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];

}

#pragma mark - UITableView DataSource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString * cell = @"MyAccountCell";
    static NSString * iPhone_portrait_cell = @"iPhone_Portrait_Cell";
    static NSString * iPhone_landscape_cell = @"iPhone_Landscape_Cell";
    static NSString * iPad_portrait_cell = @"iPad_Portrait_Cell";
    static NSString * iPad_landscape_cell = @"iPad_Landscape_Cell";

//    BasicCustomCell * accountCell = [tableView dequeueReusableCellWithIdentifier:cell1ID];
    BasicCustomCell * accountCell;
    
    if (iPHONE_UI && UserInterface_Portrait)
        accountCell = [tableView dequeueReusableCellWithIdentifier:iPhone_portrait_cell];
    else if (iPHONE_UI && UserInterface_Landscape)
        accountCell =  [tableView dequeueReusableCellWithIdentifier:iPhone_landscape_cell];
    else if (iPAD_UI && UserInterface_Portrait)
        accountCell = [tableView dequeueReusableCellWithIdentifier:iPad_portrait_cell];
    else if (iPAD_UI && UserInterface_Landscape)
        accountCell = [tableView dequeueReusableCellWithIdentifier:iPad_landscape_cell];
    
    if (accountCell == nil)
    {
        if (iPHONE_UI && UserInterface_Portrait)
            accountCell = [[BasicCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPhone_portrait_cell];
        else if (iPHONE_UI && UserInterface_Landscape)
            accountCell = [[BasicCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPhone_landscape_cell];
        else if (iPAD_UI && UserInterface_Portrait)
            accountCell = [[BasicCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPad_portrait_cell];
        else if (iPAD_UI && UserInterface_Landscape)
            accountCell = [[BasicCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPad_landscape_cell];
        else
            accountCell = nil;
    }
    
    switch (indexPath.row) {
        case 0:
        {
            accountCell.titleLabel.text = @"Name";
            accountCell.dataLabel.text = @"Edem Jimbo";
            accountCell.dataLabel.font = ACFontDefaultBold18;
        }
            break;
        case 1:
        {
            accountCell.titleLabel.text = @"Agency";
            accountCell.dataLabel.text = @"Sunny Bobo Agnecy";
        }
            break;
        case 2:
        {
            accountCell.titleLabel.text = @"Address";
            accountCell.dataLabel.text = @"8035 E R L Thomton Fwy # 147 Dallas,Texas 76006";
            accountCell.dataLabel.lineBreakMode = NSLineBreakByWordWrapping;
            accountCell.dataLabel.numberOfLines = 0.0f;
        }
            break;
        case 3:
        {
            accountCell.titleLabel.text = @"Phone";
            accountCell.dataLabel.text = @"(214)660-4400";
        }
            break;
            
        default:
            break;
    }
    accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return accountCell;
}

@end
