//
//  PlayerTableViewController.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 06/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetrieveTeamPlayersWSL.h"
#import "PlayerListCustomCell.h"

@interface PlayerTableViewController : UITableViewController
@property (weak, nonatomic) NSString* clubForPlayersChosen;
@property (weak, nonatomic) NSString* leagueChosen;
@property (strong, nonatomic) NSArray* returnedPlayers;

-(void)setLeagueChosen:(NSString *)leagueChosenPassed;
@end
