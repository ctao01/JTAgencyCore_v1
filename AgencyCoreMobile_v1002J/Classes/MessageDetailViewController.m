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
@property (nonatomic , strong) UITextView * textView ;
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
    UIBarButtonItem * replyItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(replyMessage:)];
    UIBarButtonItem * composeItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeMessage)];
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    nav.navToolBar.items = [NSArray arrayWithObjects:trashItem,spaceItem,forwardItem,spaceItem,replyItem,spaceItem,composeItem, nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 0.0f)];
    if (UserInterface_Portrait)
        self.textView = [self messageTextViewFromFrame:CGRectMake(0.0f, 0.0f, width(self.view.frame), 0.0f)];
    else if (UserInterface_Landscape)
            self.textView = [self messageTextViewFromFrame:CGRectMake(0.0f, 0.0f, height(self.view.frame), 0.0f)];
   
    UIView * headerView =[[UIView alloc]initWithFrame:UIEdgeInsetsInsetRect(self.textView.frame, UIEdgeInsetsMake(0.0f, -10.0f, 0.0f, -10.0f))];
    [headerView addSubview:self.textView];

    self.tableView.tableFooterView = headerView;
    NSLog(@"self.tableView.tableFooterView:%@",NSStringFromCGRect(self.tableView.tableFooterView.frame));

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
#pragma mark - 

- (UITextView*) messageTextViewFromFrame:(CGRect)frame
{
    UITextView * tv = [[UITextView alloc]initWithFrame:frame];
    tv.scrollEnabled = NO;
    NSString * message = @"Dear Customer,Axxess is social!Follow us on Twitter, Facebook, LinkedIn, and Instagram to network with thousands of Home Health professionals, receive updates on what Axxess is up to, as well as obtain the latest industry information and trends to keep you running your agency efficiently and successfully. \nJoin the movement!Facebook: https://www.facebook.com/axxess \n Twitter: https://twitter.com/AxxessConsult \nLinkedin: http://www.linkedin.com/company/axxess-consult \nInstagram: http://instagram.com/axxessconsult \nSincerely, \nThe Axxess Team.";
    tv.text = message;
    if (iPHONE_UI)  tv.font = ACFontDefault14;
    else if (iPAD_UI) tv.font = ACFontDefault16;
    tv.editable = NO;
    CGRect textFrame = frame;
    tv.contentSize = [message sizeWithFont:[tv font]
                                    constrainedToSize:CGSizeMake(self.tableView.frame.size.width - 20.0f, height(Bounds_Screen))
                                        lineBreakMode:UIViewAutoresizingFlexibleHeight];
    
    textFrame.size.height = tv.contentSize.height + UINAVIGATION_BAR_HEIGHT;
    NSLog(@"origin:%@",NSStringFromCGRect(textFrame));

    tv.frame = UIEdgeInsetsInsetRect(textFrame, UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f));
    NSLog(@"tv.frame:%@",NSStringFromCGRect(tv.frame));

    return tv;
}

#pragma mark - NSNotification 

- (void) receiveTestNotification:(NSNotification*)notification
{
    if ([[notification name]isEqualToString:@"TestNotification" ])
    {
        self.textView = [self messageTextViewFromFrame:CGRectMake(0.0f, 0.0f, width(self.view.frame), 0.0f)];
        UIView * headerView =[[UIView alloc]initWithFrame:UIEdgeInsetsInsetRect(self.textView.frame, UIEdgeInsetsMake(0.0f, -10.0f, 0.0f, -10.0f))];
        [headerView addSubview:self.textView];
        self.tableView.tableFooterView = headerView;
        [self.tableView reloadData];
    }
}

#pragma mark - UIToolBar Actions

//- (void) forwardMessage
//{
//    UIActionSheet * sheet =
//}

- (void) replyMessage:(id)sender
{
    NavigationToolBarController * nav = (NavigationToolBarController *) self.navigationController;

    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:@"Reply" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Reply", @"Reply All", nil];
    if (iPAD_UI)    [sheet showFromBarButtonItem:sender animated:YES];
    else    [sheet showFromToolbar:nav.navToolBar];
}

- (void) composeMessage
{
    
    MessageComposer * composer = [[MessageComposer alloc]init];
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:composer];
    [self presentViewController:nc animated:YES completion:^{
        [[NSNotificationCenter defaultCenter] removeObserver:self.navigationController];
        composer.navigationItem.title = @"New Message";
    }];
    
}
#pragma mark - Action Sheet Delegate

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex == actionSheet.cancelButtonIndex) return;
    if ([actionSheet.title isEqualToString:@"Reply"])
    {
        NSMutableArray * senders;
        if (buttonIndex == 0)
            senders = [NSMutableArray arrayWithObjects:@"Axxess 1", nil];
        else if (buttonIndex == 1)
        {
            senders = [[NSMutableArray alloc]init];
            for (int count = 0; count < 7; count ++)
                [senders addObject:[NSString stringWithFormat:@"Axxess %i",count]];
        }
        NSDictionary * dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:
                                     senders, @"sender",
                                     @"joy Tao", @"receiver",
                                     self.textView.text, @"content", nil];
        MessageComposer * composer = [[MessageComposer alloc]init];
        composer.title = @"Reply";
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:composer];
        [self presentViewController:nc animated:YES completion:^{
            [[NSNotificationCenter defaultCenter] removeObserver:self.navigationController];
            composer.messageObject = dictionary;
            NSLog(@"object%@",dictionary);
        }];
    }
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
    if (iPAD_UI && indexPath.row == 2) return 50.0f;
    else return 44.0f;
}

@end
