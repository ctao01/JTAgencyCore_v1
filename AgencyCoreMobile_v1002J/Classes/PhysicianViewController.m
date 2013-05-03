//
//  PhysicianViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 5/2/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "PhysicianViewController.h"
#import "BasicOneLineCell.h"
@interface PhysicianViewController ()
@property (nonatomic , strong) NSMutableArray * titles;
@end

@implementation PhysicianViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.titles = [[NSMutableArray alloc]initWithObjects:[NSArray arrayWithObjects:@"Name",@"NPI",@"PECOS", nil],
                   [NSArray arrayWithObjects:@"Phone",@"Address",@"Email", nil],
                   nil];
    self.navigationItem.title = @"Physician";
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) receiveTestNotification:(NSNotification*)notification
{
    if ([[notification name]isEqualToString:@"TestNotification" ])
        [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 3;
    else if (section == 1) return 3;
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * iPhone_portrait_cell = @"iPhone_Portrait_Cell";
    static NSString * iPhone_landscape_cell = @"iPhone_Landscape_Cell";
    static NSString * iPad_portrait_cell = @"iPad_Portrait_Cell";
    static NSString * iPad_landscape_cell = @"iPad_Landscape_Cell";
    
    //    BasicCustomCell * accountCell = [tableView dequeueReusableCellWithIdentifier:cell1ID];
    BasicOneLineCell * accountCell;
    
    if (iPHONE_UI && UserInterface_Portrait)
        accountCell = [tableView dequeueReusableCellWithIdentifier:iPhone_portrait_cell];
    else if (iPHONE_UI && UserInterface_Landscape)
        accountCell =  [tableView dequeueReusableCellWithIdentifier:iPhone_landscape_cell];
    else if (iPAD_UI && UserInterface_Portrait)
        accountCell = [tableView dequeueReusableCellWithIdentifier:iPad_portrait_cell];
    else if (iPAD_UI && UserInterface_Landscape)
        accountCell = [tableView dequeueReusableCellWithIdentifier:iPad_landscape_cell];
    
    if (accountCell == nil)
    {
        if (iPHONE_UI && UserInterface_Portrait)
            accountCell = [[BasicOneLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPhone_portrait_cell];
        else if (iPHONE_UI && UserInterface_Landscape)
            accountCell = [[BasicOneLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPhone_landscape_cell];
        else if (iPAD_UI && UserInterface_Portrait)
            accountCell = [[BasicOneLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPad_portrait_cell];
        else if (iPAD_UI && UserInterface_Landscape)
            accountCell = [[BasicOneLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iPad_landscape_cell];
        else
            accountCell = nil;
    }
    
    accountCell.titleLabel.text = [[self.titles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return accountCell;
}

@end
