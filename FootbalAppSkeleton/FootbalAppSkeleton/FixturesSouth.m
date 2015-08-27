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

+(void)addFixturesSouth: (FixturesSouth *)objectToAdd{

    [allFixturesSouth addObject:objectToAdd];
}

+(NSMutableArray *)getAllFixturesSouth{
    return allFixturesSouth;
}
+(void)resetFixturesSouth{
    allFixturesSouth = [[NSMutableArray alloc] init];
}

+ (NSString *) getDataFromSouth{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/55cwfs0frq?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        FixturesTableViewController *objData = [[FixturesTableViewController alloc] init];
         [objData dataUnreachable];
        NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/cwfs0frq?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
        //MatchFinderViewController *obj = [[MatchFinderViewController alloc] init];
        //[obj noInternetAlertView];
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

+ (void) formatData: (NSString*) returnedDataSouth{
    NSError *error =  nil;

    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataSouth dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        
        NSDictionary *userinfo=[json valueForKey:@"results"];
        NSArray *detailedUserInfo = [userinfo valueForKey:@"collection1"];
        NSDictionary *singleGameDetails;
        NSDictionary *user1;
        NSInteger i = 0;
        NSString *skey;
        
        [self resetFixturesSouth];
        
        if(userinfo != nil){
            for( i = 0; i < [detailedUserInfo count]; i++ ) {
                
                skey = [NSString stringWithFormat:@"%ld",(long)i];
                
                singleGameDetails = [detailedUserInfo objectAtIndex:i];
                
                FixturesSouth * newFixturesSouth = [[FixturesSouth alloc] init];
                
                user1 = [singleGameDetails objectForKey:@"Home Team"];
                newFixturesSouth.homeTeam = [user1 valueForKey:@"text"];
                
                user1 = [singleGameDetails objectForKey:@"Away Team"];
                newFixturesSouth.awayTeam = [user1 valueForKey:@"text"];
                
                user1 = [singleGameDetails objectForKey:@"Date/Time"];
                newFixturesSouth.timeDate = [user1 valueForKey:@"text"];
                
                user1 = [singleGameDetails objectForKey:@"Venue"];
                newFixturesSouth.venue = [user1 valueForKey:@"text"];
                
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

@end
