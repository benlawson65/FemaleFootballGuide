//
//  FixturesNorth.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 31/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixturesNorth.h"

@implementation FixturesNorth

static NSMutableArray *allFixturesNorth;

+(void)addFixturesNorth: (FixturesNorth *)objectToAdd{
    [allFixturesNorth addObject:objectToAdd];
}

+(NSMutableArray *)getAllFixturesNorth{
    return allFixturesNorth;
}

+(void)resetFixturesNorth{
    allFixturesNorth = [[NSMutableArray alloc] init];
}


+ (NSString *) getDataFromNorth{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/dg95vlpa?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/dg95vlpa?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

+ (void) formatData: (NSString*) returnedDataNorth{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataNorth dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"results"];
    NSArray *detailedUserInfo = [userinfo valueForKey:@"collection1"];
    NSDictionary *singleGameDetails;
    NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    
    [self resetFixturesNorth];
    
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            FixturesNorth * newFixturesNorth = [[FixturesNorth alloc] init];
            
            user1 = [singleGameDetails objectForKey:@"Home Team"];
            newFixturesNorth.homeTeam = [user1 valueForKey:@"text"];
            
            user1 = [singleGameDetails objectForKey:@"Away Team"];
            newFixturesNorth.awayTeam = [user1 valueForKey:@"text"];
            
            user1 = [singleGameDetails objectForKey:@"Date/Time"];
            newFixturesNorth.timeDate = [user1 valueForKey:@"text"];
            
            user1 = [singleGameDetails objectForKey:@"Venue"];
            newFixturesNorth.venue = [user1 valueForKey:@"text"];
            
            newFixturesNorth.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            //format date to check its in future
            NSDateFormatter *dateFormatFixture=[[NSDateFormatter alloc]init];
            
            //[dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
            [dateFormatFixture setDateFormat:@"dd-MM-yy HH:mm"];
            [dateFormatFixture setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            
            //[dateFormatFixture setDateFormat:@"K:mm a"];
            
            NSDate *fixtureDate = [[NSDate alloc] init];
            fixtureDate = [dateFormatFixture dateFromString:newFixturesNorth.timeDate];
            
            Location *obj = [[Location alloc] init];
            BOOL dateCheck = [obj compareDates:fixtureDate];
            
            //if date is in future, add fixture
            if(dateCheck){
                
                [FixturesNorth addFixturesNorth:newFixturesNorth];
            }
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}

@end
