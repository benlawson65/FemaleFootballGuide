//
//  FixturesNorthernOne.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 24/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixturesNorthernOne.h"

@implementation FixturesNorthernOne

static NSMutableArray *allFixturesNorthernOne;

+(void)addFixturesNorthernOne: (FixturesNorthernOne *)objectToAdd{
    
    [allFixturesNorthernOne addObject:objectToAdd];
}

+(NSMutableArray *)getAllFixturesNorthernOne{
    return allFixturesNorthernOne;
}
+(void)resetFixturesNorthernOne{
    allFixturesNorthernOne = [[NSMutableArray alloc] init];
}

+ (NSString *) getDataFromNorthernOne{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://data.import.io/extractor/13910188-d057-4d1e-a6e4-452c1ee6ef65/json/latest?_apikey=b8d1c620bb0f45829c91f9bdd88e104d8a221fc188b9bcaa1e6c6dea97764aa5eccacf8beea0c56608f514597cbbb97a51107c5a2058f7b85ea0d997ea70f853045cb071338cb6ed77dfc7ed551354d4"]];
    
    //get raw data from url
    NSData *theData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:nil
                                                        error:nil];
    
    //return newJSON;
    return [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
}

+ (void) formatData: (NSString*) returnedDataNorthernOne{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataNorthernOne dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
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
    
    [self resetFixturesNorthernOne];
    
    if(userinfo != nil){
        for( i = 0; i < [finalLayerUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [finalLayerUserInfo objectAtIndex:i];
            
            FixturesNorthernOne * newFixturesNorthernOne = [[FixturesNorthernOne alloc] init];
            
            user1 = [singleGameDetails objectForKey:@"home"];
            NSString *strWithDataHome = [FixturesNorthernOne checkDataLocation:user1];
            newFixturesNorthernOne.homeTeam = strWithDataHome;
            
            user1 = [singleGameDetails objectForKey:@"away"];
            NSString *strWithDataAway = [FixturesNorthernOne checkDataLocation:user1];
            newFixturesNorthernOne.awayTeam = strWithDataAway;
            
            user1 = [singleGameDetails objectForKey:@"time"];
            NSString *strWithDataDate = [FixturesNorthernOne checkDataLocation:user1];
            newFixturesNorthernOne.timeDate = strWithDataDate;
            
            user1 = [singleGameDetails objectForKey:@"venue"];
            NSString *strWithDataVenue = [FixturesNorthernOne checkDataLocation:user1];
            newFixturesNorthernOne.venue = strWithDataVenue;
            
            newFixturesNorthernOne.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            //format date to check its in future
            NSDateFormatter *dateFormatFixture=[[NSDateFormatter alloc]init];
            
            //[dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
            [dateFormatFixture setDateFormat:@"dd-MM-yy HH:mm"];
            [dateFormatFixture setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            
            //[dateFormatFixture setDateFormat:@"K:mm a"];
            
            NSDate *fixtureDate = [[NSDate alloc] init];
            fixtureDate = [dateFormatFixture dateFromString:newFixturesNorthernOne.timeDate];
            
            Location *obj = [[Location alloc] init];
            BOOL dateCheck = [obj compareDates:fixtureDate];
            
            //if date is in future, add fixture
            if(dateCheck){
                
                [FixturesNorthernOne addFixturesNorthernOne:newFixturesNorthernOne];
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
