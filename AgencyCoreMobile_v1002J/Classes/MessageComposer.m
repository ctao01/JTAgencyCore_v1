//
//  MessageComposer.m
//  AgencyCoreMobile_v1002
//
//  Created by Joy Tao on 3/20/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "MessageComposer.h"
#import "MessageSubjectField.h"
#import "MessageNavgationViewController.h"
#import "ContactViewController.h"
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

#pragma mark -


- (void)resizeViews {
    int tabBarOffset = self.tabBarController == nil ?  0.0f : self.tabBarController.tabBar.frame.size.height;
	[tokenFieldView setFrame:((CGRect){tokenFieldView.frame.origin, {self.view.bounds.size.width, self.view.bounds.size.height + tabBarOffset - keyboardHeight}})];
    NSLog(@"%@",NSStringFromCGRect(tokenFieldView.contentView.bounds));

    CGRect contentBounds = tokenFieldView.contentView.bounds;
    [subjectField setFrame:CGRectMake(contentBounds.origin.x, contentBounds.origin.y, contentBounds.size.width, subjectField.frame.size.height)];
    NSLog(@"%@",NSStringFromCGRect(subjectField.frame));
	[messageView setFrame:CGRectMake(contentBounds.origin.x, subjectField.frame.origin.y + subjectField.frame.size.height , contentBounds.size.width, contentBounds.size.height - subjectField.frame.size.height)];
//    [messageView setFrame:tokenFieldView.contentView.bounds];
    NSLog(@"%@",NSStringFromCGRect(messageView.frame));

}

#pragma mark -

- (id)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];
    [super viewDidLoad];

    self.navigationItem.title = @"New Message";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.view.backgroundColor = [UIColor whiteColor];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    MessageNavgationViewController * nav = (MessageNavgationViewController*)self.navigationController;

    [self.view removeGestureRecognizer:nav.slidingViewController.panGesture];
    
	// You can call this on either the view on the field.
	// They both do the same thing.
//	[tokenFieldView becomeFirstResponder];
    
    UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelMessageComposer)];
    UIBarButtonItem * sendItem = [[UIBarButtonItem alloc]initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(sendMessage)];
    sendItem.enabled = NO;
    self.navigationItem.leftBarButtonItem = cancelItem;
    self.navigationItem.rightBarButtonItem = sendItem;

    CGRect bounds = self.view.frame;
    if (UserInterface_Portrait)
        tokenFieldView = [[TITokenFieldView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y-20.0f, bounds.size.width, bounds.size.height)];
    else if (UserInterface_Landscape)
        tokenFieldView = [[TITokenFieldView alloc] initWithFrame:CGRectMake(bounds.origin.x -20.0f, bounds.origin.y, bounds.size.height, bounds.size.width)];
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
    [tokenFieldView.contentView addSubview:subjectField];
    
    messageView = [[UITextView alloc] initWithFrame:CGRectMake(contentBounds.origin.x, 44, contentBounds.size.width, contentBounds.size.height - 44)];
    [messageView setAutoresizingMask:UIViewAutoresizingNone];
    [messageView setScrollEnabled:NO];
    [messageView setDelegate:self];
    [messageView setFont:[UIFont systemFontOfSize:15]];
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
        NSLog(@"TestNotification:%@",NSStringFromCGRect(self.view.frame));
        [tokenFieldView setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width,self.view.frame.size.height)];
        CGRect contentBounds = tokenFieldView.contentView.bounds;
        [subjectField setFrame:CGRectMake(contentBounds.origin.x, contentBounds.origin.y, contentBounds.size.width, 44)];
        [messageView setFrame:CGRectMake(contentBounds.origin.x, 44, contentBounds.size.width, contentBounds.size.height - 44)];

//        if (UserInterface_Landscape)
//        else if (UserInterface_Portrait)
//            [tokenFieldView setFrame:CGRectMake(0.0f, 0.0f, tokenFieldView.frame.size.width  , tokenFieldView.frame.size.height)];

    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
	
	CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	keyboardHeight = keyboardRect.size.height > keyboardRect.size.width ? keyboardRect.size.width : keyboardRect.size.height;
	[self resizeViews];
}

- (void)keyboardWillHide:(NSNotification *)notification {
	keyboardHeight = 0;
	[self resizeViews];
}

#pragma mark - 

- (void) cancelMessageComposer
{
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void) showContactsPicker
{
    ContactViewController * vc = [[ContactViewController alloc]initWithStyle:UITableViewStylePlain];
    
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self.navigationController presentViewController:nc animated:YES completion:^{
        nc.navigationBar.barStyle = UIBarStyleBlackOpaque;
        vc.navigationItem.title = @"Contacts";
        vc.vcParent = self;
        
        self.selectedContact = nil;
    }];
}


#pragma mark - TITokenFieldDelegate

- (BOOL)tokenField:(TITokenField *)tokenField willRemoveToken:(TIToken *)token {
	
	if ([token.title isEqualToString:@"Tom Irving"]){
		return NO;
	}
    
	NSLog(@"%@",token.title);
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

#pragma mark - UITextField Delegate


#pragma mark - UITextView Delegate

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
    [textView resignFirstResponder];
}

@end
