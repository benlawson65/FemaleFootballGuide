//
//  FixturesSouthEast.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 24/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixturesSouthEast.h"

@implementation FixturesSouthEast
static NSMutableArray *allFixturesSouthEast;

+(void)addFixturesSouthEast: (FixturesSouthEast *)objectToAdd{
    
    [allFixturesSouthEast addObject:objectToAdd];
}

+(NSMutableArray *)getAllFixturesSouthEast{
    return allFixturesSouthEast;
}
+(void)resetFixturesSouthEast{
    allFixturesSouthEast = [[NSMutableArray alloc] init];
}

+ (NSString *) getDataFromSouthEast{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/8ch3kjwo?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/8ch3kjwo?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

+ (void) formatData: (NSString*) returnedDataSouthEast{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataSouthEast dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"results"];
    NSArray *detailedUserInfo = [userinfo valueForKey:@"collection1"];
    NSDictionary *singleGameDetails;
    NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    
    [self resetFixturesSouthEast];
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            FixturesSouthEast * newFixturesSouthEast = [[FixturesSouthEast alloc] init];
            
            user1 = [singleGameDetails objectForKey:@"Home Team"];
            NSString *strWithDataHome = [FixturesSouthEast checkDataLocation:user1];
            newFixturesSouthEast.homeTeam = strWithDataHome;
            
            user1 = [singleGameDetails objectForKey:@"Away Team"];
            NSString *strWithDataAway = [FixturesSouthEast checkDataLocation:user1];
            newFixturesSouthEast.awayTeam = strWithDataAway;
            
            user1 = [singleGameDetails objectForKey:@"Date/Time"];
            NSString *strWithDataDate = [FixturesSouthEast checkDataLocation:user1];
            newFixturesSouthEast.timeDate = strWithDataDate;
            
            user1 = [singleGameDetails objectForKey:@"Venue"];
            NSString *strWithDataVenue = [FixturesSouthEast checkDataLocation:user1];
            newFixturesSouthEast.venue = strWithDataVenue;
            
            newFixturesSouthEast.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            //format date to check its in future
            NSDateFormatter *dateFormatFixture=[[NSDateFormatter alloc]init];
            
            //[dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
            [dateFormatFixture setDateFormat:@"dd-MM-yy HH:mm"];
            [dateFormatFixture setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            
            //[dateFormatFixture setDateFormat:@"K:mm a"];
            
            NSDate *fixtureDate = [[NSDate alloc] init];
            fixtureDate = [dateFormatFixture dateFromString:newFixturesSouthEast.timeDate];
            
            Location *obj = [[Location alloc] init];
            BOOL dateCheck = [obj compareDates:fixtureDate];
            
            //if date is in future, add fixture
            if(dateCheck){
                
                [FixturesSouthEast addFixturesSouthEast:newFixturesSouthEast];
            }
            
            
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}

+ (NSString *) checkDataLocation: (NSDictionary*) dictionaryContainingData{
    NSString *strContainingWantedData;
    
    //user1 = [singleGameDetails objectForKey:@"Home Team"];
    if ([dictionaryContainingData isKindOfClass:[NSDictionary class]]){
        strContainingWantedData = [dictionaryContainingData valueForKey:@"text"];
        
    }
    else{
        strContainingWantedData = [NSString stringWithFormat:@"%@", dictionaryContainingData];
    }
    
    return strContainingWantedData;
}


@end
