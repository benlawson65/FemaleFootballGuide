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
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://data.import.io/extractor/f1b35d1a-2086-4154-b24b-e7fd789f00ff/json/latest?_apikey=b8d1c620bb0f45829c91f9bdd88e104d8a221fc188b9bcaa1e6c6dea97764aa5eccacf8beea0c56608f514597cbbb97a51107c5a2058f7b85ea0d997ea70f853045cb071338cb6ed77dfc7ed551354d4"]];
    
    //get raw data from url
    NSData *theData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:nil
                                                        error:nil];
    
    //return newJSON;
    return [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
}

//take string of data and extract relevant data and put it into object
+ (void) formatData: (NSString*) returnedDataScotland{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataScotland dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    //unwrap data stored in json file
    NSDictionary *userinfo=[json valueForKey:@"result"];
    NSDictionary *detailedUserInfo = [userinfo valueForKey:@"extractorData"];
    NSArray *nextLayerUserInfo = [detailedUserInfo valueForKey:@"data"];
    NSArray *nextNextLayerUserInfo = [nextLayerUserInfo valueForKey:@"group"];
    NSArray *finalLayerUserInfo = [nextNextLayerUserInfo objectAtIndex:0];
    NSDictionary *singleGameDetails;
    NSInteger i = 0;
    NSString *skey;
    NSInteger index = 1;
    
    [self resetLeaguesScotland];
    
    if(userinfo != nil){
        for( i = 0; i < [finalLayerUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [finalLayerUserInfo objectAtIndex:i];
            
            LeagueScotland * newLeaguesScotland
            = [[LeagueScotland alloc] init];
            
            NSArray *textUnwrapper;
            NSArray *finalTextUnwrapper;
            
            textUnwrapper = [singleGameDetails valueForKey:@"team"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
            newLeaguesScotland.team = [finalTextUnwrapper valueForKey:@"text"];
            //newLeaguesWales.team = [user1 valueForKey:@"text"];
            
            textUnwrapper = [singleGameDetails valueForKey:@"points"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
            newLeaguesScotland.points = [finalTextUnwrapper valueForKey:@"text"];
            
            textUnwrapper = [singleGameDetails valueForKey:@"goaldifference"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
            newLeaguesScotland.goalDifference = [finalTextUnwrapper valueForKey:@"text"];
            
            textUnwrapper = [singleGameDetails valueForKey:@"wins"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
            newLeaguesScotland.wins = [finalTextUnwrapper valueForKey:@"text"];
            
            textUnwrapper = [singleGameDetails valueForKey:@"losses"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
            newLeaguesScotland.losses = [finalTextUnwrapper valueForKey:@"text"];
            
            textUnwrapper = [singleGameDetails valueForKey:@"draws"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
            newLeaguesScotland.draws = [finalTextUnwrapper valueForKey:@"text"];
            
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
