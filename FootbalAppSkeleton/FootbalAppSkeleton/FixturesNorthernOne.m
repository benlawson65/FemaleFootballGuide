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
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/dda7nmno?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/cwfs0frq?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

+ (void) formatData: (NSString*) returnedDataNorthernOne{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataNorthernOne dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"results"];
    NSArray *detailedUserInfo = [userinfo valueForKey:@"collection1"];
    NSDictionary *singleGameDetails;
    NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    
    [self resetFixturesNorthernOne];
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            FixturesNorthernOne * newFixturesNorthernOne = [[FixturesNorthernOne alloc] init];
            
            user1 = [singleGameDetails objectForKey:@"Home Team"];
            NSString *strWithDataHome = [FixturesNorthernOne checkDataLocation:user1];
            newFixturesNorthernOne.homeTeam = strWithDataHome;
            
            user1 = [singleGameDetails objectForKey:@"Away Team"];
            NSString *strWithDataAway = [FixturesNorthernOne checkDataLocation:user1];
            newFixturesNorthernOne.awayTeam = strWithDataAway;
            
            user1 = [singleGameDetails objectForKey:@"Date/Time"];
            NSString *strWithDataDate = [FixturesNorthernOne checkDataLocation:user1];
            newFixturesNorthernOne.timeDate = strWithDataDate;
            
            user1 = [singleGameDetails objectForKey:@"Venue"];
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
