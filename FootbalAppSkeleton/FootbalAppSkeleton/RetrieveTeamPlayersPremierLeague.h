//
//  RetrieveTeamPlayersPremierLeague.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 08/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RetrieveTeamPlayersPremierLeague : NSObject

@property (nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *chosenClub;
@property (nonatomic, retain) NSString *index;
@property (nonatomic, retain) NSString *chosenLeague;
@property (nonatomic, retain) NSDictionary *nameTest;

+(void) addPlayersPremierLeague: (RetrieveTeamPlayersPremierLeague *)objectToAdd;
-(NSMutableArray*) getAllPlayersPremierLeague;
-(void) formatData: (NSString*) returnedDataPremierLeague;
-(NSString *) getDataFromPremierLeague;
-(void)resetPlayersPremierLeague;
-(void)setChosenClub:(NSString *)chosenClub;
-(void)setLeagueChosen:(NSString*)leagueForClubsChosen;
@end
