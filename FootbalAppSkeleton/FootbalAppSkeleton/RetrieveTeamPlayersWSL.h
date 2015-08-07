//
//  RetrieveTeamPlayersWSL.h
//  
//
//  Created by Homer Simpson on 06/08/2015.
//
//

#import <Foundation/Foundation.h>

@interface RetrieveTeamPlayersWSL : NSObject
@property (nonatomic, retain) NSString *position;
@property (nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *chosenClub;
@property (nonatomic, retain) NSString *index;
@property (nonatomic, retain) NSString *chosenLeague;

+(void) addPlayersWSL: (RetrieveTeamPlayersWSL *)objectToAdd;
-(NSMutableArray*) getAllPlayersWSL;
-(void) formatData: (NSString*) returnedDataWSL;
-(NSString *) getDataFromWSL;
-(void)resetPlayersWSL;
-(void)setChosenClub:(NSString *)chosenClub;
-(void)setLeagueChosen:(NSString*)leagueForClubsChosen;

@end
