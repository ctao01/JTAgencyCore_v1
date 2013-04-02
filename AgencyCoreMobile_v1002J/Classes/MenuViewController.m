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
  [super viewDidLoad];
  
    [self.slidingViewController setAnchorRightRevealAmount:self.view.frame.size.width - 40.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    self.tableView.backgroundColor = [UIColor colorWithRed:10.0f/255.0f green:10.0f/255.0f blue:10.0f/255.0f alpha:1.0f];
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 280.0f, 300.0f)];
    footerView.backgroundColor =[UIColor colorWithRed:10.0f/255.0f green:10.0f/255.0f blue:10.0f/255.0f alpha:1.0f];
    self.tableView.tableFooterView = footerView;
    
    UIImage * logoImg = [UIImage imageNamed:@"menu_axxess_logo"];
    UIImageView * headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, logoImg.size.width, logoImg.size.height)];
    headerView.image = logoImg;
    self.tableView.tableHeaderView = headerView;
    
    self.tableView.separatorColor = [UIColor lightGrayColor];
  
}
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
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0f];
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
  /*
  cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
  //cell.imageView.image = [UIImage imageNamed:@"menu_account1.png"];
    
    NSString *menuName =  @"";
    NSString *subtitleName =  @"";
    NSString *selectedName =  [self.menuItems objectAtIndex:indexPath.row] ;
    
    
    if([selectedName isEqualToString:@"logo"]) {
        //menuName = @""; subtitleName = @"";
        cell.imageView.image = [UIImage imageNamed:@"menu_axxess_logo.png"];
        cell.textLabel.text = @""
        
    };
    if([selectedName isEqualToString:@"Home"]) {
        //menuName = @"Home"; subtitleName = @"";
        cell.imageView.image = [UIImage imageNamed:@"menu_home.png"];

    };
    if([selectedName isEqualToString:@"Account"])
    {
        //menuName = @"My Account"; subtitleName = @"Log in, Log Out";
        cell.imageView.image = [UIImage imageNamed:@"menu_account.png"];
    };
    if([selectedName isEqualToString:@"Messages"])
    {
        //menuName = @"My Messages"; subtitleName = @"Send and Receive messages";
        cell.imageView.image = [UIImage imageNamed:@"menu_messages.png"];
    };
    if([selectedName isEqualToString:@"Schedule"])
    {
        //menuName = @"My Schedule"; subtitleName = @"View and Update Schedules and Tasks";
        cell.imageView.image = [UIImage imageNamed:@"menu_schedule.png"];
    };
    if([selectedName isEqualToString:@"Notes"])
    {
        //menuName = @"My Notes"; subtitleName = @"Visit Notes";
        cell.imageView.image = [UIImage imageNamed:@"menu_notes.png"];
    };
    if([selectedName isEqualToString:@"Navigation"])
    {
        //menuName = @"Navigation"; subtitleName = @"";
        cell.imageView.image = [UIImage imageNamed:@"menu_more.png"];
    };

    cell.textLabel.text = menuName;
    cell.detailTextLabel.text = subtitleName;
  */
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  //NSString *identifier = [NSString stringWithFormat:@"%@Top", [self.menuItems objectAtIndex:indexPath.row]];
    NSString *identifier = [self.menuItems objectAtIndex:indexPath.row];
    
//    NSString *selectedName =  [self.menuItems objectAtIndex:indexPath.row] ;
//    if([selectedName isEqualToString:@"Navigation"]) {
//      identifier = [NSString stringWithFormat:@"%@Top", [self.menuItems objectAtIndex:indexPath.row]];
//        
//    };
//    if([selectedName isEqualToString:@"logo"]) {
//        identifier = @"Home";
//        
//    };

    
  UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
  
  [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopViewController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
  }];
}

@end
