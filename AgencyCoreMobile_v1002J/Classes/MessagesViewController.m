//
//  ThirdTopViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "MessagesViewController.h"
#import "MessageCell.h"
#import "MessageDetailViewController.h"
#import "MessageNavgationViewController.h"
#import "MessageComposer.h"

@implementation MessagesViewController
/*
- (void)awakeFromNib
{
  [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(underLeftWillAppear:)
                                               name:ECSlidingViewUnderLeftWillAppear 
                                             object:self.slidingViewController];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(topDidAnchorRight:) 
                                               name:ECSlidingViewTopDidAnchorRight 
                                             object:self.slidingViewController];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(underRightWillAppear:) 
                                               name:ECSlidingViewUnderRightWillAppear 
                                             object:self.slidingViewController];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(topDidAnchorLeft:) 
                                               name:ECSlidingViewTopDidAnchorLeft 
                                             object:self.slidingViewController];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(topDidReset:) 
                                               name:ECSlidingViewTopDidReset 
                                             object:self.slidingViewController];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
    self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
  }
  
  if (![self.slidingViewController.underRightViewController isKindOfClass:[UnderRightViewController class]]) {
    self.slidingViewController.underRightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UnderRight"];
  }
  
  [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}
*/
- (IBAction)revealMenu:(id)sender
{
  [self.slidingViewController anchorTopViewTo:ECRight];
}
//
//- (void) updateLayoutForNewOrientation: (UIInterfaceOrientation) orientation
//{
//    
//}

/*
// slidingViewController notification
- (void)underLeftWillAppear:(NSNotification *)notification
{
  NSLog(@"under left will appear");
}

- (void)topDidAnchorRight:(NSNotification *)notification
{
  NSLog(@"top did anchor right");
}

- (void)underRightWillAppear:(NSNotification *)notification
{
  NSLog(@"under right will appear");
}

- (void)topDidAnchorLeft:(NSNotification *)notification
{
  NSLog(@"top did anchor left");
}

- (void)topDidReset:(NSNotification *)notification
{
  NSLog(@"top did reset");
}*/

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    MessageNavgationViewController * nav = (MessageNavgationViewController*)self.navigationController;
    
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem * composeItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeMessage)];
    nav.navToolBar.items = [NSArray arrayWithObjects:spaceItem,composeItem, nil];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.autoresizesSubviews = YES;
//    UIToolbar * tb = [[UIToolbar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 49.0f)];
//    tb.barStyle = UIBarStyleBlackTranslucent;
//    tb.frame = CGRectOffset(tb.frame, 0.0f, self.view.frame.size.height - tb.frame.size.height);
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 49.0f, 0.0f);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.navigationItem.title = @"Message";
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    MessageNavgationViewController * nav = (MessageNavgationViewController*)self.navigationController;
    nav.navToolBar.items = nil;
}



#pragma mark - UIToolBar Items Actions

- (void) composeMessage
{
    MessageComposer * composer = [[MessageComposer alloc]init];
    UINavigationController * ncComposer = [[UINavigationController alloc]initWithRootViewController:composer];
    [self.navigationController presentViewController:ncComposer animated:YES completion:^{
        ncComposer.navigationBar.barStyle = UIBarStyleBlackOpaque;
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
    return 20;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"MessageCell";
    MessageCell * messageCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (messageCell == nil)
        messageCell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    messageCell.senderLabel.text = @"Sender";
    messageCell.subjectLabel.text = @"Subject";
    messageCell.messageLabel.text = @"Dear Customer,Axxess is social!Follow us on Twitter, Facebook, LinkedIn, and Instagram to network with thousands of Home Health professionals, receive updates on what Axxess is up to, as well as obtain the latest industry information and trends to keep you running your agency efficiently and successfully.";
    /* manage Categories later */
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateStyle:NSDateFormatterShortStyle];
   
    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow: -(60.0f * 60.0f * 24.0f)];
    NSDate * previousDay = [NSDate dateWithTimeIntervalSinceNow: -(10 * 60.0f * 60.0f * 24.0f)];

    // For temp
    if (indexPath.row % 3 == 1)messageCell.dateLabel.text = [NSString messageCellDateStringFromDate:yesterday];
    else if (indexPath.row % 3 == 0)messageCell.dateLabel.text = [NSString messageCellDateStringFromDate:[NSDate date]];
    else messageCell.dateLabel.text = [NSString messageCellDateStringFromDate:previousDay];
    
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
