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
#import "LeagueScotland.h"

@interface LeagueDetailTableViewController : UITableViewController
@property(weak, nonatomic) NSString *leagueSelected;
@property (strong, nonatomic) NSIndexPath *expandedIndexPath;
@property (strong, nonatomic) NSMutableArray *expandedIndexPaths;
-(void)delayedMethodExpand:(NSArray*)array;
@property (weak, nonatomic) UITableView *previousTableView;
@property (weak, nonatomic) NSIndexPath *previousIndexPath;
@property (weak, nonatomic) NSIndexPath *currentIndexPath;
@property (weak, nonatomic) UITableView *currentTableView;
@property BOOL expandedCellFound;
@property BOOL firstLoad;
@property BOOL selected;
@property BOOL selectedAgain;
-(void) minimizeDetails:(NSArray*)array;
@property (strong, nonatomic) NSMutableArray *cellsizeStatus;
@end
