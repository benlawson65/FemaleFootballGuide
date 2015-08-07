//
//  RetrieveTeamPlayersWSL.m
//  
//
//  Created by Homer Simpson on 06/08/2015.
//
//

#import "RetrieveTeamPlayersWSL.h"

@implementation RetrieveTeamPlayersWSL

@synthesize name;
@synthesize position;
@synthesize chosenClub;
@synthesize index;
@synthesize chosenLeague;

static NSMutableArray *allPlayersWSL;

+(void)addPlayersWSL: (RetrieveTeamPlayersWSL *)objectToAdd{
    
    [allPlayersWSL addObject:objectToAdd];
}

-(NSMutableArray *)getAllPlayersWSL{
    return allPlayersWSL;
}
-(void)resetPlayersWSL{
    allPlayersWSL = [[NSMutableArray alloc] init];
}

-(void)setClubChosen:(NSString*)clubForPlayersChosen{
    chosenClub = clubForPlayersChosen;
}
-(void)setLeagueChosen:(NSString*)leagueForClubsChosen{
    chosenLeague = leagueForClubsChosen;
}

- (NSString *) getDataFromWSL{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    
    if ([chosenLeague isEqualToString:(@"WSL1")]){
    
            [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/eeknfvvw?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
    
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *responseCode = nil;
    
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/eeknfvvw?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
            return nil;
        }
    
        return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    }
    if ([chosenLeague isEqualToString:(@"WSL2")]){
        
        [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/6ablbrxq?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *responseCode = nil;
        
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/6ablbrxq?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
            return nil;
        }
        
        return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    }

    else {return nil;}
}

- (void) formatData: (NSString*) returnedDataWSL{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataWSL dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"results"];
    NSArray *detailedUserInfo = [userinfo valueForKey:@"collection1"];
    NSDictionary *singleGameDetails;
    NSInteger i = 0;
    NSString *skey;
    
    BOOL clubFound = false;
    BOOL firstPlayer = false;
    
    [self resetPlayersWSL];
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            RetrieveTeamPlayersWSL * newPlayersForClubChosen = [[RetrieveTeamPlayersWSL alloc] init];
            
            NSString *teamName = [singleGameDetails objectForKey:@"Team"];
            
            //find right club and extract data from first person
            if([chosenClub isEqualToString:teamName]){
                
                newPlayersForClubChosen.name = [singleGameDetails objectForKey:@"name"];
                newPlayersForClubChosen.position = [singleGameDetails objectForKey:@"Position"];
                
                newPlayersForClubChosen.index = [NSString stringWithFormat:@"%ld", (long)i];
                
                //add data to array of objects
                [RetrieveTeamPlayersWSL addPlayersWSL:newPlayersForClubChosen];
                
                //continue to extract data from correct club
                clubFound = true;
                firstPlayer = true;
            }
            
            //extract data when found right club for rest of players
            if(clubFound == true && firstPlayer == false){
                
                RetrieveTeamPlayersWSL * newPlayersForClubChosen = [[RetrieveTeamPlayersWSL alloc] init];
                
                NSString *positionLocal = [singleGameDetails objectForKey:@"Position"];
                
                NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                f.numberStyle = NSNumberFormatterDecimalStyle;
                NSNumber *numberPosition = [f numberFromString:positionLocal];
                
                NSNumber *nextTeam = [NSNumber numberWithInt:1];
                
                //only extract if still in same club, if not, stop extracting data
                if(!([numberPosition isEqualToNumber:nextTeam])){
                    newPlayersForClubChosen.name = [singleGameDetails objectForKey:@"Name"];
                    newPlayersForClubChosen.position = [singleGameDetails objectForKey:@"Position"];
                
                    newPlayersForClubChosen.index = [NSString stringWithFormat:@"%ld", (long)i];
                }
                else {
                    clubFound = false;
                }
                
                //add data to array of objects
                [RetrieveTeamPlayersWSL addPlayersWSL:newPlayersForClubChosen];
            }
            firstPlayer = false;

        }
    }
    else{
        NSLog(@"no data found in json results");
    }

}
@end
