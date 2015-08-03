//
//  LeagueWales.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 03/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "LeagueWales.h"

@implementation LeagueWales

static NSMutableArray *allLeaguesWales;

+(void)addLeaguesWales: (LeagueWales *)objectToAdd{
    
    [allLeaguesWales addObject:objectToAdd];
}

+(NSMutableArray *)getAllLeagueTeamsWales{
    return allLeaguesWales;
}
+(void)resetLeaguesWales{
    allLeaguesWales = [[NSMutableArray alloc] init];
}

//take data from api and format the json into a string
+ (NSString *) getDataFromWales{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/5tfl53ne?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/5tfl53ne?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

//take string of data and extract relevant data and put it into object
+ (void) formatData: (NSString*) returnedDataWales{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataWales dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"results"];
    NSArray *detailedUserInfo = [userinfo valueForKey:@"collection1"];
    NSDictionary *singleGameDetails;
    NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    
    [self resetLeaguesWales];
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            LeagueWales * newLeaguesWales
            = [[LeagueWales alloc] init];
            
            user1 = [singleGameDetails objectForKey:@"Team"];
            newLeaguesWales.team = [user1 valueForKey:@"text"];
            
            newLeaguesWales.points = [singleGameDetails objectForKey:@"Points"];
            
            newLeaguesWales.goalDifference = [singleGameDetails objectForKey:@"GoalDifference"];
            
            newLeaguesWales.wins = [singleGameDetails objectForKey:@"Wins"];
            
            newLeaguesWales.losses = [singleGameDetails objectForKey:@"Losses"];
            
            newLeaguesWales.draws = [singleGameDetails objectForKey:@"Draws"];
            
            newLeaguesWales.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            [LeagueWales addLeaguesWales:newLeaguesWales];
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}


@end
