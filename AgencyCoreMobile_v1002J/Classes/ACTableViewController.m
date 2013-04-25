//
//  JTPullRefreshTableViewController.m
//  CheckApp
//
//  Created by Joy Tao on 3/7/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "ACTableViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ACTableViewController ()
{
    BOOL isDragging;
    BOOL isLoading;
    BOOL isLoadingMore;
}
@end

@implementation ACTableViewController
@synthesize refreshHeaderView, refreshLabel, refreshArrow, refreshSpinner ;
@synthesize loadMoreFooter, loadMoreSpinner ,loadMoreLabel;
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
    [self addPullToRefreshHeader];
    if ([self.tableView numberOfRowsInSection:0] > 25) [self addLoadMoreFooter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Layout Rotation

- (void) layoutRotated
{
    refreshHeaderView.frame = CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, self.tableView.frame.size.width, REFRESH_HEADER_HEIGHT);
    refreshLabel.center = CGPointMake(refreshHeaderView.center.x, refreshHeaderView.center.y + REFRESH_HEADER_HEIGHT);
    
    loadMoreFooter.frame = CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, LOADMORE_FOOTER_HEIGHT);
    loadMoreLabel.center = loadMoreFooter.center;
    loadMoreSpinner.center = loadMoreFooter.center;
}

#pragma mark - Pull-To-Update Method

- (void)addPullToRefreshHeader
{
    if (UserInterface_Portrait) refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, self.tableView.frame.size.width, REFRESH_HEADER_HEIGHT)];
    else if (UserInterface_Landscape) refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, self.tableView.frame.size.height, REFRESH_HEADER_HEIGHT)];
    refreshHeaderView.backgroundColor = [UIColor clearColor];
    NSLog(@"%--@",NSStringFromCGRect(refreshHeaderView.frame));
    
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 44.0f)];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = ACFontDefaultBold14;
    refreshLabel.textColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    refreshLabel.center = CGPointMake(refreshHeaderView.center.x, refreshHeaderView.center.y + REFRESH_HEADER_HEIGHT);
    [refreshHeaderView addSubview:refreshLabel];
    //
    //    UIImage * image = [UIImage imageNamed:@"img_loadingArrow"];
    //    refreshArrow = [[UIImageView alloc] initWithImage:image];
    //    refreshArrow.frame = CGRectMake(280 - floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
    //                                    (floorf(REFRESH_HEADER_HEIGHT - 36) / 2),
    //                                    27, 44);
    //
    //    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    //    refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 32) / 2), floorf((REFRESH_HEADER_HEIGHT - 32) / 2), 32, 32);
    //    refreshSpinner.hidesWhenStopped = YES;
    //
    //    [refreshHeaderView addSubview:refreshLabel];
    //    [refreshHeaderView addSubview:refreshArrow];
    //    [refreshHeaderView addSubview:refreshSpinner];
    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    refreshSpinner.frame = CGRectMake(0.0f, 0.0f, 44.0f, 44.0f);
    refreshSpinner.center = CGPointMake(refreshLabel.frame.origin.x - refreshSpinner.frame.size.width, refreshHeaderView.center.y + REFRESH_HEADER_HEIGHT);
    refreshSpinner.hidesWhenStopped = YES;
    [refreshHeaderView addSubview:refreshSpinner];
    [self.tableView addSubview:refreshHeaderView];
}

- (void)startLoading {
    isLoading = YES;
    // Show the header
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        refreshLabel.text = @"Loading...";
        refreshArrow.hidden = YES;
        [refreshSpinner startAnimating];
    }];
    
    // Refresh action!
    [self refresh];
}
// Note: Consider the tabbar
- (void)stopLoading {
    isLoading = NO;
    
    // Hide the header
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 49.0f, 0.0f);
        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(stopLoadingComplete)];
                     }];
}

- (void)stopLoadingComplete {
    // Reset the header
    refreshLabel.text = @"Pull down to refresh...";
    refreshArrow.hidden = NO;
    [refreshSpinner stopAnimating];
}

- (void)refresh {
    
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
}

#pragma mark - FooterView Load More Method

- (void) addLoadMoreFooter
{
    if (UserInterface_Portrait) loadMoreFooter = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, LOADMORE_FOOTER_HEIGHT)];
    else if (UserInterface_Landscape) loadMoreFooter = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.height, LOADMORE_FOOTER_HEIGHT)];
    loadMoreFooter.backgroundColor = [UIColor redColor];
    
    loadMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 44.0f)];
    loadMoreLabel.backgroundColor = [UIColor clearColor];
    loadMoreLabel.font = ACFontDefaultBold14;
    loadMoreLabel.textColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    loadMoreLabel.textAlignment = NSTextAlignmentCenter;
    loadMoreLabel.center = loadMoreFooter.center;
    //    [loadMoreFooter addSubview:loadMoreLabel];
    
    loadMoreSpinner = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    loadMoreSpinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    //    loadMoreSpinner.center = CGPointMake(refreshLabel.frame.origin.x - loadMoreSpinner.frame.size.width, refreshLabel.center.y);
    loadMoreSpinner.center = loadMoreFooter.center;
    loadMoreSpinner.hidesWhenStopped = YES;
    [loadMoreFooter addSubview:loadMoreSpinner];
    self.tableView.tableFooterView = loadMoreFooter;
}

- (void) startLoadingMore
{
    isLoadingMore = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0, LOADMORE_FOOTER_HEIGHT, 0);
        NSLog(@"startLoadingMore");
        loadMoreLabel.text = @"Loading More";
    }];
    [loadMoreSpinner startAnimating];
    
    [self loadMore];
}

- (void) stopLoadinMore
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.tableView.contentInset.top, self.tableView.contentInset.left, LOADMORE_FOOTER_HEIGHT, self.tableView.contentInset.right);
    }
                     completion:^(BOOL finished) {
                         [loadMoreSpinner stopAnimating];
                         isLoadingMore = NO;
                     }];
    
}

- (void) loadMore
{
    [self performSelector:@selector(stopLoadinMore) withObject:nil afterDelay:2.0];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoading) {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            self.tableView.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            self.tableView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView animateWithDuration:0.25 animations:^{
            if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
                // User is scrolling above the header
                refreshLabel.text = @"Release to refresh...";
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            } else {
                // User is scrolling somewhere within the header
                refreshLabel.text = @"Pull down to refresh...";
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            }
        }];
    }
    
    if (loadMoreFooter && isLoadingMore == NO)
    {
        NSInteger currentOffset = self.tableView.contentOffset.y;
        NSInteger maximumOffset = self.tableView.contentSize.height - self.tableView.frame.size.height;
        
        // Change 10.0 to adjust the distance from bottom
        if (maximumOffset - currentOffset <= LOADMORE_FOOTER_HEIGHT) {
            [self startLoadingMore];
            
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT - 49.0f) {
        // Released above the header
        [self startLoading];
    }
    
    //    if (scrollView.contentOffset.y >= self.tableView.frame.size.height)
    //        [self startLoadingMore];
}


@end
