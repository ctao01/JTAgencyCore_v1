//
//  MenuViewController.m
//
//
//
//
#import "MenuViewController.h"

@interface MenuViewController()
@property (nonatomic, strong) NSArray *menuItems;
@end

@implementation MenuViewController
@synthesize menuItems;

- (void)awakeFromNib
{
    self.menuItems = [NSArray arrayWithObjects:@"Home", @"Account", @"Messages", @"Schedule", @"Notes", @"Navigation", nil];
}

- (void)viewDidLoad
{
    self.tableView.backgroundColor = [UIColor blackColor];
    
    [super viewDidLoad];
    if (iPHONE_UI)
        [self.slidingViewController setAnchorRightRevealAmount:280.0f];
    else if (iPAD_UI)
        [self.slidingViewController setAnchorRightRevealAmount:self.view.frame.size.height - self.view.frame.size.height/2];

    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    self.tableView.backgroundColor = [UIColor colorWithRed:10.0f/255.0f green:10.0f/255.0f blue:10.0f/255.0f alpha:1.0f];
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 280.0f, 300.0f)];
    footerView.backgroundColor =[UIColor colorWithRed:10.0f/255.0f green:10.0f/255.0f blue:10.0f/255.0f alpha:1.0f];
    self.tableView.tableFooterView = footerView;
    
    UIImage * logoImg;
    if (iPHONE_UI)
        logoImg = [UIImage imageNamed:@"axxess_logo_white_iphone"];
    else if (iPAD_UI)
        logoImg = [UIImage imageNamed:@"axxess_logo_white_ipad"];

    UIImageView * logoView= [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, logoImg.size.width, logoImg.size.height)];
    logoView.image = logoImg;
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 60.0f)];
    [headerView addSubview:logoView];
    
    self.tableView.tableHeaderView = headerView;
    
    self.tableView.separatorColor = [UIColor lightGrayColor];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
#pragma mark - NSNotification

- (void) receiveTestNotification:(NSNotification*)notice
{
    if ([[notice name]isEqualToString:@"TestNotification" ])
    {
    }
}


#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
  return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"MenuItemCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = ACFontDefault16;
    if (indexPath.row == 0)
    {
        cell.imageView.image = [UIImage imageNamed:@"menu_home"];
        cell.textLabel.text = @"Home";
    }
    else if (indexPath.row == 1)
    {
            cell.imageView.image = [UIImage imageNamed:@"menu_account"];
            cell.textLabel.text = @"My Account";
    }
    else if (indexPath.row == 2)
    {
            cell.imageView.image = [UIImage imageNamed:@"menu_messages"];
            cell.textLabel.text = @"My Messages";
    }
    else if (indexPath.row == 3)
    {
            cell.imageView.image = [UIImage imageNamed:@"menu_schedule"];
            cell.textLabel.text = @"My Schedule";
    }
    else if (indexPath.row == 4)
    {
            cell.imageView.image = [UIImage imageNamed:@"menu_notes"];
            cell.textLabel.text = @"My Notes";
    }
    else
    {
            cell.imageView.image = [UIImage imageNamed:@"menu_more"];
            cell.textLabel.text = @"More";
    }
  return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [self.menuItems objectAtIndex:indexPath.row];
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
  
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopViewController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
  }];
}

@end
