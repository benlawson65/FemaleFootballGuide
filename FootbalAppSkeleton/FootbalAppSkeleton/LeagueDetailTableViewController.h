//
//  LeagueDetailTableViewController.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 02/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeagueCustomView.h"
#import "LeagueWales.h"

@interface LeagueDetailTableViewController : UITableViewController
@property(weak, nonatomic) NSString *leagueSelected;
@property (strong, nonatomic) NSIndexPath *expandedIndexPath;
-(void)delayedMethodExpand:(NSArray *)array;
@property (weak, nonatomic) UITableView *previousTableView;
@property (weak, nonatomic) NSIndexPath *previousIndexPath;
-(void)minimizeDetails;
@end
