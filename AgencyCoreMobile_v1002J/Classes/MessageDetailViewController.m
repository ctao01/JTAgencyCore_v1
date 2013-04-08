//
//  MessageDetailViewController.m
//  AgencyCoreMobile_v1002
//
//  Created by Joy Tao on 3/20/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "NavigationToolBarController.h"
#import "BasicOneLineCell.h"
#import "MessageSubjectCell.h"
#import "MessageComposer.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NavigationToolBarController * nav = (NavigationToolBarController *) self.navigationController;
    
    UIBarButtonItem * trashItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:nil action:nil];
    UIBarButtonItem * forwardItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(forwardMessage)];
    UIBarButtonItem * replyItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(replyMessage)];
    UIBarButtonItem * composeItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeMessage)];
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    nav.navToolBar.items = [NSArray arrayWithObjects:trashItem,spaceItem,forwardItem,spaceItem,replyItem,spaceItem,composeItem, nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 0.0f)];
    NSString * message = @"Dear Customer,Axxess is social!Follow us on Twitter, Facebook, LinkedIn, and Instagram to network with thousands of Home Health professionals, receive updates on what Axxess is up to, as well as obtain the latest industry information and trends to keep you running your agency efficiently and successfully. \nJoin the movement!Facebook: https://www.facebook.com/axxess \n Twitter: https://twitter.com/AxxessConsult \nLinkedin: http://www.linkedin.com/company/axxess-consult \nInstagram: http://instagram.com/axxessconsult \nSincerely, \nThe Axxess Team.";
    textView.text = message;
    textView.font = ACFontDefault14;
    textView.editable = NO;
    CGRect textFrame = textView.frame;
    textView.contentSize = [message sizeWithFont:[textView font]
                               constrainedToSize:CGSizeMake(self.tableView.frame.size.width, self.tableView.frame.size.height - 44 * 3)
                                   lineBreakMode:UIViewAutoresizingFlexibleHeight];
    
    textFrame.size.height = textView.contentSize.height;
    textView.frame = UIEdgeInsetsInsetRect(textFrame, UIEdgeInsetsMake(10.0f, 10.0f, 0.0f, 10.0f));
    textView.tag = 30007;
   
    UIView * headerView =[[UIView alloc]initWithFrame:textFrame];
    [headerView addSubview:textView];
    self.tableView.tableFooterView = headerView;
    self.navigationItem.title = @"Message";
    
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 49.0f, 0.0f);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];

}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NavigationToolBarController * nav = (NavigationToolBarController*)self.navigationController;
    nav.navToolBar.items = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSNotification 

- (void) receiveTestNotification:(NSNotification*)notification
{
//    if ([[notification name]isEqualToString:@"TestNotification" ])
//    {
//    }
}

#pragma mark - UIToolBar Actions

//- (void) forwardMessage
//{
//    UIActionSheet * sheet =
//}

- (void) replyMessage
{
    NavigationToolBarController * nav = (NavigationToolBarController *) self.navigationController;

    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Reply", @"Reply All", nil];
    [sheet showFromToolbar:nav.navToolBar];
}

- (void) composeMessage
{
    
    MessageComposer * composer = [[MessageComposer alloc]init];
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:composer];
    [self presentViewController:nc animated:YES completion:^{
        [[NSNotificationCenter defaultCenter] removeObserver:self.navigationController];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier1 = @"AccountCell";
    static NSString * CellIdentifier2 = @"SubjectCell";
    UITableViewCell * cell = nil;
    
    if (indexPath.row != 2)
    {
        BasicOneLineCell * cell1 = (BasicOneLineCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell1 == nil) cell1 = (BasicOneLineCell*)[[BasicOneLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        if (indexPath.row == 0)
        {
            cell1.titleLabel.text = @"From";
            cell1.dataLabel.text = @"Axxess";
        }
        else if (indexPath.row == 1)
        {
            cell1.titleLabel.text = @"To";
            cell1.dataLabel.text = @"Edem Jimbo";
        }
        
        cell = (UITableViewCell*)cell1;
    }
    else
    {
        MessageSubjectCell * cell2= [tableView dequeueReusableCellWithIdentifier:CellIdentifier2] ;
        if (cell2 == nil) cell2 = (MessageSubjectCell*)[[MessageSubjectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        cell2.titleLabel.text = @"Subject";
        cell2.subjectLabel.text = @"Recently Axxess Subject";
        cell2.updatedLabel.text = [NSString detailDateStringFromDate:[NSDate date]];
        cell = cell2;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 44.0f;
}

@end
