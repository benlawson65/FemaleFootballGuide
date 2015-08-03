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
    if([allFixturesWales count] == 0){
        allFixturesWales = [[NSMutableArray alloc] init];
    }
    
    [allFixturesWales addObject:objectToAdd];
}

+(NSMutableArray *)getAllFixturesWales{
    return allFixturesWales;
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
    
    
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            FixturesWales * newFixturesWales
            = [[FixturesWales alloc] init];
            
            user1 = [singleGameDetails objectForKey:@"Home Team"];
            newFixturesWales.homeTeam = [user1 valueForKey:@"text"];
            
            user1 = [singleGameDetails objectForKey:@"Away Team"];
            newFixturesWales.awayTeam = [user1 valueForKey:@"text"];
            
            newFixturesWales.timeDate = [singleGameDetails objectForKey:@"Time"];
            //newFixturesWales.timeDate = user1;
            //[user1 valueForKey:@"Time"];
            
            newFixturesWales.dateOnly = [singleGameDetails objectForKey:@"Date"];
            
            newFixturesWales.venue = [singleGameDetails objectForKey:@"Venue"];
            
            newFixturesWales.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            NSString *mergeDateTime = [NSString stringWithFormat:@"%@, %@",newFixturesWales.dateOnly, newFixturesWales.timeDate];
            
            newFixturesWales.timeDate = mergeDateTime;
            
            [FixturesWales addFixturesWales:newFixturesWales];
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}

@end
