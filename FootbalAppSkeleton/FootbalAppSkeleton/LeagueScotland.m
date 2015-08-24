//
//  LeagueScotland.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 24/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "LeagueScotland.h"

@implementation LeagueScotland

static NSMutableArray *allLeaguesScotland;

+(void)addLeaguesScotland: (LeagueScotland *)objectToAdd{
    
    [allLeaguesScotland addObject:objectToAdd];
    NSLog(@"%lu",(unsigned long)[allLeaguesScotland count]);
}

+(NSMutableArray *)getAllLeagueTeamsScotland{
    NSLog(@"%lu",(unsigned long)[allLeaguesScotland count]);
    return allLeaguesScotland;
}
+(void)resetLeaguesScotland{
    allLeaguesScotland = [[NSMutableArray alloc] init];
    NSLog(@"table reset");
}

//take data from api and format the json into a string
+ (NSString *) getDataFromScotland{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/5m2m62ug?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/5m2m62ug?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

//take string of data and extract relevant data and put it into object
+ (void) formatData: (NSString*) returnedDataScotland{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataScotland dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"results"];
    NSArray *detailedUserInfo = [userinfo valueForKey:@"collection1"];
    NSDictionary *singleGameDetails;
    NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    NSInteger index = 1;
    
    [self resetLeaguesScotland];
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            LeagueScotland * newLeaguesScotland
            = [[LeagueScotland alloc] init];
            
            user1 = [singleGameDetails objectForKey:@"Team"];
            newLeaguesScotland.team = [user1 valueForKey:@"text"];
            
            newLeaguesScotland.points = [singleGameDetails objectForKey:@"Points"];
            
            newLeaguesScotland.goalDifference = [singleGameDetails objectForKey:@"GoalDifference"];
            
            newLeaguesScotland.wins = [singleGameDetails objectForKey:@"Wins"];
            
            newLeaguesScotland.losses = [singleGameDetails objectForKey:@"Losses"];
            
            newLeaguesScotland.draws = [singleGameDetails objectForKey:@"Draws"];
            
            newLeaguesScotland.index = [NSString stringWithFormat:@"%ld", (long)index];
            
            [LeagueScotland addLeaguesScotland:newLeaguesScotland];
            
            index++;
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}

@end
