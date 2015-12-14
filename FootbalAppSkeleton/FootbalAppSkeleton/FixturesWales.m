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
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/3sxh1q4s?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/3sxh1q4s?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
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
    
    [self resetFixturesWales];
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            FixturesWales * newFixturesWales
            = [[FixturesWales alloc] init];
            
            user1 = [singleGameDetails objectForKey:@"Home Team"];
            newFixturesWales.homeTeam = [user1 valueForKey:@"text"];
            
            user1 = [singleGameDetails objectForKey:@"Away Team"];
            if ([user1 isKindOfClass:[NSDictionary class]]){
                newFixturesWales.awayTeam = [user1 valueForKey:@"text"];
                
            }
            else{
                newFixturesWales.awayTeam = [singleGameDetails objectForKey:@"Away Team"];
            }
            
            
            newFixturesWales.timeDate = [singleGameDetails objectForKey:@"Time"];
            //newFixturesWales.timeDate = user1;
            //[user1 valueForKey:@"Time"];
            
            newFixturesWales.dateOnly = [singleGameDetails objectForKey:@"Date"];
            
            newFixturesWales.venue = [singleGameDetails objectForKey:@"Venue"];
            
            newFixturesWales.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            NSString *mergeDateTime = [NSString stringWithFormat:@"%@ %@",newFixturesWales.dateOnly, newFixturesWales.timeDate];
            
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

@end
