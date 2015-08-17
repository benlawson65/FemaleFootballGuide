//
//  FixturesScotland.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 16/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixturesScotland.h"

@implementation FixturesScotland

static NSMutableArray *allFixturesScotland;

+(void)addFixturesScotland: (FixturesScotland *)objectToAdd{
    [allFixturesScotland addObject:objectToAdd];
}

+(NSMutableArray *)getAllFixturesScotland{
    return allFixturesScotland;
}

+(void)resetFixturesScotland{
    allFixturesScotland = [[NSMutableArray alloc] init];
}


+ (NSString *) getDataFromScotland{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/b5g1stnm?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/b5g1stnm?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

+ (void) formatData: (NSString*) returnedDataScotland{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataScotland dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"results"];
    NSArray *detailedUserInfo = [userinfo valueForKey:@"collection1"];
    NSDictionary *singleGameDetails;
    NSInteger i = 0;
    NSString *skey;
    
    [self resetFixturesScotland];
    
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            FixturesScotland * newFixturesScotland = [[FixturesScotland alloc] init];
            
            newFixturesScotland.homeTeam = [singleGameDetails objectForKey:@"Home Team"];
            
            newFixturesScotland.awayTeam = [singleGameDetails objectForKey:@"Away Team"];
            
            newFixturesScotland.timeDate = [singleGameDetails objectForKey:@"Time"];
            
            newFixturesScotland.dateOnly = [singleGameDetails objectForKey:@"Day"];
            
            newFixturesScotland.venue = [singleGameDetails objectForKey:@"Venue"];
            
            newFixturesScotland.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            
            if(![newFixturesScotland.timeDate isEqualToString:@""]){
                NSString *mergeDateTime = [NSString stringWithFormat:@"%@ %@",newFixturesScotland.dateOnly, newFixturesScotland.timeDate];
                
                newFixturesScotland.timeDate = mergeDateTime;
                [FixturesScotland addFixturesScotland:newFixturesScotland];
            }
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}



@end
