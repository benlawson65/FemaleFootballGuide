//
//  ClubsForLeagueChosen.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 05/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "ClubsForLeagueChosen.h"

@implementation ClubsForLeagueChosen

static NSMutableArray *allClubsForLeagueChosen;
@synthesize leagueForClubChosenPassed;

+(void)addClubsForLeagueChosen:(ClubsForLeagueChosen *)objectToAdd{
    
    [allClubsForLeagueChosen addObject:objectToAdd];
}

+(NSMutableArray *)getAllClubsForLeagueChosen{
    return allClubsForLeagueChosen;
}
-(void)resetClubsForLeagueChosen{
    allClubsForLeagueChosen = [[NSMutableArray alloc] init];
}

-(void)setLeagueChosen:(NSString*)leagueForClubSelected{
    leagueForClubChosenPassed = leagueForClubSelected;
}
- (NSString *) getDataForLeagueChosen{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    
    //get data from api for league that was chosen
    if ([leagueForClubChosenPassed isEqualToString:(@"WSL1")]){
        [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/dcxhwi3m?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
    
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *responseCode = nil;
    
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/dcxhwi3m?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
            return nil;
    }
    
        return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    }
    
    if ([leagueForClubChosenPassed isEqualToString:(@"WSL2")]){
        [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/389xslvc?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *responseCode = nil;
        
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/389xslvc?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
            return nil;
        }
        
        return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    }
    else{return nil;}
}

- (void) formatData: (NSString*) returnedDataSouth{
    NSError *error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[returnedDataSouth dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSDictionary *userinfo=[json valueForKey:@"results"];
    NSArray *detailedUserInfo = [userinfo valueForKey:@"collection1"];
    NSDictionary *singleGameDetails;
    NSInteger i = 0;
    NSString *skey;
    
    [self resetClubsForLeagueChosen];
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            ClubsForLeagueChosen * newClubsForLeagueChosen = [[ClubsForLeagueChosen alloc] init];
            
            newClubsForLeagueChosen.team = [singleGameDetails objectForKey:@"Team"];
            
            newClubsForLeagueChosen.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            [ClubsForLeagueChosen addClubsForLeagueChosen:newClubsForLeagueChosen];
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}

@end
