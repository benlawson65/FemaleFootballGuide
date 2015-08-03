//
//  LeagueMenuTableViewController.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 27/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCellView.h"
#import "LeagueDetailTableViewController.h"

@interface LeagueMenuTableViewController : UITableViewController
@property (weak, nonatomic) NSArray* leagueMenu;
- (NSArray *)populateLeagueMenu;
@property (weak, nonatomic) NSString* leagueChosen;
@end
