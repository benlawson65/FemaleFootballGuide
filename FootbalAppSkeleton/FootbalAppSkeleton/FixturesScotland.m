//
//  FixturesScotland.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 16/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixturesScotland.h"

@implementation FixturesScotland

static NSMutableArray *allFixturesScotland;

+(void)addFixturesScotland: (FixturesScotland *)objectToAdd{
    [allFixturesScotland addObject:objectToAdd];
}

+(NSMutableArray *)getAllFixturesScotland{
    return allFixturesScotland;
}

+(void)resetFixturesScotland{
    allFixturesScotland = [[NSMutableArray alloc] init];
}


+ (NSString *) getDataFromScotland{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://data.import.io/extractor/0088f388-5dbb-4bf1-8f99-103e76b14d63/json/latest?_apikey=b8d1c620bb0f45829c91f9bdd88e104d8a221fc188b9bcaa1e6c6dea97764aa5eccacf8beea0c56608f514597cbbb97a51107c5a2058f7b85ea0d997ea70f853045cb071338cb6ed77dfc7ed551354d4"]];
    
    //get raw data from url
    NSData *theData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:nil
                                                        error:nil];
    
    //return newJSON;
    return [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];

}

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
    NSUInteger dateAndVenueTracker = 0;
    
    [self resetFixturesScotland];
    
    
    if(userinfo != nil){
        for( i = 0; i < [finalLayerUserInfo count]; i++ ) {
            
            NSArray *textUnwrapper;
            NSArray *finalTextUnwrapper;
            NSString *dateAndVenueText;
            NSString *dateOnly = @"";
            NSString *venueOnly = @"";
            NSString *charInStringFormat;
            BOOL dateFound = false;
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [finalLayerUserInfo objectAtIndex:i];
            
            textUnwrapper = [singleGameDetails valueForKey:@"date and venue"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:dateAndVenueTracker];
            dateAndVenueText = [finalTextUnwrapper valueForKey:@"text"];
            
            for(NSUInteger k = (dateAndVenueText.length - 1); k > 0; k--){
                
                //search in reverse through string for date
                if([dateAndVenueText characterAtIndex:k] >='0' && [dateAndVenueText characterAtIndex:k] <='9'){
                    dateFound = true;
                }
                
                //if iterating through the date part of string put it in its own string char by char
                if(dateFound){
                    
                    //format char to string
                    charInStringFormat = [NSString stringWithFormat: @"%C", [dateAndVenueText characterAtIndex:k]];
                    
                    //add charString to date only string
                    dateOnly = [dateOnly stringByAppendingString:charInStringFormat];

                }
                else if (!dateFound){
                    //format char to string
                    charInStringFormat = [NSString stringWithFormat: @"%C", [dateAndVenueText characterAtIndex:k]];
                    
                    //add charString to date only string
                    venueOnly = [venueOnly stringByAppendingString:charInStringFormat];
                }
            }
            
            //FIX PROBLEM OF DATE AND VENUE STRINGS BEING IN REVERSE ORDER
            
            FixturesScotland * newFixturesScotland = [[FixturesScotland alloc] init];
            
            
            textUnwrapper = [singleGameDetails valueForKey:@"home"];
            finalTextUnwrapper = [textUnwrapper objectAtIndex:0];
            newFixturesScotland.homeTeam = [finalTextUnwrapper valueForKey:@"text"];
            
            newFixturesScotland.awayTeam = [singleGameDetails objectForKey:@"Away Team"];
            
            textUnwrapper = [singleGameDetails valueForKey:@"date and venue"];
            for(int j = 0; j < [textUnwrapper count]; j++){
            
            }
            
            
            newFixturesScotland.dateOnly = [singleGameDetails objectForKey:@"Day"];
            
            newFixturesScotland.venue = [singleGameDetails objectForKey:@"Venue"];
            
            newFixturesScotland.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            
            if(![newFixturesScotland.timeDate isEqualToString:@""]){
                NSString *mergeDateTime = [NSString stringWithFormat:@"%@ %@",newFixturesScotland.dateOnly, newFixturesScotland.timeDate];
                
                newFixturesScotland.timeDate = mergeDateTime;
                [FixturesScotland addFixturesScotland:newFixturesScotland];
            }
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}



@end
