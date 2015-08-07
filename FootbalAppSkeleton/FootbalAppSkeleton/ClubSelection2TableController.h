//
//  ClubSelection2TableController.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 05/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClubsForLeagueChosen.h"
#import "ClubListCustomCell.h"
#import "PlayerTableViewController.h"

@interface ClubSelection2TableController : UITableViewController
@property(weak, nonatomic) NSString *leagueForClubSelected;
@property (weak, nonatomic) NSString* clubChosen;
@property (weak, nonatomic) NSArray* returnedClubs;
@property (strong, nonatomic) NSMutableArray* clubList;

@end
