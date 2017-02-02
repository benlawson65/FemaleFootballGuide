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
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://data.import.io/extractor/b8c451d0-ba9e-4d67-9066-0b2b96189c78/json/latest?_apikey=b8d1c620bb0f45829c91f9bdd88e104d8a221fc188b9bcaa1e6c6dea97764aa5eccacf8beea0c56608f514597cbbb97a51107c5a2058f7b85ea0d997ea70f853045cb071338cb6ed77dfc7ed551354d4"]];
    
    //get raw data from url
    NSData *theData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:nil
                                                        error:nil];
    
    //return newJSON;
    return [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
    
    //return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

//take string of data and extract relevant data and put it into object
+ (void) formatData: (NSString*) returnedDataWales{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataWales dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    //unwrap data stored in json file
    NSDictionary *userinfo=[json valueForKey:@"result"];
    NSDictionary *detailedUserInfo = [userinfo valueForKey:@"extractorData"];
    NSArray *nextLayerUserInfo = [detailedUserInfo valueForKey:@"data"];
    NSArray *nextNextLayerUserInfo = [nextLayerUserInfo valueForKey:@"group"];
    NSArray *finalLayerUserInfo = [nextNextLayerUserInfo objectAtIndex:0];
    NSDictionary *singleGameDetails;
    //NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    NSInteger index = 1;
    
    [self resetLeaguesWales];
    
    if(finalLayerUserInfo != nil){
        for( i = 0; i < [finalLayerUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [finalLayerUserInfo objectAtIndex:i];
            
            LeagueWales * newLeaguesWales
            = [[LeagueWales alloc] init];
            NSArray *textUnwrapper;
            NSArray *finalTextUnwrapper;
            
            textUnwrapper = [singleGameDetails valueForKey:@"teams"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
            newLeaguesWales.team = [finalTextUnwrapper valueForKey:@"text"];
            //newLeaguesWales.team = [user1 valueForKey:@"text"];
            
            textUnwrapper = [singleGameDetails valueForKey:@"points"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
            newLeaguesWales.points = [finalTextUnwrapper valueForKey:@"text"];
            
            textUnwrapper = [singleGameDetails valueForKey:@"goaldifference"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
            newLeaguesWales.goalDifference = [finalTextUnwrapper valueForKey:@"text"];
            
            textUnwrapper = [singleGameDetails valueForKey:@"wins"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
            newLeaguesWales.wins = [finalTextUnwrapper valueForKey:@"text"];
            
            textUnwrapper = [singleGameDetails valueForKey:@"losses"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
            newLeaguesWales.losses = [finalTextUnwrapper valueForKey:@"text"];
            
            textUnwrapper = [singleGameDetails valueForKey:@"draws"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
            newLeaguesWales.draws = [finalTextUnwrapper valueForKey:@"text"];
            
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
