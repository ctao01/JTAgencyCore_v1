//
//  MessageComposer.m
//  AgencyCoreMobile_v1002
//
//  Created by Joy Tao on 3/20/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "MessageComposer.h"
#import "MessageSubjectField.h"
#import "NavigationToolBarController.h"
#import "UserListViewController.h"
#import "NavigationControllerWithoutRotation.h"

@interface MessageComposer ()
{
    TITokenFieldView * tokenFieldView;
    MessageSubjectField * subjectField;
	UITextView * messageView;
	
	CGFloat keyboardHeight;
}
- (void)resizeViews;

@end

@implementation MessageComposer
@synthesize messageObject = _messageObject;
#pragma mark -


- (void)resizeViews {
    int tabBarOffset = self.tabBarController == nil ?  0.0f : self.tabBarController.tabBar.frame.size.height;
	[tokenFieldView setFrame:((CGRect){tokenFieldView.frame.origin, {self.view.bounds.size.width, self.view.bounds.size.height + tabBarOffset - keyboardHeight}})];

    CGRect contentBounds = tokenFieldView.contentView.bounds;
    [subjectField setFrame:CGRectMake(contentBounds.origin.x, contentBounds.origin.y, contentBounds.size.width, subjectField.frame.size.height)];
	[messageView setFrame:CGRectMake(contentBounds.origin.x, subjectField.frame.origin.y + subjectField.frame.size.height , contentBounds.size.width, contentBounds.size.height - subjectField.frame.size.height)];
//    [messageView setFrame:tokenFieldView.contentView.bounds];
}

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    NavigationToolBarController * nav = (NavigationToolBarController*)self.navigationController;

    [self.view removeGestureRecognizer:nav.slidingViewController.panGesture];
    
    UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelMessageComposer)];
    UIBarButtonItem * sendItem = [[UIBarButtonItem alloc]initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(sendMessage)];
    sendItem.enabled = NO;
    self.navigationItem.leftBarButtonItem = cancelItem;
    self.navigationItem.rightBarButtonItem = sendItem;

    CGRect bounds = self.view.frame;
    if (UserInterface_Portrait)
        tokenFieldView = [[TITokenFieldView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y-20.0f, bounds.size.width, bounds.size.height)];
    else if (UserInterface_Landscape)
        tokenFieldView = [[TITokenFieldView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.width)];
    //	[tokenFieldView setSourceArray:[Names listOfNames]];
    [self.view addSubview:tokenFieldView];
    
    [tokenFieldView.tokenField setDelegate:self];
    [tokenFieldView.tokenField addTarget:self action:@selector(tokenFieldFrameDidChange:) forControlEvents:TITokenFieldControlEventFrameDidChange];
    [tokenFieldView.tokenField setTokenizingCharacters:[NSCharacterSet characterSetWithCharactersInString:@",;."]]; // Default is a comma
    
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addButton addTarget:self action:@selector(showContactsPicker) forControlEvents:UIControlEventTouchUpInside];
    [tokenFieldView.tokenField setRightView:addButton];
    [tokenFieldView.tokenField addTarget:self action:@selector(tokenFieldChangedEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [tokenFieldView.tokenField addTarget:self action:@selector(tokenFieldChangedEditing:) forControlEvents:UIControlEventEditingDidEnd];
    
    CGRect contentBounds = tokenFieldView.contentView.bounds;
    subjectField = [[MessageSubjectField alloc]initWithFrame:CGRectMake(contentBounds.origin.x, contentBounds.origin.y, contentBounds.size.width, 44)];
    subjectField.delegate = self;
    if (iPHONE_UI)  subjectField.font = ACFontDefault14;
    else if (iPAD_UI)  subjectField.font = ACFontDefault16;
    [tokenFieldView.contentView addSubview:subjectField];
    
    messageView = [[UITextView alloc] initWithFrame:CGRectMake(contentBounds.origin.x, 44, contentBounds.size.width, contentBounds.size.height - 44)];
    [messageView setAutoresizingMask:UIViewAutoresizingNone];
    [messageView setScrollEnabled:NO];
    [messageView setDelegate:self];
//    [messageView setFont:[UIFont systemFontOfSize:15]];
    if (iPHONE_UI)  [messageView setFont:ACFontDefault14];
    else if (iPAD_UI)  [messageView setFont:ACFontDefault16];
    [messageView setText:@"Some message. The whole view resizes as you type, not just the text view."];
    [tokenFieldView.contentView addSubview:messageView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.selectedContact != nil)
    {
        [tokenFieldView.tokenField addTokenWithTitle:self.selectedContact];
        [tokenFieldView.tokenField layoutTokensAnimated:YES];
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINotification Method

- (void) receiveTestNotification:(NSNotification*)notification
{
    if ([[notification name]isEqualToString:@"TestNotification"])
    {
        [tokenFieldView setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width,self.view.frame.size.height)];
        CGRect contentBounds = tokenFieldView.contentView.bounds;
        [subjectField setFrame:CGRectMake(contentBounds.origin.x, contentBounds.origin.y, contentBounds.size.width, 44)];
        [messageView setFrame:CGRectMake(contentBounds.origin.x, 44, contentBounds.size.width, contentBounds.size.height - 44)];
        [tokenFieldView resignFirstResponder];
        [messageView resignFirstResponder];
        [subjectField resignFirstResponder];
       

    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
	
	CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	keyboardHeight = keyboardRect.size.height > keyboardRect.size.width ? keyboardRect.size.width : keyboardRect.size.height;
//    if (iPHONE_UI && UserInterface_Landscape) keyboardHeight = 60.0f;

    [self resizeViews];
}

- (void)keyboardWillHide:(NSNotification *)notification {
	keyboardHeight = 0;
	[self resizeViews];
}
#pragma mark- 

- (void) setMessageObject:(NSDictionary *)newObject
{
    if (_messageObject == newObject) return;
    _messageObject = newObject;
    
    NSArray * contacts = [_messageObject objectForKey:@"sender"];
    for (int count = 0 ; count < [contacts count]; count++)
    {
        [tokenFieldView.tokenField addTokenWithTitle:[contacts objectAtIndex:count]];
        [tokenFieldView.tokenField layoutTokensAnimated:YES];

    }
    messageView.text = [_messageObject objectForKey:@"content"];
}

#pragma mark - 

- (void) cancelMessageComposer
{
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void) showContactsPicker
{
    UserListViewController * vc = [[UserListViewController alloc]initWithStyle:UITableViewStylePlain];
    
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self.navigationController presentViewController:nc animated:YES completion:^{
        nc.navigationBar.barStyle = UIBarStyleBlackOpaque;
        vc.navigationItem.title = @"Contacts";
        vc.vcParent = self;
        
        self.selectedContact = nil;
    }];
}

#pragma mark - UITextField Delegate

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark - TITokenFieldDelegate

- (BOOL)tokenField:(TITokenField *)tokenField willRemoveToken:(TIToken *)token {
	
	if ([token.title isEqualToString:@"Tom Irving"]){
		return NO;
	}
	return YES;
}
- (void)tokenField:(TITokenField *)tokenField didRemoveToken:(TIToken *)token
{
    if ([tokenField.tokens count] > 0) self.navigationItem.rightBarButtonItem.enabled = YES;
    else self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)tokenFieldChangedEditing:(TITokenField *)tokenField {
	// There's some kind of annoying bug where UITextFieldViewModeWhile/UnlessEditing doesn't do anything.
	[tokenField setRightViewMode:(tokenField.editing ? UITextFieldViewModeAlways : UITextFieldViewModeNever)];
    if ([tokenField.tokens count] > 0) self.navigationItem.rightBarButtonItem.enabled = YES;
    else self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)tokenFieldFrameDidChange:(TITokenField *)tokenField {
	[self textViewDidChange:messageView];
}
#pragma mark - UITextView Delegate

//-(void)textViewDidBeginEditing:(UITextView *)textView;
//{
//    if (iPHONE_UI && UserInterface_Landscape)[self animatedViewUp:YES];
//}

- (void)textViewDidChange:(UITextView *)textView {
	
	CGFloat oldHeight = tokenFieldView.frame.size.height - tokenFieldView.tokenField.frame.size.height - subjectField.frame.size.height;
	CGFloat newHeight = textView.contentSize.height + textView.font.lineHeight;
	
	CGRect newTextFrame = textView.frame;
	newTextFrame.size = textView.contentSize;
	newTextFrame.size.height = newHeight;
	
	CGRect newFrame = tokenFieldView.contentView.frame;
	newFrame.size.height = newHeight + subjectField.frame.size.height;
	
	if (newHeight < oldHeight){
		newTextFrame.size.height = oldHeight;
		newFrame.size.height = oldHeight;
	}
    
	[tokenFieldView.contentView setFrame:newFrame];
	[textView setFrame:newTextFrame];
	[tokenFieldView updateContentSize];
}
- (void) textViewDidEndEditing:(UITextView *)textView
{
//    if (iPHONE_UI && UserInterface_Landscape) [self animatedViewUp:NO];

    [textView resignFirstResponder];
}

@end
