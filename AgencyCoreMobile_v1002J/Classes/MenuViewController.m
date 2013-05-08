//
//  MenuViewController.m
//
//
//
//
#import "MenuViewController.h"
#import "AppDelegate.h"

@interface MenuViewController()
//@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) NSDictionary * menuDictionary;
@end

@implementation MenuViewController
//@synthesize menuItems;

- (void)awakeFromNib
{
//    self.menuItems = [NSArray arrayWithObjects:@"Home", @"Account", @"Messages", @"Schedule", @"Notes",@"About", nil];
    NSArray * menuItems = [NSArray arrayWithObjects:@"Home", @"Account", @"Messages", @"Schedule", @"Notes",@"About", nil];
    NSArray * iconItems = [NSArray arrayWithObjects:[UIImage imageNamed:@"menu_home"],
                           [UIImage imageNamed:@"menu_account"],
                           [UIImage imageNamed:@"menu_messages"],
                           [UIImage imageNamed:@"menu_schedule"],
                           [UIImage imageNamed:@"menu_notes"],
                           [UIImage imageNamed:@"menu_more"],nil];
    
    self.menuDictionary = [NSDictionary dictionaryWithObjectsAndKeys:menuItems,@"Menu_Items",iconItems, @"Icon_Items", nil];
    
}

- (void)viewDidLoad
{
    self.tableView.backgroundColor = [UIColor blackColor];
    
    [super viewDidLoad];
    if (iPHONE_UI)
        [self.slidingViewController setAnchorRightRevealAmount:280.0f];
    else if (iPAD_UI)
        [self.slidingViewController setAnchorRightRevealAmount:width(Bounds_Screen)/2];

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
    
    self.tableView.separatorColor = ACColorMenuSeparatorGray;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
  if (sectionIndex == 0) return [[self.menuDictionary objectForKey:@"Menu_Items"] count];
  else return 1;
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
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    UILabel * badgeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 24.0f, 24.0f)];
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.layer.cornerRadius = 4.0f;
    badgeLabel.backgroundColor = ACColorRed;
    badgeLabel.textColor = [UIColor whiteColor];
    if (iPHONE_UI)
    {
        badgeLabel.font = ACFontDefaultBold14;
        cell.textLabel.font = ACFontDefaultBold16;
    }
    else
    {
        badgeLabel.font = ACFontDefaultBold16;
        cell.textLabel.font = ACFontDefaultBold18;
    }

    if (indexPath.section == 0)
    {
        cell.textLabel.text = [[self.menuDictionary objectForKey:@"Menu_Items"] objectAtIndex:indexPath.row];
        cell.imageView.image = [[self.menuDictionary objectForKey:@"Icon_Items"] objectAtIndex:indexPath.row];
        
        if (indexPath.row == 2)
        {
            badgeLabel.text = @"4";
            if (iPHONE_UI) badgeLabel.frame = CGRectOffset(badgeLabel.frame, width(Bounds_Screen) - 70.0f, 10.0f);
            else if (iPAD_UI) badgeLabel.frame = CGRectOffset(badgeLabel.frame, width(Bounds_Screen) / 2 - 30.0f, 10.0f);
            [cell.contentView addSubview:badgeLabel];

        }
        else if (indexPath.row == 3)
        {
            badgeLabel.text = @"11";
            if (iPHONE_UI) badgeLabel.frame = CGRectOffset(badgeLabel.frame, width(Bounds_Screen) - 70.0f, 10.0f);
            else if (iPAD_UI) badgeLabel.frame = CGRectOffset(badgeLabel.frame, width(Bounds_Screen) / 2 - 30.0f, 10.0f);
            [cell.contentView addSubview:badgeLabel];

        }
    }
    else
    {
        cell.textLabel.text = @"Log Out";
    }
    
//    if (indexPath.row == 0)
//    {
//        cell.imageView.image = [UIImage imageNamed:@"menu_home"];
//        cell.textLabel.text = @"Home";
//    }
//    else if (indexPath.row == 1)
//    {
//        cell.imageView.image = [UIImage imageNamed:@"menu_account"];
//        cell.textLabel.text = @"My Account";
//    
//    }
//    else if (indexPath.row == 2)
//    {
//        cell.imageView.image = [UIImage imageNamed:@"menu_messages"];
//        cell.textLabel.text = @"My Messages";
//        badgeLabel.text = @"4";
//        if (iPHONE_UI) badgeLabel.frame = CGRectOffset(badgeLabel.frame, width(Bounds_Screen) - 70.0f, 10.0f);
//        else if (iPAD_UI) badgeLabel.frame = CGRectOffset(badgeLabel.frame, width(Bounds_Screen) / 2 - 30.0f, 10.0f);
//        [cell.contentView addSubview:badgeLabel];
//    }
//    else if (indexPath.row == 3)
//    {
//        cell.imageView.image = [UIImage imageNamed:@"menu_schedule"];
//        cell.textLabel.text = @"My Schedule";
//        badgeLabel.text = @"11";
//        if (iPHONE_UI) badgeLabel.frame = CGRectOffset(badgeLabel.frame, width(Bounds_Screen) - 70.0f, 10.0f);
//        else if (iPAD_UI) badgeLabel.frame = CGRectOffset(badgeLabel.frame, width(Bounds_Screen) / 2 - 30.0f, 10.0f);
//        [cell.contentView addSubview:badgeLabel];
//    }
//    else if (indexPath.row == 4)
//    {
//            cell.imageView.image = [UIImage imageNamed:@"menu_notes"];
//            cell.textLabel.text = @"My Notes";
//    }
//    else if (indexPath.row == 5)
//    {
//        cell.textLabel.text = @"About Axxess";
//    }
//    
//    else if (indexPath.row == 6)
//    {
//        cell.textLabel.text = @"Log Out";
//    }
//    
//    else
//    {
//            cell.imageView.image = [UIImage imageNamed:@"menu_more"];
//            cell.textLabel.text = @"More";
//    }
    
  return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) return 20.0f;
    else return 0.0f;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        UIView * headerView = [[UIView alloc]initWithFrame:CGRectZero];
        headerView.backgroundColor = ACColorGray80Alpha;
        return headerView;
    }
    else return nil;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectedBackgroundView = [[UIView alloc]init];
   
    ((UIView*) cell.selectedBackgroundView).backgroundColor = ACColorGray80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"HasLoggedIn"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [delegate.navigation viewDidAppear:YES];
    }
    else {
        NSString *identifier = [[self.menuDictionary objectForKey:@"Menu_Items"] objectAtIndex:indexPath.row];
        UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
      
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
      }];
    }
}

@end
