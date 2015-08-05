//
//  ClubSelection1TableController.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 05/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCellView.h"
#import "ClubSelection2TableController.h"
#import "ClubsForLeagueChosen.h"

@interface ClubSelection1TableController : UITableViewController
@property (weak, nonatomic) NSArray* clubMenu;
- (NSArray *)populateClubMenu;
@property (weak, nonatomic) NSString* leagueForClubChosen;
@end
