//
//  JTPullRefreshTableViewController.h
//  CheckApp
//
//  Created by Joy Tao on 3/7/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACTableViewController : UITableViewController

@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshLabel;
@property (nonatomic, retain) UILabel *loadMoreLabel;

@property (nonatomic, retain) UIImageView *refreshArrow;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic, retain) UIActivityIndicatorView *loadMoreSpinner;

@property (nonatomic, retain) UIView *loadMoreFooter;


- (void) addPullToRefreshHeader;
- (void)startLoading;
- (void)stopLoading;
- (void)refresh;

- (void) addLoadMoreFooter;
- (void) startLoadingMore;
- (void) stopLoadinMore;
- (void) loadMore;
//- (void) stopLoadingMoreComplete;

@end
