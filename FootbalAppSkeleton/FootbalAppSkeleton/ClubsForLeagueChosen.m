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
        [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/efz8zipu?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *responseCode = nil;
        
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/efz8zipu?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
            return nil;
        }
        
        return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    }
    
    if ([leagueForClubChosenPassed isEqualToString:(@"WPL: Northern Division")]){
        [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/c7f7jcui?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *responseCode = nil;
        
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/c7f7jcui?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
            return nil;
        }
        
        return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    }
    
    if ([leagueForClubChosenPassed isEqualToString:(@"WPL: Southern Division")]){
        [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/ass5svic?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *responseCode = nil;
        
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/ass5svic?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
            return nil;
        }
        
        return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    }
    if ([leagueForClubChosenPassed isEqualToString:(@"Welsh Premier League")]){
        [request setURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/dobbj9ik?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A"]];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *responseCode = nil;
        
        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
        if([responseCode statusCode] != 200){
            NSLog(@"Error getting %@, HTTP status code %li", @"www.kimonolabs.com/api/dobbj9ik?apikey=Zj1H9tsMUShsxu92JbWjbkhoaRIBxa4A", (long)[responseCode statusCode]);
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
    NSDictionary *user1;
    NSInteger i = 0;
    NSString *skey;
    
    [self resetClubsForLeagueChosen];
    
    if(userinfo != nil){
        for( i = 0; i < [detailedUserInfo count]; i++ ) {
            
            skey = [NSString stringWithFormat:@"%ld",(long)i];
            
            singleGameDetails = [detailedUserInfo objectAtIndex:i];
            
            ClubsForLeagueChosen * newClubsForLeagueChosen = [[ClubsForLeagueChosen alloc] init];
            
            if (([leagueForClubChosenPassed isEqualToString:(@"WSL1")]) || ([leagueForClubChosenPassed isEqualToString:(@"WSL2")])){
                newClubsForLeagueChosen.team = [singleGameDetails objectForKey:@"Teams"];
                
            }
            
            //have to format data differently for these leagues
            if (([leagueForClubChosenPassed isEqualToString:(@"WPL: Northern Division")]) || ([leagueForClubChosenPassed isEqualToString:(@"WPL: Southern Division")]) || ([leagueForClubChosenPassed isEqualToString:(@"Welsh Premier League")])){
                
                user1 = [singleGameDetails objectForKey:@"Teams"];
                newClubsForLeagueChosen.team = [user1 valueForKey:@"text"];
                
                //take out rank that comes with team name in welsh premier league
                if([leagueForClubChosenPassed isEqualToString:@"Welsh Premier League"]){
                    NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"#0;#1;#2;#3;#4;#5;#6;#7;#8;#9;."];
                    NSString *result = [[newClubsForLeagueChosen.team componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
                
                    newClubsForLeagueChosen.team = result;
                    
                }
                
            }
            
            
            newClubsForLeagueChosen.index = [NSString stringWithFormat:@"%ld", (long)i];
            
            [ClubsForLeagueChosen addClubsForLeagueChosen:newClubsForLeagueChosen];
        }
    }
    else{
        NSLog(@"no data found in json results");
    }
}

@end
