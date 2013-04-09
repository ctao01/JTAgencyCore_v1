//
//  ThirdTopViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "MessagesViewController.h"
#import "BasicMessageCell.h"
#import "MessageDetailViewController.h"
#import "NavigationToolBarController.h"
#import "MessageComposer.h"
#import "NavigationControllerWithoutRotation.h"

@implementation MessagesViewController

- (IBAction)revealMenu:(id)sender
{
  [self.slidingViewController anchorTopViewTo:ECRight];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NavigationToolBarController * nav = (NavigationToolBarController*)self.navigationController;
    
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UILabel * updatedLabel = [[UILabel alloc]initWithFrame:UIEdgeInsetsInsetRect(nav.navToolBar.frame, UIEdgeInsetsMake(10.0f, nav.navToolBar.frame.size.width / 5.0f, 10.0f, nav.navToolBar.frame.size.width / 5.0f))];
    [updatedLabel setFont:ACFontDefault14];
    [updatedLabel setTextColor:[UIColor whiteColor]];
    [updatedLabel setText:[NSString updateLabelDateStringFromDate:[NSDate date]]];
    [updatedLabel setTextAlignment:NSTextAlignmentCenter];
    [updatedLabel setBackgroundColor:[UIColor clearColor]];
    UIBarButtonItem * labelItem = [[UIBarButtonItem alloc]initWithCustomView:updatedLabel];

    UIBarButtonItem * composeItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeMessage)];
    nav.navToolBar.items = [NSArray arrayWithObjects:spaceItem,labelItem,spaceItem,composeItem, nil];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 49.0f, 0.0f);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.navigationItem.title = @"Message";
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NavigationToolBarController * nav = (NavigationToolBarController*)self.navigationController;
    nav.navToolBar.items = nil;
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - NSNotification

- (void) receiveTestNotification:(NSNotification*)notification
{
    if ([[notification name]isEqualToString:@"TestNotification" ])
    {
        [self.tableView reloadData];
        
    }
}

#pragma mark - UIToolBar Items Actions

- (void) composeMessage
{
    
    MessageComposer * composer = [[MessageComposer alloc]init];
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:composer];
    [self presentViewController:nc animated:YES completion:^{
        [[NSNotificationCenter defaultCenter] removeObserver:self.navigationController];
    }];

}

#pragma mark - UITableView Datasource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString * iPhone_portrait_cell = @"iPhone_Portrait_Cell";
    static NSString * iPhone_landscape_cell = @"iPhone_Landscape_Cell";
    static NSString * iPad_portrait_cell = @"iPad_Portrait_Cell";
    static NSString * iPad_landscape_cell = @"iPad_Landscape_Cell";
//    static NSString * cellID = @"iPad_Landscape_Cell";    
    BasicMessageCell * messageCell ;
    if (iPHONE_UI && UserInterface_Portrait)
        messageCell = [tableView dequeueReusableCellWithIdentifier:iPhone_portrait_cell];
    else if (iPHONE_UI && UserInterface_Landscape)
        messageCell = [tableView dequeueReusableCellWithIdentifier:iPhone_landscape_cell];
    else if (iPAD_UI && UserInterface_Portrait)
        messageCell = [tableView dequeueReusableCellWithIdentifier:iPad_portrait_cell];
    else if (iPAD_UI && UserInterface_Landscape)
        messageCell = [tableView dequeueReusableCellWithIdentifier:iPad_landscape_cell];
    
    if (messageCell == nil)
    {
        if (iPHONE_UI && UserInterface_Portrait)
            messageCell = [[BasicMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPhone_portrait_cell];
        else if (iPHONE_UI && UserInterface_Landscape)
            messageCell = [[BasicMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPhone_landscape_cell];
        else if (iPAD_UI && UserInterface_Portrait)
            messageCell = [[BasicMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPad_portrait_cell];
        else if (iPAD_UI && UserInterface_Landscape)
            messageCell = [[BasicMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPad_landscape_cell];
        else
            messageCell = nil;
    }
        
        
    messageCell.senderLabel.text = @"Sender";
    messageCell.subjectLabel.text = @"Subject";
    messageCell.messageLabel.text = @"Dear Customer,Axxess is social!Follow us on Twitter, Facebook, LinkedIn, and Instagram to network with thousands of Home Health professionals, receive updates on what Axxess is up to, as well as obtain the latest industry information and trends to keep you running your agency efficiently and successfully.";
    /* manage Categories later */
    /*NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateStyle:NSDateFormatterShortStyle];
   
    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow: -(60.0f * 60.0f * 24.0f)];
    NSDate * previousDay = [NSDate dateWithTimeIntervalSinceNow: -(10 * 60.0f * 60.0f * 24.0f)];

    // For temp
    if (indexPath.row % 3 == 1)messageCell.dateLabel.text = [NSString messageCellDateStringFromDate:yesterday];
    else if (indexPath.row % 3 == 0)messageCell.dateLabel.text = [NSString messageCellDateStringFromDate:[NSDate date]];
    else messageCell.dateLabel.text = [NSString messageCellDateStringFromDate:previousDay];*/
    messageCell.dateLabel.text = [NSString customizedCellDateStringFromDate:[NSDate date]];
    
    return messageCell;
}
#pragma mark - UITableView Delegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // temp
    MessageDetailViewController * vc = [[MessageDetailViewController alloc]initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
