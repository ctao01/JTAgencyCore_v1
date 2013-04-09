//
//  CommentsViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/8/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "CommentsViewController.h"
#import "VisitHeaderView.h"
#import "TextViewCell.h"
#import "VisitTextView.h"

@interface CommentsViewController ()
{
    BOOL moved;
    UIButton * savedButton;
}

@property (nonatomic , strong) VisitHeaderView * visitView;
@property (nonatomic , strong) VisitTextView * commentView;

@end

@implementation CommentsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.tableView.backgroundView = nil;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Visit";
    CGFloat screenWidth;
    if (UserInterface_Portrait) screenWidth = self.view.frame.size.width;
    else if (UserInterface_Landscape) screenWidth = self.view.frame.size.height;
    else screenWidth = 0.0f;
    
    self.visitView = [[VisitHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, screenWidth, 90.0f)];   
    [self.view addSubview:self.visitView];
    
    CGFloat textviewHight;
    if (iPAD_UI) textviewHight = 400.0f;
    else if (iPHONE_UI && UserInterface_Landscape) textviewHight = 140.0f;
    else textviewHight = 200.0f;
    
    self.commentView = [[VisitTextView alloc]initWithFrame:CGRectMake(0.0f, self.visitView.frame.size.height, screenWidth, textviewHight)];
    self.commentView.commentsField.delegate = self;
    [self.view addSubview:self.commentView];
    
    CGFloat horizontalOffset;
    if (iPHONE_UI) horizontalOffset = 12;
    else if (iPAD_UI) horizontalOffset = 47.0f;
    else horizontalOffset = 0.0f;
    
    CGFloat verticalOffset;
    if (iPHONE_UI && UserInterface_Landscape) verticalOffset = 10.0f;
    else verticalOffset = 20.0f;
    
    savedButton = [UIButton redStyleButtonWithTitle:@"Save"];
    [savedButton setFrame:CGRectMake(0.0f, 0.0f, screenWidth - horizontalOffset *2 , 44.0f)];
    [savedButton setCenter:CGPointMake(screenWidth / 2.0f, self.commentView.frame.origin.y + self.commentView.frame.size.height + verticalOffset)];
    [self.view addSubview:savedButton];

}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Keyboard Method

- (void) animatedViewUp:(BOOL)UP
{
    moved = UP;
    const int movementDistance = 90.0f;
    
    int movement = (UP ? -movementDistance : movementDistance);
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.view.frame = CGRectOffset(self.view.frame, 0.0f, movement);
                     }
                     completion:^(BOOL successful){}];
    
}

#pragma mark - NSNotificationCenter

- (void) receiveTestNotification:(NSNotification*) notification
{
    if ([[notification name]isEqualToString:@"TestNotification" ])
    {
        CGFloat textviewHight;
        if (iPAD_UI && UserInterface_Portrait) textviewHight = 400.0f;
        else if (iPHONE_UI && UserInterface_Landscape) textviewHight = 140.0f;
        else textviewHight = 200.0f;
        
        [self.visitView setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 90.0f)];
        [self.commentView setFrame:CGRectMake(0.0f, self.visitView.frame.size.height, self.view.frame.size.width, textviewHight)];
        
        CGFloat horizontalOffset;
        if (iPHONE_UI) horizontalOffset = 12;
        else if (iPAD_UI) horizontalOffset = 47.0f;
        else horizontalOffset = 0.0f;
        
        CGFloat verticalOffset;
        if (iPHONE_UI && UserInterface_Landscape) verticalOffset = 10.0f;
        else verticalOffset = 20.0f;
        NSLog(@"%f",self.commentView.frame.size.height);
        [savedButton setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width - horizontalOffset *2 , 44.0f)];
        [savedButton setCenter:CGPointMake(self.view.frame.size.width / 2.0f, self.commentView.frame.origin.y + self.commentView.frame.size.height + verticalOffset)];
    }
}

#pragma mark- UITextViewDelegate 

- (void) textViewDidBeginEditing:(UITextView *)textView
{
    if (iPHONE_UI)[self animatedViewUp:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if (iPHONE_UI)[self animatedViewUp:NO];
        return NO;
    }
    
    return YES;
}



#pragma mark - Table view data source
/*
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
    static NSString * CellIdentifier1 = @"cell_style_TextView";
    static NSString * CellIdentifier2 = @"cell_Style_Button";
    UITableViewCell * cell = nil;
    if (indexPath.section == 0)
    {
        TextViewCell * textViewCell;
        
        static NSString * iPhone_portrait_cell = @"iPhone_Portrait_Cell";
        static NSString * iPhone_landscape_cell = @"iPhone_Landscape_Cell";
        static NSString * iPad_portrait_cell = @"iPad_Portrait_Cell";
        static NSString * iPad_landscape_cell = @"iPad_Landscape_Cell";
        if (iPHONE_UI && UserInterface_Portrait)
            textViewCell = [self.tableView dequeueReusableCellWithIdentifier:iPhone_portrait_cell];
        else if (iPHONE_UI && UserInterface_Landscape)
            textViewCell = [self.tableView dequeueReusableCellWithIdentifier:iPhone_landscape_cell];
        else if (iPAD_UI && UserInterface_Portrait)
            textViewCell = [self.tableView dequeueReusableCellWithIdentifier:iPad_portrait_cell];
        else if (iPAD_UI && UserInterface_Landscape)
            textViewCell = [self.tableView dequeueReusableCellWithIdentifier:iPad_landscape_cell];

        if (textViewCell == nil)
        {
            if (iPHONE_UI && UserInterface_Portrait)
                textViewCell = [[TextViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPhone_portrait_cell];
            else if (iPHONE_UI && UserInterface_Landscape)
                textViewCell = [[TextViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPhone_landscape_cell];
            else if (iPAD_UI && UserInterface_Portrait)
                textViewCell = [[TextViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPad_portrait_cell];
            else if (iPAD_UI && UserInterface_Landscape)
                textViewCell = [[TextViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPad_landscape_cell];
            else
                textViewCell = nil;
        }
        textViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = (UITableViewCell*) textViewCell;
    }
    else
    {
        UITableViewCell * buttonCell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (buttonCell == nil)
            buttonCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        cell = buttonCell;
    }
    
    return cell;
}
#pragma mark - Table view delegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.section == 1) return 42.0f;
     else return 240.0f;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.section == 1)
   {
       cell.backgroundView = [[UIImageView alloc]init];
       ((UIImageView*) cell.backgroundView).image = nil;
       UIImage * backgroundImage = [[UIImage imageNamed:@"btn_Red"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 0.0f, 6.0f)];
       ((UIImageView*) cell.backgroundView).image = backgroundImage;
   }
}
*/
@end
