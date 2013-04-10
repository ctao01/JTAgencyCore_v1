//
//  ContactViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 3/22/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "UserListViewController.h"
#import "MessageComposer.h"
#import "NewTaskViewController.h"

@interface UserListViewController ()
@property (nonatomic , strong) NSArray * contacts;
@property (nonatomic , strong) UISearchDisplayController * searchDisplay;
@property (nonatomic , strong) NSArray * searchedContacts;

@end

@implementation UserListViewController

- (id)initWithStyle:(UITableViewStyle)style 
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        UISearchBar * sb = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, 44.0f)];
        sb.barStyle = UIBarStyleBlackTranslucent;
        sb.showsSearchResultsButton = YES;
        
        self.tableView.tableHeaderView = sb;
        self.searchDisplay = [[UISearchDisplayController alloc]initWithSearchBar:sb contentsController:self];
        self.searchDisplay.searchResultsDataSource = self;
        self.searchDisplay.searchResultsDelegate = self;
        self.searchDisplay.delegate = self;
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contacts = [NSArray arrayWithObjects:
                     @"Samuel Prescott",
                     @"Grace Mcburney",
                     @"Rosemary Sells",
                     @"Janet Canady",
                     @"Gregory Leech",
                     @"Geneva Mcguinness",
                     @"Billy Shin",
                     @"Douglass Fostlick",
                     @"Roberta Pedersen",
                     @"Earl Rashid",
                     @"Matthew Hooks",
                     @"Regina Toombs",
                     @"Victor Sisneros",
                     @"Beverly Covington",
                     @"Steve Crews",
                     @"Carlos Trejo",
                     @"Victoria Delgadillo",
                     @"Leah Greenberg",
                     @"Deborah Depew",
                     @"Jeffery Khoury",
                     @"Kathryn Worsham",
                     @"Olivia Brownell",
                     @"Gary Pritchard",
                     @"Susan Cervantes",
                     @"Olvera Nipplehead",
                     @"Debra Graves",
                     @"Albert Deltoro",
                     @"Carole Flatt",
                     @"Philip Vo",
                     @"Phillip Wagstaff",
                     @"Xiao Jacquay",
                     @"Cleotilde Vondrak",
                     @"Carter Redepenning",
                     @"Kaycee Wintersmith",
                     @"Collin Tick",
                     @"Peg Yore",
                     @"Cruz Buziak",
                     @"Ardath Osle",
                     @"Frederic Manusyants",
                     @"Collin Politowski",
                     @"Hunter Wollyung",
                     @"Cruz Gurke",
                     @"Sulema Sholette",
                     @"Denver Goetter",
                     @"Chantay Phothirath",
                     @"Arlean Must",
                     @"Carlo Henggeler",
                     @"Daughrity Maichle",
                     @"Zada Wintermantel",
                     @"Denver Kubu",
                     @"Carlo Guzma",
                     @"Emory Swires",
                     @"Kirby Manas",
                     @"Tobie Spirito",
                     @"Lane Defaber",
                     @"Sparkle Mousa",
                     @"Chantay Palczynski",
                     @"Denver Perfater",
                     @"Tom Irving",
                     nil];
    if ([[self.navigationController.viewControllers objectAtIndex:0] isEqual:self])
    {
        UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelSelectingContact)];
        self.navigationItem.leftBarButtonItem = cancelItem;
        self.navigationItem.title = @"Recipient List";
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -

- (void) cancelSelectingContact
{
   if ([[self.navigationController.viewControllers objectAtIndex:0] isEqual:self])
       [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
    else
        [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) filterContentForSearchText:(NSString*)searchText andScope:(NSString*)scope
{
    NSPredicate * result = [NSPredicate predicateWithFormat:@"SELF contains[cd]%@",searchText];
    self.searchedContacts = [self.contacts filteredArrayUsingPredicate:result];
}

#pragma mark - 

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([tableView isEqual:self.searchDisplay.searchResultsTableView])
        return [self.searchedContacts count];
    else return [self.contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    if ([tableView isEqual:self.searchDisplay.searchResultsTableView])
        cell.textLabel.text = [self.searchedContacts objectAtIndex:indexPath.row];
    else cell.textLabel.text = [self.contacts objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.navigationController.viewControllers objectAtIndex:0] isEqual:self])
    {
        MessageComposer * composer = (MessageComposer*)self.vcParent;
        composer.selectedContact = [self.contacts objectAtIndex:indexPath.row];
        [self.navigationController dismissViewControllerAnimated:YES completion:^{}];

    }
    else
    {
        NewTaskViewController * vc = [self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
        if ([self.navigationItem.title isEqualToString:@"Patient List"])    vc.selectedPatient = [self.contacts objectAtIndex:indexPath.row];
        else if ([self.navigationItem.title isEqualToString:@"User List"])  vc.selectedUser = [self.contacts objectAtIndex:indexPath.row];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
