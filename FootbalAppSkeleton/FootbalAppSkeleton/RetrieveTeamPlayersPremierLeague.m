//
//  RetrieveTeamPlayersPremierLeague.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 08/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "RetrieveTeamPlayersPremierLeague.h"

@implementation RetrieveTeamPlayersPremierLeague

@synthesize name;
@synthesize chosenClub;
@synthesize index;
@synthesize chosenLeague;
@synthesize nameTest;

static NSMutableArray *allPlayersPremierLeague;

+(void)addPlayersPremierLeague: (RetrieveTeamPlayersPremierLeague *)objectToAdd{
    
    [allPlayersPremierLeague addObject:objectToAdd];
}

-(NSMutableArray *)getAllPlayersPremierLeague{
    return allPlayersPremierLeague;
}
-(void)resetPlayersPremierLeague{
    allPlayersPremierLeague = [[NSMutableArray alloc] init];
}

-(void)setClubChosen:(NSString*)clubForPlayersChosen{
    chosenClub = clubForPlayersChosen;
}
-(void)setLeagueChosen:(NSString*)leagueForClubsChosen{
    chosenLeague = leagueForClubsChosen;
}

-(NSString *)findCorrectClubData{
    NSString *urlForApiData;
    
    
    /// NORTHERN DIVISION ///
    
    //cant find player line up
    if([chosenClub isEqualToString:@"Guiseley AFC Vixens"]){
        urlForApiData = @"https://www.kimonolabs.com/api/3xr7khui?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }

    if([chosenClub isEqualToString:@"Loughborough Foxes WFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/d6dp90li?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    //needs filtering (done)
    if([chosenClub isEqualToString:@"Blackburn Rovers LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/d6jf4xt6?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    //needs manual data
    if([chosenClub isEqualToString:@"Bradford City WFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/d6jf4xt6?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    if([chosenClub isEqualToString:@"Huddersfield Town LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/56n8vf2u?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    //needs manual data
    if([chosenClub isEqualToString:@"Derby County LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/d6jf4xt6?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    if([chosenClub isEqualToString:@"Stoke City LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/c1aq5usi?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    //needs manual data
    if([chosenClub isEqualToString:@"Preston North End WFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/d6jf4xt6?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    if([chosenClub isEqualToString:@"Nottingham Forest LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/5tvxh032?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    //have to get data manually
    if([chosenClub isEqualToString:@"Sporting Club Albion LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/5tvxh032?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    if([chosenClub isEqualToString:@"Newcastle United WFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/278g758w?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    //have to get data manually
    if([chosenClub isEqualToString:@"Nuneaton Town LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/278g758w?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    /// SOUTHERN DIVISION ///
    
    //have to get data manually
    if([chosenClub isEqualToString:@"Portsmouth Ladies"]){
        urlForApiData = @"https://www.kimonolabs.com/api/278g758w?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    //not allowed to use there data
    if([chosenClub isEqualToString:@"Brighton & Hove Albion WFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/278g758w?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    //have to get data manually
    if([chosenClub isEqualToString:@"Charlton Athletic WFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/278g758w?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    //have to get data manually
    if([chosenClub isEqualToString:@"Cardiff City LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/278g758w?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    //have to get data manually
    if([chosenClub isEqualToString:@"Tottenham Hotspur LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/278g758w?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    if([chosenClub isEqualToString:@"West Ham United LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/30kih854?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    if([chosenClub isEqualToString:@"Lewes LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/5gpjeyys?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    if([chosenClub isEqualToString:@"Coventry United LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/ctyodsl4?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    //manual data needed
    if([chosenClub isEqualToString:@"Queens Park Rangers LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/ctyodsl4?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    if([chosenClub isEqualToString:@"Plymouth Argyle LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/85gropsw?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    if([chosenClub isEqualToString:@"C & K Basildon LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/2dgmuipe?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    //manual data needed
    if([chosenClub isEqualToString:@"Forest Green Rovers LFC"]){
        urlForApiData = @"https://www.kimonolabs.com/api/85gropsw?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A";
    }
    
    return urlForApiData;
    
}

- (NSString *) getDataFromPremierLeague{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
        
        [request setURL:[NSURL URLWithString:[self findCorrectClubData]]];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *responseCode = nil;
        
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %li", [self findCorrectClubData], (long)[responseCode statusCode]);
            return nil;
        }
        
        return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}


- (void) formatData: (NSString*) returnedDataPremierLeague{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataPremierLeague dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"results"];
    NSArray *detailedUserInfo = [userinfo valueForKey:@"collection1"];
    NSDictionary *singleGameDetails;
    NSDictionary *getTextData;
    NSInteger i = 0;
    NSString *skey;
    
    [self resetPlayersPremierLeague];
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            RetrieveTeamPlayersPremierLeague * newPlayersForClubChosen = [[RetrieveTeamPlayersPremierLeague alloc] init];
            
            nameTest = [singleGameDetails valueForKey:@"Name"];
            
            //if the data is under text not name then run this statement
            if([nameTest isKindOfClass:[NSDictionary class]]){
                
                //named under alt not text for stoke
                if([chosenClub isEqualToString:@"Stoke City LFC"]){
                    
                    getTextData = [singleGameDetails objectForKey:@"Name"];
                    newPlayersForClubChosen.name = [getTextData valueForKey:@"alt"];
                    newPlayersForClubChosen.index = [NSString stringWithFormat:@"%ld", (long)i];

                }
                else{
                    getTextData = [singleGameDetails objectForKey:@"Name"];
                    newPlayersForClubChosen.name = [getTextData valueForKey:@"text"];
                    newPlayersForClubChosen.index = [NSString stringWithFormat:@"%ld", (long)i];
                }
            }
            else{
                
                //blackburn rovers has the wrong data for the first two indexes, dont take it
                if([chosenClub isEqualToString:@"Blackburn Rovers LFC"]){
                    if (i != 0 && i != 1){
                        newPlayersForClubChosen.name = [singleGameDetails objectForKey:@"Name"];
                        newPlayersForClubChosen.index = [NSString stringWithFormat:@"%ld", (long)i - 2];
                    }
                }
                
                else{
                    newPlayersForClubChosen.name = [singleGameDetails objectForKey:@"Name"];
                    newPlayersForClubChosen.index = [NSString stringWithFormat:@"%ld", (long)i];
                }
            }
            
            //dont add elements to array if they are the junk data from blackburn rovers
            if(i == 0 || i == 1){
                if(![chosenClub isEqualToString:@"Blackburn Rovers LFC"]){
                    //add data to array of objects
                    [RetrieveTeamPlayersPremierLeague addPlayersPremierLeague:newPlayersForClubChosen];
                }
            }
            
            else{
                //add data to array of objects
                [RetrieveTeamPlayersPremierLeague addPlayersPremierLeague:newPlayersForClubChosen];
            }
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
    
}

@end
