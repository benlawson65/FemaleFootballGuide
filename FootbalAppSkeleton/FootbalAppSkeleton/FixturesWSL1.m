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
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/2gjq99ou?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/2gjq99ou?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}
+ (void) formatData: (NSString*) returnedDataWSL1{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataWSL1 dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"results"];
    NSArray *detailedUserInfo = [userinfo valueForKey:@"collection1"];
    NSDictionary *singleGameDetails;
  //  NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    NSString *previousDate;
    
    [self resetFixturesWSL1];
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            FixturesWSL1 * newFixturesWSL1
            = [[FixturesWSL1 alloc] init];
            
            newFixturesWSL1.homeTeam = [singleGameDetails objectForKey:@"HomeTeam"];
            
            newFixturesWSL1.awayTeam = [singleGameDetails objectForKey:@"awayTeam"];
            
            newFixturesWSL1.timeDate = [singleGameDetails objectForKey:@"Time"];
            
            newFixturesWSL1.dateOnly = [singleGameDetails objectForKey:@"Date"];
            
            if (![newFixturesWSL1.dateOnly isEqualToString:(nil)]){
                previousDate = newFixturesWSL1.dateOnly;
            }
            
            if ([newFixturesWSL1.dateOnly isEqualToString:(nil)]){
                newFixturesWSL1.dateOnly = previousDate;
            }
            
            newFixturesWSL1.venue = [singleGameDetails objectForKey:@"Venue"];
            
            newFixturesWSL1.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            NSString *mergeDateTime = [NSString stringWithFormat:@"%@, %@",newFixturesWSL1.dateOnly, newFixturesWSL1.timeDate];
            
            newFixturesWSL1.timeDate = mergeDateTime;
            
            [FixturesWSL1 addFixturesWSL1:newFixturesWSL1];
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}


@end
