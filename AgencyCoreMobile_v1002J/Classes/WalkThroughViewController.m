//
//  WalkThroughViewController.m
//  AgencyCoreMobile_v1002J
//
//  Created by Joy Tao on 5/14/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "WalkThroughViewController.h"
#import "NavigationToolBarController.h"

@interface WalkThroughViewController ()

@end

@implementation WalkThroughViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        UIImageView * imageView;
        if (UserInterface_Landscape && iPAD_UI)
            imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"landscape_tour_home_ipad"]];
        else if (UserInterface_Portrait && iPAD_UI)
            imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"portrait_tour_home_ipad"]];

        [self.view addSubview:imageView];
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAndDismiss)];
    self.navigationItem.rightBarButtonItem = doneButton;
    if (iPHONE_UI) self.navigationItem.title = @"Coming Soon";
    else self.navigationItem.title = @"Tutoiral";
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NavigationToolBarController * nav = (NavigationToolBarController*)self.navigationController;
    
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem * nextItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:nil action:nil];
    nav.navToolBar.items = [NSArray arrayWithObjects:spaceItem,nextItem, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) doneAndDismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
