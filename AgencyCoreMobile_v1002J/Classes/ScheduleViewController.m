//
//  ScheduleViewController.m
//  AgencyCoreMobile_v1002
//
//  Created by Iggy Mwangi on 3/15/13.
//
//

#import "ScheduleViewController.h"
#import "CalendarMonthViewController.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - Programmatically

- (void) gotoMontlyView
{
    CalendarMonthViewController * cvc = [[CalendarMonthViewController alloc]initWithSunday:YES];
    UINavigationController * cnv = [[UINavigationController alloc]initWithRootViewController:cvc];
    cnv.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController presentViewController:cnv animated:YES completion:^{
        
    }];
}

#pragma mark -

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * calItem = [[UIBarButtonItem alloc]initWithTitle:@"Cal" style:UIBarButtonItemStyleBordered target:self action:@selector(gotoMontlyView)];
    if (iPHONE_UI) self.navigationItem.rightBarButtonItem = calItem;
    self.navigationItem.title = @"My Schedule Tasks";
}

#pragma mark - UITableView Datasource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"SampleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
        
    return cell;
}


#pragma mark - UITableView Delegate

@end
