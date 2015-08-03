//
//  LeagueCustomView.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 03/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "LeagueCustomView.h"

@implementation LeagueCustomView

@synthesize leagueGD;
@synthesize leagueDraws;
@synthesize leagueLosees;
@synthesize leaguePoints;
@synthesize leagueWins;

@synthesize gdTitle;
@synthesize ptsTitle;
@synthesize winsTitle;
@synthesize drawsTitle;
@synthesize lossesTitle;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)hideDetails{
    leagueGD.text = @"";
    leagueWins.text = @"";
    
}

@end
