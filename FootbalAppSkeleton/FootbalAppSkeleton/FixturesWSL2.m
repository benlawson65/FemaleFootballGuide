//
//  FixturesWSL2.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 10/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixturesWSL2.h"

@implementation FixturesWSL2

static NSMutableArray *allFixturesWSL2;

+(void)addFixturesWSL2: (FixturesWSL2 *)objectToAdd{
    [allFixturesWSL2 addObject:objectToAdd];
}

+(NSMutableArray *)getAllFixturesWSL2{
    return allFixturesWSL2;
}

+(void)resetFixturesWSL2{
    allFixturesWSL2 = [[NSMutableArray alloc] init];
}

+ (NSString *) getDataFromWSL2{
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setHTTPMethod:@"GET"];
    //[request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/2gjq99ou?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"WSL2fixtures" ofType:@"json"];
    
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
+ (void) formatData: (NSString*) returnedDataWSL2{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataWSL2 dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"results"];
    NSArray *detailedUserInfo = [userinfo valueForKey:@"collection1"];
    NSDictionary *singleGameDetails;
    //  NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    
    [self resetFixturesWSL2];
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            FixturesWSL2 * newFixturesWSL2
            = [[FixturesWSL2 alloc] init];
            
            newFixturesWSL2.homeTeam = [singleGameDetails objectForKey:@"Home Team"];
            
            newFixturesWSL2.awayTeam = [singleGameDetails objectForKey:@"Away Team"];
            
            newFixturesWSL2.timeDate = [singleGameDetails objectForKey:@"Time"];
            
            newFixturesWSL2.dateOnly = [singleGameDetails objectForKey:@"Date"];
            
            newFixturesWSL2.venue = [singleGameDetails objectForKey:@"Venue"];
            
            newFixturesWSL2.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            NSString *mergeDateTime = [NSString stringWithFormat:@"%@ %@",newFixturesWSL2.dateOnly, newFixturesWSL2.timeDate];
            
            newFixturesWSL2.timeDate = mergeDateTime;
            
            [FixturesWSL2 addFixturesWSL2:newFixturesWSL2];
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}

@end
