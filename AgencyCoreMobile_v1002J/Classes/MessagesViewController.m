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

@interface MessagesViewController ()
//{
//    UIActivityIndicatorView * indicator;
//}
@property (nonatomic , strong) NSMutableArray * counts;
@end

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
//    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.tableView.contentInset.top, self.tableView.contentInset.left, 52.0f, self.tableView.contentInset.right);

    self.navigationItem.title = @"Message";
//    self.count = 20;
    self.counts = [[NSMutableArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    /*UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 49.0f)];
    indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    indicator.center = footerView.center;
    [footerView addSubview:indicator];
    self.tableView.tableFooterView = footerView;*/
   
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

#pragma mark - ACTableViewController Method

- (void) loadMore
{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0]-1 inSection:0];
    for (int i = 0; i < 10; i++)
        [self.counts addObject:@"aaa"];
    [self performSelector:@selector(stopLoadinMore:) withObject:indexPath afterDelay:2.0];

}

- (void) stopLoadinMore:(NSIndexPath*)indexPath
{
    [super stopLoadinMore];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
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
    return [self.counts count];
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
        
        
    messageCell.senderLabel.text = [NSString stringWithFormat:@"Sender:%@",[self.counts objectAtIndex:indexPath.row]];
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

#pragma mark - UIScrollView Delegate
/*
- (void) loadingMoreData
{
    self.count ++;
    [self.tableView reloadData];
    [indicator stopAnimating];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentOffset = self.tableView.contentOffset.y;
    NSInteger maximumOffset = self.tableView.contentSize.height - self.tableView.frame.size.height;
    
    // Change 10.0 to adjust the distance from bottom
    if (maximumOffset - currentOffset <= -49.0f - 44.0f) {
        [indicator startAnimating];
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(loadingMoreData) userInfo:nil repeats:NO];
 [self performSelector:@selector(stopAnimatingFooter) withObject:nil afterDelay:0.5];

    }
}
*/
@end
