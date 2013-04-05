//
//  PasscodeSettingsViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 4/5/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "PasscodeSettingsViewController.h"
#import "KKKeychain.h"
#import "KKPasscodeViewController.h"
#import "KKPasscodeLock.h"

#import "NavigationControllerWithoutRotation.h"
@interface PasscodeSettingsViewController ()

@end

@implementation PasscodeSettingsViewController

#pragma mark -
#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
	if (indexPath.section == 0 && indexPath.row == 0) {
		KKPasscodeViewController* vc = [[KKPasscodeViewController alloc] initWithNibName:nil
                                                                                  bundle:nil];
		vc.delegate = self;
		
		if (_passcodeLockOn) {
			vc.mode = KKPasscodeModeDisabled;
		} else {
			vc.mode = KKPasscodeModeSet;
		}
		
		NavigationControllerWithoutRotation *nav = [[NavigationControllerWithoutRotation alloc] initWithRootViewController:vc];
        
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
			nav.modalPresentationStyle = UIModalPresentationFormSheet;
			nav.navigationBar.barStyle = UIBarStyleBlack;
			nav.navigationBar.opaque = NO;
		} else {
			nav.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
			nav.navigationBar.translucent = self.navigationController.navigationBar.translucent;
			nav.navigationBar.opaque = self.navigationController.navigationBar.opaque;
			nav.navigationBar.barStyle = self.navigationController.navigationBar.barStyle;
		}
		
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
        [self.navigationController presentModalViewController:nav animated:YES];
#else
        [self.navigationController presentViewController:nav animated:YES completion:nil];
#endif
		
	} else if (indexPath.section == 0 && indexPath.row == 1 && _passcodeLockOn) {
		KKPasscodeViewController *vc = [[KKPasscodeViewController alloc] initWithNibName:nil bundle:nil];
		vc.delegate = self;
		
		vc.mode = KKPasscodeModeChange;
		
		NavigationControllerWithoutRotation *nav = [[NavigationControllerWithoutRotation alloc] initWithRootViewController:vc];
		
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
			nav.modalPresentationStyle = UIModalPresentationFormSheet;
			nav.navigationBar.barStyle = UIBarStyleBlack;
			nav.navigationBar.opaque = NO;
		} else {
			nav.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
			nav.navigationBar.translucent = self.navigationController.navigationBar.translucent;
			nav.navigationBar.opaque = self.navigationController.navigationBar.opaque;
			nav.navigationBar.barStyle = self.navigationController.navigationBar.barStyle;
		}
		
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
        [self.navigationController presentModalViewController:nav animated:YES];
#else
        [self.navigationController presentViewController:nav animated:YES completion:nil];
#endif
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

- (void)didSettingsChanged:(KKPasscodeViewController*)viewController
{
	_passcodeLockOn = [[KKKeychain getStringForKey:@"passcode_on"] isEqualToString:@"YES"];
	_eraseDataOn = [[KKKeychain getStringForKey:@"erase_data_on"] isEqualToString:@"YES"];
	_eraseDataSwitch.on = _eraseDataOn;
    
	[self.tableView reloadData];
	
	if ([_delegate respondsToSelector:@selector(didSettingsChanged:)]) {
		[_delegate performSelector:@selector(didSettingsChanged:) withObject:self];
	}
	
}
@end
