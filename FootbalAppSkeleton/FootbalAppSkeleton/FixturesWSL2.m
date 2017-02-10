//
//  FixturesWSL2.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 10/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixturesWSL2.h"

@implementation FixturesWSL2

static NSMutableArray *allFixturesWSL2;

+(void)addFixturesWSL2: (FixturesWSL2 *)objectToAdd{
    [allFixturesWSL2 addObject:objectToAdd];
}

+(NSMutableArray *)getAllFixturesWSL2{
    return allFixturesWSL2;
}

+(void)resetFixturesWSL2{
    allFixturesWSL2 = [[NSMutableArray alloc] init];
}

+ (NSString *) getDataFromWSL2{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://data.import.io/extractor/ecc3a0e0-7726-49e4-b995-c09cb83b64ad/json/latest?_apikey=b8d1c620bb0f45829c91f9bdd88e104d8a221fc188b9bcaa1e6c6dea97764aa5eccacf8beea0c56608f514597cbbb97a51107c5a2058f7b85ea0d997ea70f853045cb071338cb6ed77dfc7ed551354d4"]];
    
    //get raw data from url
    NSData *theData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:nil
                                                        error:nil];
    
    //return newJSON;
    return [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
}
+ (void) formatData: (NSString*) returnedDataWSL2{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataWSL2 dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"result"];
    NSDictionary *detailedUserInfo = [userinfo valueForKey:@"extractorData"];
    NSArray *nextLayerUserInfo = [detailedUserInfo valueForKey:@"data"];
    NSArray *nextNextLayerUserInfo = [nextLayerUserInfo valueForKey:@"group"];
    NSArray *finalLayerUserInfo = [nextNextLayerUserInfo objectAtIndex:0];
    NSDictionary *singleGameDetails;
    //  NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    BOOL correctLeague = false;
    
    [self resetFixturesWSL2];
    
    if(userinfo != nil){
        for( i = 0; i < [finalLayerUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [finalLayerUserInfo objectAtIndex:i];
            
            FixturesWSL2 * newFixturesWSL2
            = [[FixturesWSL2 alloc] init];
            NSArray *textUnwrapper;
            NSArray *finalTextUnwrapper;
            NSString *currentLeague;
            static NSString *currentDate;
            
            textUnwrapper = [singleGameDetails valueForKey:@"league"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
            currentLeague = [finalTextUnwrapper valueForKey:@"text"];
            
            if([currentLeague isEqual: @"FA WSL 1"]){
                correctLeague = false;
            }
            
            //only search through columns with this league
            if([currentLeague  isEqual: @"FA WSL 2"] || (currentLeague == nil && correctLeague)){
                
                correctLeague = true;
                
                textUnwrapper = [singleGameDetails valueForKey:@"home"];
                finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
                newFixturesWSL2.homeTeam = [finalTextUnwrapper valueForKey:@"text"];
                
                textUnwrapper = [singleGameDetails valueForKey:@"away"];
                finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
                newFixturesWSL2.awayTeam = [finalTextUnwrapper valueForKey:@"text"];
                
                textUnwrapper = [singleGameDetails valueForKey:@"time"];
                finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
                newFixturesWSL2.timeDate = [finalTextUnwrapper valueForKey:@"text"];
                
                textUnwrapper = [singleGameDetails valueForKey:@"date"];
                finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
                
                if([finalTextUnwrapper valueForKey:@"text"] == nil){
                    newFixturesWSL2.dateOnly = currentDate;
                }
                else{
                    newFixturesWSL2.dateOnly = [finalTextUnwrapper valueForKey:@"text"];
                    currentDate = [finalTextUnwrapper valueForKey:@"text"];
                }
                
                
                textUnwrapper = [singleGameDetails valueForKey:@"venue"];
                finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
                newFixturesWSL2.venue = [finalTextUnwrapper valueForKey:@"text"];
                
                newFixturesWSL2.index = [NSString stringWithFormat:@"%ld", (long)i];
                
                NSString *mergeDateTime = [NSString stringWithFormat:@"%@ %@",newFixturesWSL2.dateOnly, newFixturesWSL2.timeDate];
                
                newFixturesWSL2.timeDate = mergeDateTime;
                
                //format date to check its in future
                NSDateFormatter *dateFormatFixture=[[NSDateFormatter alloc]init];
                
                //[dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
                [dateFormatFixture setDateFormat:@"EEEE d MMMM yyyy H:m"];
                [dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"]];
                [dateFormatFixture setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
                
                //[dateFormatFixture setDateFormat:@"K:mm a"];
                
                NSDate *fixtureDate = [[NSDate alloc] init];
                fixtureDate = [dateFormatFixture dateFromString:newFixturesWSL2.timeDate];
                
                Location *obj = [[Location alloc] init];
                BOOL dateCheck = [obj compareDatesWSL:fixtureDate];
                
                //if date is in future, add fixture
                if(dateCheck){
                    
                    [FixturesWSL2 addFixturesWSL2:newFixturesWSL2];
                }


            }
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}

@end
