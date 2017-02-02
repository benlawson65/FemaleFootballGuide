//
//  FixturesSouth.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 29/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixturesSouth.h"
#import "MatchFinderViewController.h"
#import "FixturesTableViewController.h"

@implementation FixturesSouth

static NSMutableArray *allFixturesSouth;
static NSString *statusCodeString;

+(void)addFixturesSouth: (FixturesSouth *)objectToAdd{

    [allFixturesSouth addObject:objectToAdd];
}

+(NSMutableArray *)getAllFixturesSouth{
    return allFixturesSouth;
}
+(void)resetFixturesSouth{
    allFixturesSouth = [[NSMutableArray alloc] init];
}
+(NSString*)getStatusCodeString{
    return statusCodeString;
}

+ (NSString *) getDataFromSouth{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://data.import.io/extractor/aafc4bbe-dde8-48d3-843d-388176f42724/json/latest?_apikey=b8d1c620bb0f45829c91f9bdd88e104d8a221fc188b9bcaa1e6c6dea97764aa5eccacf8beea0c56608f514597cbbb97a51107c5a2058f7b85ea0d997ea70f853045cb071338cb6ed77dfc7ed551354d4"]];

    //get raw data from url
    NSData *theData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:nil
                                                        error:nil];
    
    //return newJSON;
    return [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
}

+ (void) formatData: (NSString*) returnedDataSouth{
    NSError *error =  nil;

    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataSouth dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
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
        
        [self resetFixturesSouth];
        
        if(userinfo != nil){
            for( i = 0; i < [finalLayerUserInfo count]; i++ ) {
                
                skey = [NSString stringWithFormat:@"%ld",(long)i];
                
                singleGameDetails = [finalLayerUserInfo objectAtIndex:i];
                
                FixturesSouth * newFixturesSouth = [[FixturesSouth alloc] init];
                
                user1 = [singleGameDetails objectForKey:@"Home"];
                //text = [singleGameDetails obj]
                NSString *strWithDataHome = [FixturesSouth checkDataLocation:user1];
                newFixturesSouth.homeTeam = strWithDataHome;
                
                user1 = [singleGameDetails objectForKey:@"Away"];
                NSString *strWithDataAway = [FixturesSouth checkDataLocation:user1];
                newFixturesSouth.awayTeam = strWithDataAway;
                
                user1 = [singleGameDetails objectForKey:@"Date"];
                NSString *strWithDataDate = [FixturesSouth checkDataLocation:user1];
                newFixturesSouth.timeDate = strWithDataDate;
                
                user1 = [singleGameDetails objectForKey:@"Venue"];
                NSString *strWithDataVenue = [FixturesSouth checkDataLocation:user1];
                newFixturesSouth.venue = strWithDataVenue;
                
                newFixturesSouth.index = [NSString stringWithFormat:@"%ld", (long)i];
                
                //format date to check its in future
                NSDateFormatter *dateFormatFixture=[[NSDateFormatter alloc]init];
                
                //[dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
                [dateFormatFixture setDateFormat:@"dd-MM-yy HH:mm"];
                [dateFormatFixture setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
                
                //[dateFormatFixture setDateFormat:@"K:mm a"];
                
                NSDate *fixtureDate = [[NSDate alloc] init];
                fixtureDate = [dateFormatFixture dateFromString:newFixturesSouth.timeDate];
                
                Location *obj = [[Location alloc] init];
                BOOL dateCheck = [obj compareDates:fixtureDate];
                
                //if date is in future, add fixture
                if(dateCheck){
                    
                    [FixturesSouth addFixturesSouth:newFixturesSouth];
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
