//
//  PatientProfileViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 5/1/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "PatientProfileViewController.h"
#import "PatientProfileHeaderView.h"
#import "NavigationToolBarController.h"

#import "MessageComposer.h"
#import "PhysicianViewController.h"

@interface PatientProfileViewController () < UIActionSheetDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate >
@property (nonatomic , strong) PatientProfileHeaderView * profilview;
@property (nonatomic) ACPatientStatus patientStatus;

@end

@implementation PatientProfileViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect rectProfile;
    if (iPAD_UI) rectProfile = CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 200.0f);
    else if (iPHONE_UI) rectProfile = CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 170.0f);
    self.profilview = [[PatientProfileHeaderView alloc]initWithFrame:UIEdgeInsetsInsetRect(rectProfile, UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f))];
    self.profilview.backgroundColor = [UIColor clearColor];
    self.profilview.displayController = self;
    self.tableView.tableHeaderView = self.profilview;
    self.tableView.backgroundColor = nil;
    
    self.navigationItem.title = @"Patient";
    self.patientStatus = 0;
//    UIBarButtonItem * statusItem = [[UIBarButtonItem alloc]initWithTitle:@"Active" style:UIBarButtonItemStyleBordered target:self action:@selector(changeStatus)];
//    self.navigationItem.rightBarButtonItem = statusItem;
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.navigationController isMemberOfClass:[NavigationToolBarController class]])
    {
        NavigationToolBarController * nav = (NavigationToolBarController*)self.navigationController;
        [nav.navToolBar setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

//- (void) changeStatus
//{
//    
//}

- (void) unselectCurrentIndexPath
{
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}


- (void) changePatientPhoto
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    imagePickerController.showsCameraControls = YES;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"didFinishPickingMediaWithInfo");
    
    UIImage * originImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self.profilview.patientButton setBackgroundImage:originImage forState:UIControlStateNormal];
    [self.profilview layoutIfNeeded];
    
    if ([self respondsToSelector:@selector(dismissModalViewControllerAnimated:)])
        [self dismissModalViewControllerAnimated:YES];
    else [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) return 1;
    else if (section == 1) return 2;
    else if (section == 2) return 1;
    
    else if (section == 3) return 1;
    else if (section == 4) return 1;
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    if (indexPath.section == 0)
    {
        if (self.patientStatus == 0) cell.textLabel.text = @"Active";
        else if (self.patientStatus == 1) cell.textLabel.text = @"Discharge";
        else if (self.patientStatus == 2) cell.textLabel.text = @"Pending";
        else if (self.patientStatus == 3) cell.textLabel.text = @"Non-Admit";
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }
    
    else if (indexPath.section == 1)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
            

        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"Phone";
            cell.detailTextLabel.text = @"(233)445-7051";
        }
        else if (indexPath.row == 1)
            cell.textLabel.text = @"Location";
        cell.textLabel.textColor = ACColorSystemBlue;
    }
    else if (indexPath.section == 2)
    {
        cell.textLabel.text = @"Message";
        cell.textLabel.textColor = ACColorSystemBlue;
    }
    
    if (iPHONE_UI)
    {
        cell.textLabel.font = ACFontDefaultBold14;
        cell.detailTextLabel.font = ACFontDefaultBold14;
    }
    else cell.textLabel.font = ACFontDefaultBold16;
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;

    return cell;
}

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        cell.backgroundView = [[UIImageView alloc]init];
        ((UIImageView*) cell.backgroundView).image = nil;
        cell.selectedBackgroundView = nil;
        // Add If-Else function here
        cell.textLabel.textColor = [UIColor whiteColor];

        UIImage * backgroundImage ;
        if (self.patientStatus == 0)
            backgroundImage = [[UIImage imageNamed:@"btn_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 2.0f, 6.0f)];
        else if (self.patientStatus == 1)
            backgroundImage = [[UIImage imageNamed:@"btn_Red"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 2.0f, 6.0f)];
      else if (self.patientStatus == 2)
            backgroundImage = [[UIImage imageNamed:@"btn_blue"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 2.0f, 6.0f)];

        else if (self.patientStatus == 3)
        {
            backgroundImage = [[UIImage imageNamed:@"btn_Gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 6.0f, 2.0f, 6.0f)];
            cell.textLabel.textColor = [UIColor blackColor];
        }
        ((UIImageView*) cell.backgroundView).image = backgroundImage;

    }
    UIView * view = [[UIView alloc]initWithFrame:cell.backgroundView.frame];
    view.backgroundColor = ACColorGray80Alpha;
    cell.selectedBackgroundView = view;
}


- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return 30;
    else return 44;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1)   return @"Contact";
    else if (section == 3) return @"Physician";
    else if (section == 4) return @"Episodes";
    else return @"";
}

//- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//}

// Activate Copy Functionality

- (void)tableView:(UITableView*)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath*)indexPath withSender:(id)sender
{
    if (action == @selector(copy:))
    {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        NSLog(@"copy%@",cell.detailTextLabel.text);
    }
}

-(BOOL)tableView:(UITableView*)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath*)indexPath withSender:(id)sender
{
    return (action == @selector(copy:));
}

-(BOOL)tableView:(UITableView*)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 1) return YES;
    else return NO;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UIActionSheet * as = [[UIActionSheet alloc]initWithTitle:@"Change Status" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Active",@"Discharge",@"Pedning",@"Non-Admit", nil];
        [as showInView:self.view];
    }
    
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 1)
        {
            UIApplication *app = [UIApplication sharedApplication];
            if (DEVICE_VERSION < 6.0f)[app openURL:[NSURL URLWithString:@"http://maps.google.com/maps?q=London"]];
            else
            {
                Class itemClass = [MKMapItem class];
                if (itemClass && [itemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]) {
                    [[MKMapItem mapItemForCurrentLocation] openInMapsWithLaunchOptions:nil];
                }
            }
        }
    }
    else if (indexPath.section == 2)
    {
        MessageComposer * composer = [[MessageComposer alloc]init];
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:composer];
        [self presentViewController:nc animated:YES completion:^{
            [[NSNotificationCenter defaultCenter] removeObserver:self.navigationController];
            composer.navigationItem.title = @"New Message";
        }];
    }
    else if (indexPath.section == 3)
    {
        PhysicianViewController * vc = [[PhysicianViewController alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:vc animated:YES];
    }
//   
    [self performSelector:@selector(unselectCurrentIndexPath) withObject:nil afterDelay:1.2f];
}


#pragma mark - UIActionSheet Method Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex)   return;
    else
        self.patientStatus = buttonIndex;
    [self.tableView reloadData];
}
@end
