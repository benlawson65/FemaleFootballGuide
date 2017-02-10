//
//  FixturesWales.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 31/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixturesWales.h"

@implementation FixturesWales

static NSMutableArray *allFixturesWales;

+(void)addFixturesWales: (FixturesWales *)objectToAdd{

    [allFixturesWales addObject:objectToAdd];
}

+(NSMutableArray *)getAllFixturesWales{
    return allFixturesWales;
}

+(void)resetFixturesWales{
    allFixturesWales = [[NSMutableArray alloc] init];
}

+ (NSString *) getDataFromWales{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://data.import.io/extractor/1c8f1bd4-36c6-4405-ae10-3094000776fd/json/latest?_apikey=b8d1c620bb0f45829c91f9bdd88e104d8a221fc188b9bcaa1e6c6dea97764aa5eccacf8beea0c56608f514597cbbb97a51107c5a2058f7b85ea0d997ea70f853045cb071338cb6ed77dfc7ed551354d4"]];
    
    //get raw data from url
    NSData *theData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:nil
                                                        error:nil];
    
    //return newJSON;
    return [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
}
+ (void) formatData: (NSString*) returnedDataWales{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataWales dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"result"];
    NSDictionary *detailedUserInfo = [userinfo valueForKey:@"extractorData"];
    NSArray *nextLayerUserInfo = [detailedUserInfo valueForKey:@"data"];
    NSArray *nextNextLayerUserInfo = [nextLayerUserInfo valueForKey:@"group"];
    NSArray *finalLayerUserInfo = [nextNextLayerUserInfo objectAtIndex:0];

    NSDictionary *singleGameDetails;
    NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    
    [self resetFixturesWales];
    
    if(userinfo != nil){
        for( i = 0; i < [finalLayerUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [finalLayerUserInfo objectAtIndex:i];
            
            FixturesWales * newFixturesWales
            = [[FixturesWales alloc] init];
           
            user1 = [singleGameDetails objectForKey:@"home"];
            NSString *strWithDataHome = [FixturesWales checkDataLocation:user1];
            newFixturesWales.homeTeam = strWithDataHome;
            
            user1 = [singleGameDetails objectForKey:@"away"];
            NSString *strWithDataAway = [FixturesWales checkDataLocation:user1];
            newFixturesWales.awayTeam = strWithDataAway;
            
            user1 = [singleGameDetails objectForKey:@"date"];
            NSString *strWithDataTime = [FixturesWales checkDataLocation:user1];
            newFixturesWales.timeDate = strWithDataTime;
            
            newFixturesWales.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            NSString *mergeDateTime = [NSString stringWithFormat:@"%@ %@",newFixturesWales.timeDate, @"14:00"];
            
            newFixturesWales.timeDate = mergeDateTime;

            
            //format date to check its in future
            NSDateFormatter *dateFormatFixture=[[NSDateFormatter alloc]init];
            
            //[dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
            [dateFormatFixture setDateFormat:@"EEE d MMM yy H:m"];
            [dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"]];
            [dateFormatFixture setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            
            //[dateFormatFixture setDateFormat:@"K:mm a"];
            
            NSDate *fixtureDate = [[NSDate alloc] init];
            fixtureDate = [dateFormatFixture dateFromString:newFixturesWales.timeDate];
            
            BOOL dateCheck = [self compareDates:fixtureDate];
            
            //if date is in future, add fixture
            if(dateCheck){
                
                [FixturesWales addFixturesWales:newFixturesWales];
            }
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}

+(BOOL)compareDates:(NSDate *)fixtureDate{
    //get date and time
    
    NSDate *realDate = [[NSDate alloc] init];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat:@"EEE d MMM yy HH:mm"];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"]];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSString *dateString = [dateFormat stringFromDate:realDate];
    realDate = [dateFormat dateFromString:dateString];
    
    if([realDate compare:fixtureDate] == NSOrderedAscending){
        return true;
    }
    else {
        return false;
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
