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
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setHTTPMethod:@"GET"];
    //[request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/2gjq99ou?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"WSL1fixtures" ofType:@"json"];
    
    NSError *error;
    //NSHTTPURLResponse *responseCode = nil;
    
    NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding  error:&error];
    
    if(error){
        NSLog(@"Error reading json file");
    }
    
    //NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    //if([responseCode statusCode] != 200){
     //   NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/2gjq99ou?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
     //   return nil;
   // }
    
    //return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    return fileContents;
}
+ (void) formatData: (NSString*) returnedDataWSL1{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataWSL1 dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"results"];
    NSArray *detailedUserInfo = [userinfo valueForKey:@"collection2"];
    NSDictionary *singleGameDetails;
  //  NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    
    [self resetFixturesWSL1];
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            FixturesWSL1 * newFixturesWSL1
            = [[FixturesWSL1 alloc] init];
            
            newFixturesWSL1.homeTeam = [singleGameDetails objectForKey:@"Home Team"];
            
            newFixturesWSL1.awayTeam = [singleGameDetails objectForKey:@"Away Team"];
            
            newFixturesWSL1.timeDate = [singleGameDetails objectForKey:@"Time"];
            
            newFixturesWSL1.dateOnly = [singleGameDetails objectForKey:@"Date"];
            
            newFixturesWSL1.venue = [singleGameDetails objectForKey:@"Venue"];
            
            newFixturesWSL1.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            NSString *mergeDateTime = [NSString stringWithFormat:@"%@ %@",newFixturesWSL1.timeDate, newFixturesWSL1.dateOnly];
            
            newFixturesWSL1.timeDate = mergeDateTime;
            
            //format date to check its in future
            NSDateFormatter *dateFormatFixture=[[NSDateFormatter alloc]init];
            
            //[dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
            [dateFormatFixture setDateFormat:@"EEEE d MMMM yyyy H:m"];
            [dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"]];
            [dateFormatFixture setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            
            //[dateFormatFixture setDateFormat:@"K:mm a"];
            
            NSDate *fixtureDate = [[NSDate alloc] init];
            fixtureDate = [dateFormatFixture dateFromString:newFixturesWSL1.timeDate];
            
            Location *obj = [[Location alloc] init];
            BOOL dateCheck = [obj compareDatesWSL:fixtureDate];
            
            //if date is in future, add fixture
            if(dateCheck){
                
                [FixturesWSL1 addFixturesWSL1:newFixturesWSL1];
            }
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}


@end
