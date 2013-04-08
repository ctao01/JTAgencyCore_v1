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
#import "TextView.h"

@interface CommentsViewController ()
@property (nonatomic , strong) VisitHeaderView * visitView;
@property (nonatomic , strong) TextView * commentView;

@end

@implementation CommentsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.visitView = [[VisitHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 90.0f)];
    [self.view addSubview:self.visitView];
//    self.tableView.tableHeaderView = self.visitView;
    
    self.commentView = [[TextView alloc]initWithFrame:CGRectMake(0.0f, self.visitView.frame.size.height, self.view.frame.size.width, 150.0f)];
    [self.view addSubview:self.commentView];
    
    self.navigationItem.title = @"Visit";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
