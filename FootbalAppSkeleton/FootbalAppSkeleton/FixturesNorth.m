//
//  FixturesNorth.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 31/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixturesNorth.h"

@implementation FixturesNorth

static NSMutableArray *allFixturesNorth;

+(void)addFixturesNorth: (FixturesNorth *)objectToAdd{
    [allFixturesNorth addObject:objectToAdd];
}

+(NSMutableArray *)getAllFixturesNorth{
    return allFixturesNorth;
}

+(void)resetFixturesNorth{
    allFixturesNorth = [[NSMutableArray alloc] init];
}


+ (NSString *) getDataFromNorth{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://data.import.io/extractor/04963756-7ce6-45de-8dcd-ec5d52c441a5/json/latest?_apikey=b8d1c620bb0f45829c91f9bdd88e104d8a221fc188b9bcaa1e6c6dea97764aa5eccacf8beea0c56608f514597cbbb97a51107c5a2058f7b85ea0d997ea70f853045cb071338cb6ed77dfc7ed551354d4"]];
    
    //get raw data from url
    NSData *theData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:nil
                                                        error:nil];
    
    //return newJSON;
    return [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
}

+ (void) formatData: (NSString*) returnedDataNorth{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataNorth dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    //unwrap data stored in json file
    NSDictionary *userinfo=[json valueForKey:@"result"];
    NSDictionary *detailedUserInfo = [userinfo valueForKey:@"extractorData"];
    NSArray *nextLayerUserInfo = [detailedUserInfo valueForKey:@"data"];
    NSArray *nextNextLayerUserInfo = [nextLayerUserInfo valueForKey:@"group"];
    NSArray *finalLayerUserInfo = [nextNextLayerUserInfo objectAtIndex:0];
    NSDictionary *singleGameDetails;
    NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    
    [self resetFixturesNorth];
    
    
    if(userinfo != nil){
        for( i = 0; i < [finalLayerUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [finalLayerUserInfo objectAtIndex:i];
            
            FixturesNorth * newFixturesNorth = [[FixturesNorth alloc] init];
            
            user1 = [singleGameDetails objectForKey:@"home"];
            NSString *strWithDataHome = [FixturesNorth checkDataLocation:user1];
            newFixturesNorth.homeTeam = strWithDataHome;
            
            user1 = [singleGameDetails objectForKey:@"away"];
            NSString *strWithDataAway = [FixturesNorth checkDataLocation:user1];
            newFixturesNorth.awayTeam = strWithDataAway;
            
            user1 = [singleGameDetails objectForKey:@"date"];
            NSString *strWithDataDate = [FixturesNorth checkDataLocation:user1];
            newFixturesNorth.timeDate = strWithDataDate;
            
            user1 = [singleGameDetails objectForKey:@"venue"];
            NSString *strWithDataVenue = [FixturesNorth checkDataLocation:user1];
            newFixturesNorth.venue = strWithDataVenue;
            
            newFixturesNorth.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            //format date to check its in future
            NSDateFormatter *dateFormatFixture=[[NSDateFormatter alloc]init];
            
            //[dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
            [dateFormatFixture setDateFormat:@"dd-MM-yy HH:mm"];
            [dateFormatFixture setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            
            //[dateFormatFixture setDateFormat:@"K:mm a"];
            
            NSDate *fixtureDate = [[NSDate alloc] init];
            fixtureDate = [dateFormatFixture dateFromString:newFixturesNorth.timeDate];
            
            Location *obj = [[Location alloc] init];
            BOOL dateCheck = [obj compareDates:fixtureDate];
            
            //if date is in future, add fixture
            if(dateCheck){
                
                [FixturesNorth addFixturesNorth:newFixturesNorth];
            }
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}

+ (NSString *) checkDataLocation: (NSDictionary*) dictionaryContainingData{
    NSString *strContainingWantedData;
    NSArray *wrappedData;
    
    //user1 = [singleGameDetails objectForKey:@"Home Team"];
    if ([dictionaryContainingData isKindOfClass:[NSArray class]]){
        wrappedData = [dictionaryContainingData valueForKey:@"text"];
        strContainingWantedData = [wrappedData objectAtIndex:0];
        
    }
    else{
        strContainingWantedData = [NSString stringWithFormat:@"%@", dictionaryContainingData];
    }
    
    return strContainingWantedData;
}

@end
