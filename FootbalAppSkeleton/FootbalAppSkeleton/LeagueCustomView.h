//
//  LeagueCustomView.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 03/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeagueCustomView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leagueRank;
@property (weak, nonatomic) IBOutlet UILabel *leagueTeamName;
@property (weak, nonatomic) IBOutlet UILabel *leagueGD;
@property (weak, nonatomic) IBOutlet UILabel *leaguePoints;
@property (weak, nonatomic) IBOutlet UILabel *leagueWins;
@property (weak, nonatomic) IBOutlet UILabel *leagueDraws;

@property (weak, nonatomic) IBOutlet UILabel *leagueLosees;
@property (weak, nonatomic) IBOutlet UILabel *gdTitle;
@property (weak, nonatomic) IBOutlet UILabel *ptsTitle;
@property (weak, nonatomic) IBOutlet UILabel *winsTitle;
@property (weak, nonatomic) IBOutlet UILabel *drawsTitle;
@property (weak, nonatomic) IBOutlet UILabel *lossesTitle;

@end
