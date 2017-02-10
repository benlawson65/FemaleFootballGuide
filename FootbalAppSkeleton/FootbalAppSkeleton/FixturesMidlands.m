//
//  FixturesMidlands.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 24/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixturesMidlands.h"

@implementation FixturesMidlands

static NSMutableArray *allFixturesMidlands;

+(void)addFixturesMidlands: (FixturesMidlands *)objectToAdd{
    
    [allFixturesMidlands addObject:objectToAdd];
}

+(NSMutableArray *)getAllFixturesMidlands{
    return allFixturesMidlands;
}
+(void)resetFixturesMidlands{
    allFixturesMidlands = [[NSMutableArray alloc] init];
}

+ (NSString *) getDataFromMidlands{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://data.import.io/extractor/11d751f2-0d97-459e-a349-d8655f12987c/json/latest?_apikey=b8d1c620bb0f45829c91f9bdd88e104d8a221fc188b9bcaa1e6c6dea97764aa5eccacf8beea0c56608f514597cbbb97a51107c5a2058f7b85ea0d997ea70f853045cb071338cb6ed77dfc7ed551354d4"]];
    
    //get raw data from url
    NSData *theData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:nil
                                                        error:nil];
    
    //return newJSON;
    return [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
}

+ (void) formatData: (NSString*) returnedDataMidlands{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataMidlands dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"result"];
    NSDictionary *detailedUserInfo = [userinfo valueForKey:@"extractorData"];
    NSArray *nextLayerUserInfo = [detailedUserInfo valueForKey:@"data"];
    NSArray *nextNextLayerUserInfo = [nextLayerUserInfo valueForKey:@"group"];
    NSArray *finalLayerUserInfo = [nextNextLayerUserInfo objectAtIndex:0];

    NSDictionary *singleGameDetails;
    NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    
    [self resetFixturesMidlands];
    
    if(userinfo != nil){
        for( i = 0; i < [finalLayerUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [finalLayerUserInfo objectAtIndex:i];
            
            FixturesMidlands * newFixturesMidlands = [[FixturesMidlands alloc] init];
            
            user1 = [singleGameDetails objectForKey:@"home"];
            NSString *strWithDataHome = [FixturesMidlands checkDataLocation:user1];
            newFixturesMidlands.homeTeam = strWithDataHome;
            
            user1 = [singleGameDetails objectForKey:@"away"];
            NSString *strWithDataAway = [FixturesMidlands checkDataLocation:user1];
            newFixturesMidlands.awayTeam = strWithDataAway;
            
            user1 = [singleGameDetails objectForKey:@"time"];
            NSString *strWithDataDate = [FixturesMidlands checkDataLocation:user1];
            newFixturesMidlands.timeDate = strWithDataDate;
            
            user1 = [singleGameDetails objectForKey:@"venue"];
            NSString *strWithDataVenue = [FixturesMidlands checkDataLocation:user1];
            newFixturesMidlands.venue = strWithDataVenue;
            
            newFixturesMidlands.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            //format date to check its in future
            NSDateFormatter *dateFormatFixture=[[NSDateFormatter alloc]init];
            
            //[dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
            [dateFormatFixture setDateFormat:@"dd-MM-yy HH:mm"];
            [dateFormatFixture setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            
            //[dateFormatFixture setDateFormat:@"K:mm a"];
            
            NSDate *fixtureDate = [[NSDate alloc] init];
            fixtureDate = [dateFormatFixture dateFromString:newFixturesMidlands.timeDate];
            
            Location *obj = [[Location alloc] init];
            BOOL dateCheck = [obj compareDates:fixtureDate];
            
            //if date is in future, add fixture
            if(dateCheck){
                
                [FixturesMidlands addFixturesMidlands:newFixturesMidlands];
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
