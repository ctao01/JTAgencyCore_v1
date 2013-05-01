//
//  NavigationTopViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 2/13/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "NavigationTopViewController.h"

@implementation NavigationTopViewController

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  

  if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
    self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
  }
  
  [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIFont * titleFont;
    if (iPHONE_UI) titleFont = ACFontDefaultBold18;
    else titleFont = ACFontDefaultBold20;
    
    [[UINavigationBar appearance]setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], UITextAttributeTextColor,
      titleFont, UITextAttributeFont ,nil]];
}

@end
