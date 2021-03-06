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

@interface MessagesViewController () < UISearchDisplayDelegate >
//{
//    UIActivityIndicatorView * indicator;
//}
@property (nonatomic , strong) NSMutableArray * counts;
@property (nonatomic , strong) UISearchDisplayController * searchController;
@property (nonatomic , strong) UISearchBar * searchBar;
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
    UILabel * updatedLabel = [UILabel updatedLabelWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 44.0f)];
    [updatedLabel setText:[NSString updateLabelDateStringFromDate:[NSDate date]]];
    UIBarButtonItem * labelItem = [[UIBarButtonItem alloc]initWithCustomView:updatedLabel];

    UIBarButtonItem * composeItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeMessage)];
    nav.navToolBar.items = [NSArray arrayWithObjects:spaceItem,labelItem,spaceItem,composeItem, nil];
    
    [self layoutIfRotated];
}

- (void) viewDidLoad
{
    self.counts = [[NSMutableArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    
    [super viewDidLoad];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 49.0f, 0.0f);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    self.navigationItem.title = @"My Messages";
    UIBarButtonItem * editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(editTable:)];
    self.navigationItem.rightBarButtonItem = editButton;
    self.editing = NO;
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, width(self.tableView.frame), 44.0f)];
//    self.searchBar.barStyle = UIBarStyleBlackOpaque;
    self.searchBar.tintColor = ACColorGray80;
    self.searchController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.delegate = self;
    
    self.tableView.tableHeaderView = self.searchBar;

}

- (void) viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];
    [super viewDidAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    NSString * postString = [NSString stringWithFormat:@"http://mobileapi.axxessweb.com/Messaging/Fetch?tokenid=%@&deviceid=%@&inboxtype=0&pagesize=30&pagenumber=1",[[NSUserDefaults standardUserDefaults]objectForKey:@"User_Token"],[[NSUserDefaults standardUserDefaults]objectForKey:@"udidKey"]];
//    
//    NSURLResponse * response = nil;
//    NSError * error = nil;
//    
//    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:postString]];
//    [urlRequest setHTTPMethod:@"POST"];
//    NSData * receivedData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
//    if (error == nil)
//    {
//        id result = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:&error];
//        NSLog(@"result%@",result);
//        
//    }
    
    NavigationToolBarController * nav = (NavigationToolBarController*)self.navigationController;
    nav.navToolBar.items = nil;
}

- (void) viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidDisappear:YES];
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

#pragma mark - UIsearchController Delegate Method
- (void) filterContentForSearchText:(NSString*)searchText andScope:(NSString*)scope
{
    //    NSPredicate * result = [NSPredicate predicateWithFormat:@"SELF contains[cd]%@",searchText];
    //    self.searchedContacts = [self.contacts filteredArrayUsingPredicate:result];
}

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString andScope:nil];
    return YES;
}

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[controller.searchBar text] andScope:nil];
    return YES;
}

#pragma mark - NSNotification

- (void) receiveTestNotification:(NSNotification*)notification
{
    if ([[notification name]isEqualToString:@"TestNotification" ])
    {
        [self layoutIfRotated];
    }
}

#pragma mark - Editable Table Method
- (void) editTable:(id)sender{
	if(self.editing)
	{
		[super setEditing:NO animated:NO];
		[self.tableView setEditing:NO animated:NO];
		[self.tableView reloadData];
		[self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleBordered];
	}
	else
	{
		[super setEditing:YES animated:YES];
		[self.tableView setEditing:YES animated:YES];
		[self.tableView reloadData];
        
		[self.navigationItem.rightBarButtonItem setTitle:@"Done"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
	}
}

#pragma mark - UIToolBar Items Actions

- (void) composeMessage
{
    MessageComposer * composer = [[MessageComposer alloc]init];
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:composer];
    [self presentViewController:nc animated:YES completion:^{
        [[NSNotificationCenter defaultCenter] removeObserver:self.navigationController];
        composer.navigationItem.title = @"New Message";
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
    messageCell.subjectLabel.text = @"Subject1234567890";
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
    messageCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    messageCell.selectionStyle = UITableViewCellSelectionStyleGray;
    if (indexPath.row == 0 )
        messageCell.statusImageView.hidden = NO;
    
    if (indexPath.row % 3 == 0)
        messageCell.attachedImageView.hidden = NO;
    
    
    return messageCell;
}
#pragma mark - UITableView Delegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (iPHONE_UI) return 90.0f;
    else return 110.0f;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // temp
    MessageDetailViewController * vc = [[MessageDetailViewController alloc]initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView reloadData];
    
}
#pragma mark - UIScrollView Delegate
@end
