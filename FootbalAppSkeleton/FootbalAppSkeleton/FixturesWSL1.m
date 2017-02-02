//
//  FixturesWSL1.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 04/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixturesWSL1.h"

@implementation FixturesWSL1

static NSMutableArray *allFixturesWSL1;

+(void)addFixturesWSL1: (FixturesWSL1 *)objectToAdd{
    [allFixturesWSL1 addObject:objectToAdd];
}

+(NSMutableArray *)getAllFixturesWSL1{
    return allFixturesWSL1;
}

+(void)resetFixturesWSL1{
    allFixturesWSL1 = [[NSMutableArray alloc] init];
}

+ (NSString *) getDataFromWSL1{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://data.import.io/extractor/ecc3a0e0-7726-49e4-b995-c09cb83b64ad/json/latest?_apikey=b8d1c620bb0f45829c91f9bdd88e104d8a221fc188b9bcaa1e6c6dea97764aa5eccacf8beea0c56608f514597cbbb97a51107c5a2058f7b85ea0d997ea70f853045cb071338cb6ed77dfc7ed551354d4"]];
    
    //get raw data from url
    NSData *theData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:nil
                                                        error:nil];
    
    //return newJSON;
    return [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
}
+ (void) formatData: (NSString*) returnedDataWSL1{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataWSL1 dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    //unwrap data stored in json file
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
    
    [self resetFixturesWSL1];
    
    if(userinfo != nil){
        for( i = 0; i < [finalLayerUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [finalLayerUserInfo objectAtIndex:i];
            
            FixturesWSL1 * newFixturesWSL1
            = [[FixturesWSL1 alloc] init];
            NSArray *textUnwrapper;
            NSArray *finalTextUnwrapper;
            NSString *currentLeague;
            static NSString *currentDate;
            
            textUnwrapper = [singleGameDetails valueForKey:@"league"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
            currentLeague = [finalTextUnwrapper valueForKey:@"text"];
            
            if([currentLeague isEqual: @"FA WSL 2"]){
                correctLeague = false;
            }
            
            //only search through columns with this league
            if([currentLeague  isEqual: @"FA WSL 1"] || (currentLeague == nil && correctLeague)){
                
                correctLeague = true;
            
                textUnwrapper = [singleGameDetails valueForKey:@"home"];
                finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
                newFixturesWSL1.homeTeam = [finalTextUnwrapper valueForKey:@"text"];
                
                textUnwrapper = [singleGameDetails valueForKey:@"away"];
                finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
                newFixturesWSL1.awayTeam = [finalTextUnwrapper valueForKey:@"text"];
                
                textUnwrapper = [singleGameDetails valueForKey:@"time"];
                finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
                newFixturesWSL1.timeDate = [finalTextUnwrapper valueForKey:@"text"];
                
                textUnwrapper = [singleGameDetails valueForKey:@"date"];
                finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
                
                if([finalTextUnwrapper valueForKey:@"text"] == nil){
                    newFixturesWSL1.dateOnly = currentDate;
                }
                else{
                    newFixturesWSL1.dateOnly = [finalTextUnwrapper valueForKey:@"text"];
                    currentDate = [finalTextUnwrapper valueForKey:@"text"];
                }
                
                
                textUnwrapper = [singleGameDetails valueForKey:@"venue"];
                finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
                newFixturesWSL1.venue = [finalTextUnwrapper valueForKey:@"text"];
                
                newFixturesWSL1.index = [NSString stringWithFormat:@"%ld", (long)i];
                
                NSString *mergeDateTime = [NSString stringWithFormat:@"%@ %@",newFixturesWSL1.timeDate, newFixturesWSL1.dateOnly];
                
                newFixturesWSL1.timeDate = mergeDateTime;
            
                //format fixture date in same way current date will be formatted
                NSDateFormatter *dateFormatFixture=[[NSDateFormatter alloc]init];
                
                //[dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
                [dateFormatFixture setDateFormat:@"H:m EEEE d MMMM yyyy"];
                [dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"]];
                //[dateFormatFixture setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
                
                //[dateFormatFixture setDateFormat:@"K:mm a"];
                
                NSDate *fixtureDate = [[NSDate alloc] init];
                fixtureDate = [dateFormatFixture dateFromString:newFixturesWSL1.timeDate];
                
                //get and compare current date
                Location *obj = [[Location alloc] init];
                BOOL dateCheck = [obj compareDatesWSL:fixtureDate];
                
                //if date is in future, add fixture
                if(dateCheck){
                    
                    [FixturesWSL1 addFixturesWSL1:newFixturesWSL1];
                }

            }
            
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}


@end
