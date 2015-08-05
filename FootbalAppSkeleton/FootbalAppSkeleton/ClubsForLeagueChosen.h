//
//  ClubsForLeagueChosen.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 05/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClubSelection2TableController.h"

@interface ClubsForLeagueChosen : NSObject

@property (nonatomic, retain) NSString *team;
@property (nonatomic, retain) NSString *leagueForClubChosenPassed;
@property (nonatomic, retain) NSString *index;

+(void) addClubsForLeagueChosen: (ClubsForLeagueChosen *)objectToAdd;
+(NSMutableArray*) getAllClubsForLeagueChosen;
-(void) formatData: (NSString*) returnedClubsForLeagueChosen;
- (NSString *) getDataForLeagueChosen;
-(void)resetClubsForLeagueChosen;
-(void)setLeagueChosen:(NSString*)leagueForClubSelected;
@end
