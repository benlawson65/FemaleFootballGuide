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
    //[request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/5tfl53ne?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
    
    [request setURL:[NSURL URLWithString:@"https://api.import.io/store/connector/4197fd3b-7c91-403c-9e76-95a61b149aeb/_query?format=JSON&input=%7Bteams%7D%3A%7Bpoints%7D%3A%7Bwins%7D%3A%7Bdraws%7D%3A%7Blosses%7D&_apikey=b8d1c620bb0f45829c91f9bdd88e104d8a221fc188b9bcaa1e6c6dea97764aa5eccacf8beea0c56608f514597cbbb97a51107c5a2058f7b85ea0d997ea70f853045cb071338cb6ed77dfc7ed551354d4"]];
   
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
    
    NSArray *userInfo=[json valueForKey:@"results"];
    //NSArray *detailedUserInfo = [userinfo valueForKey:@"collection1"];
    NSDictionary *singleGameDetails;
    //NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    NSInteger index = 1;
    
    [self resetLeaguesWales];
    
    if(userInfo != nil){
        for( i = 0; i < [userInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [userInfo objectAtIndex:i];
            
            LeagueWales * newLeaguesWales
            = [[LeagueWales alloc] init];
            
            newLeaguesWales.team = [singleGameDetails objectForKey:@"teams"];
            //newLeaguesWales.team = [user1 valueForKey:@"text"];
            
            newLeaguesWales.points = [singleGameDetails objectForKey:@"points"];
            
            newLeaguesWales.goalDifference = [singleGameDetails objectForKey:@"goaldifference"];
            
            newLeaguesWales.wins = [singleGameDetails objectForKey:@"wins"];
            
            newLeaguesWales.losses = [singleGameDetails objectForKey:@"losses"];
            
            newLeaguesWales.draws = [singleGameDetails objectForKey:@"draws"];
            
            newLeaguesWales.index = [NSString stringWithFormat:@"%ld", (long)index];
            
            [LeagueWales addLeaguesWales:newLeaguesWales];
            
            index++;
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}


@end
