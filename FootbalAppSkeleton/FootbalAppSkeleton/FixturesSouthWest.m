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
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/d4946mkm?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/cwfs0frq?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

+ (void) formatData: (NSString*) returnedDataSouthWest{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataSouthWest dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"results"];
    NSArray *detailedUserInfo = [userinfo valueForKey:@"collection1"];
    NSDictionary *singleGameDetails;
    NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    
    [self resetFixturesSouthWest];
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            FixturesSouthWest * newFixturesSouthWest = [[FixturesSouthWest alloc] init];
            
            user1 = [singleGameDetails objectForKey:@"Home Team"];
            NSString *strWithDataHome = [FixturesSouthWest checkDataLocation:user1];
            newFixturesSouthWest.homeTeam = strWithDataHome;
            
            user1 = [singleGameDetails objectForKey:@"Away Team"];
            NSString *strWithDataAway = [FixturesSouthWest checkDataLocation:user1];
            newFixturesSouthWest.awayTeam = strWithDataAway;
            
            user1 = [singleGameDetails objectForKey:@"Date/Time"];
            NSString *strWithDataDate = [FixturesSouthWest checkDataLocation:user1];
            newFixturesSouthWest.timeDate = strWithDataDate;
            
            user1 = [singleGameDetails objectForKey:@"Venue"];
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
