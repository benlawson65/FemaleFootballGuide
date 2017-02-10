//
//  FixturesSouthWest.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 24/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixturesSouthWest.h"

@implementation FixturesSouthWest

static NSMutableArray *allFixturesSouthWest;

+(void)addFixturesSouthWest: (FixturesSouthWest *)objectToAdd{
    
    [allFixturesSouthWest addObject:objectToAdd];
}

+(NSMutableArray *)getAllFixturesSouthWest{
    return allFixturesSouthWest;
}
+(void)resetFixturesSouthWest{
    allFixturesSouthWest = [[NSMutableArray alloc] init];
}

+ (NSString *) getDataFromSouthWest{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://data.import.io/extractor/c4116419-fc6a-49be-9b8a-7ae916b7c0b0/json/latest?_apikey=b8d1c620bb0f45829c91f9bdd88e104d8a221fc188b9bcaa1e6c6dea97764aa5eccacf8beea0c56608f514597cbbb97a51107c5a2058f7b85ea0d997ea70f853045cb071338cb6ed77dfc7ed551354d4"]];
    
    //get raw data from url
    NSData *theData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:nil
                                                        error:nil];
    
    //return newJSON;
    return [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
}

+ (void) formatData: (NSString*) returnedDataSouthWest{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataSouthWest dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"result"];
    NSDictionary *detailedUserInfo = [userinfo valueForKey:@"extractorData"];
    NSArray *nextLayerUserInfo = [detailedUserInfo valueForKey:@"data"];
    NSArray *nextNextLayerUserInfo = [nextLayerUserInfo valueForKey:@"group"];
    NSArray *finalLayerUserInfo = [nextNextLayerUserInfo objectAtIndex:0];
    NSDictionary *singleGameDetails;
    NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    
    [self resetFixturesSouthWest];
    
    if(userinfo != nil){
        for( i = 0; i < [finalLayerUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [finalLayerUserInfo objectAtIndex:i];
            
            FixturesSouthWest * newFixturesSouthWest = [[FixturesSouthWest alloc] init];
            
            user1 = [singleGameDetails objectForKey:@"home"];
            NSString *strWithDataHome = [FixturesSouthWest checkDataLocation:user1];
            newFixturesSouthWest.homeTeam = strWithDataHome;
            
            user1 = [singleGameDetails objectForKey:@"away"];
            NSString *strWithDataAway = [FixturesSouthWest checkDataLocation:user1];
            newFixturesSouthWest.awayTeam = strWithDataAway;
            
            user1 = [singleGameDetails objectForKey:@"time"];
            NSString *strWithDataDate = [FixturesSouthWest checkDataLocation:user1];
            newFixturesSouthWest.timeDate = strWithDataDate;
            
            user1 = [singleGameDetails objectForKey:@"venue"];
            NSString *strWithDataVenue = [FixturesSouthWest checkDataLocation:user1];
            newFixturesSouthWest.venue = strWithDataVenue;
            
            newFixturesSouthWest.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            //format date to check its in future
            NSDateFormatter *dateFormatFixture=[[NSDateFormatter alloc]init];
            
            //[dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
            [dateFormatFixture setDateFormat:@"dd-MM-yy HH:mm"];
            [dateFormatFixture setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            
            //[dateFormatFixture setDateFormat:@"K:mm a"];
            
            NSDate *fixtureDate = [[NSDate alloc] init];
            fixtureDate = [dateFormatFixture dateFromString:newFixturesSouthWest.timeDate];
            
            Location *obj = [[Location alloc] init];
            BOOL dateCheck = [obj compareDates:fixtureDate];
            
            //if date is in future, add fixture
            if(dateCheck){
                
                [FixturesSouthWest addFixturesSouthWest:newFixturesSouthWest];
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
