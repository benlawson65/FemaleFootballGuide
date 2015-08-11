//
//  Location.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 10/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize fixturesSouth;
@synthesize fixturesNorth;
@synthesize fixturesWales;
@synthesize fixturesWSL1;
@synthesize fixturesWSL2;
@synthesize listOfFixtures;

-(void) getAllFixtures{
    
    //retrieve data from api
    NSString *rawFixtureDataSouth =  [FixturesSouth getDataFromSouth];
    NSString *rawFixtureDataNorth = [FixturesNorth getDataFromNorth];
    NSString *rawFixtureDataWSL1 = [FixturesWSL1 getDataFromWSL1];
    NSString *rawFixtureDataWSL2 = [FixturesWSL2 getDataFromWSL2];
    NSString *rawFixtureDataWales = [FixturesWales getDataFromWales];
    
    //format raw data
    [FixturesSouth formatData:rawFixtureDataSouth];
    [FixturesNorth formatData:rawFixtureDataNorth];
    [FixturesWSL1 formatData:rawFixtureDataWSL1];
    [FixturesWSL2 formatData:rawFixtureDataWSL2];
    [FixturesWales formatData:rawFixtureDataWales];
    
    //get the actual data
    fixturesSouth  = [FixturesSouth getAllFixturesSouth];
    fixturesNorth = [FixturesNorth getAllFixturesNorth];
    fixturesWSL1 = [FixturesWSL1 getAllFixturesWSL1];
    fixturesWSL2 = [FixturesWSL2 getAllFixturesWSL2];
    fixturesWales = [FixturesWales getAllFixturesWales];
    
}
    
-(NSMutableArray*) cycleThroughFixtures{
    
    NSInteger i = 0;
    for (i = 0; i < [fixturesSouth count]; i++){
        FixturesSouth *currentFixture = [fixturesSouth objectAtIndex:i];
        
        NSDateFormatter *dateFormatFixture=[[NSDateFormatter alloc]init];
        
        //[dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
        [dateFormatFixture setDateFormat:@"dd-MM-yy HH:mm"];
        [dateFormatFixture setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        
        //[dateFormatFixture setDateFormat:@"K:mm a"];
        
        NSDate *fixtureDate = [[NSDate alloc] init];
        fixtureDate = [dateFormatFixture dateFromString:currentFixture.timeDate];
        
        //check fixture is in the future
        BOOL showFixture = [self compareDates:fixtureDate];
        
        //if in future, find coordinates and and return data to match finder
        if(showFixture){
            
            //send fixture data to matchfinder
            NSString *title = [NSString stringWithFormat:@"%@, VS, %@ (%@)",currentFixture.homeTeam,currentFixture.awayTeam,currentFixture.timeDate];
            
            NSMutableArray *sendFixtureData = [[NSMutableArray alloc] init];
            [sendFixtureData addObject:currentFixture.venue];
            [sendFixtureData addObject:title];
            
            return sendFixtureData;
        }
        
        else {return nil;}
    }
    return nil;
}

-(BOOL)compareDates:(NSDate *)fixtureDate{
    //get date and time
    
    NSDate *realDate = [[NSDate alloc] init];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat:@"dd-MM-yy HH:mm"];
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

//get location on google maps from fixture
+(CLLocationCoordinate2D) getLocationFromAddressString: (NSString*) addressStr {
    double latitude = 0, longitude = 0;
    addressStr = @"Select Security Stadium";
    //encode address
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    return center;
    
}
@end
