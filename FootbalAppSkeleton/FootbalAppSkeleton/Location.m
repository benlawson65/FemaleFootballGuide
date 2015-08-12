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

@synthesize venue;
@synthesize snippet;
@synthesize title;

static NSMutableArray *allFixtures;

+(void)addFixtures: (Location *)objectToAdd{
    [allFixtures addObject:objectToAdd];
}

+(NSMutableArray *)returnAllFixtures{
    return allFixtures;
}

+(void)resetFixtures{
    allFixtures = [[NSMutableArray alloc] init];
}

-(void) getAllFixtures{
    
    if([fixturesSouth count] == 0){
        NSString *rawFixtureDataSouth =  [FixturesSouth getDataFromSouth];
        [FixturesSouth formatData:rawFixtureDataSouth];
        fixturesSouth  = [FixturesSouth getAllFixturesSouth];
    }
    if([fixturesNorth count] == 0){
        NSString *rawFixtureDataNorth = [FixturesNorth getDataFromNorth];
        [FixturesNorth formatData:rawFixtureDataNorth];
        fixturesNorth = [FixturesNorth getAllFixturesNorth];
    }
    if([fixturesWales count] == 0){
        
        NSString *rawFixtureDataWales = [FixturesWales getDataFromWales];
        [FixturesWales formatData:rawFixtureDataWales];
        fixturesWales = [FixturesWales getAllFixturesWales];
    
    }
    if([fixturesWSL1 count] == 0){
        
        NSString *rawFixtureDataWSL1 = [FixturesWSL1 getDataFromWSL1];
        [FixturesWSL1 formatData:rawFixtureDataWSL1];
        fixturesWSL1 = [FixturesWSL1 getAllFixturesWSL1];
    
    }
    if([fixturesWSL2 count] == 0){
        NSString *rawFixtureDataWSL2 = [FixturesWSL2 getDataFromWSL2];
        [FixturesWSL2 formatData:rawFixtureDataWSL2];
        fixturesWSL2 = [FixturesWSL2 getAllFixturesWSL2];
    }
    
}
    
-(void) cycleThroughFixtures{
    
    allFixtures = [[NSMutableArray alloc] init];
    NSInteger i = 0;
    for (i = 0; i < [fixturesSouth count]; i++ ){
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
            NSString *snippetString = [NSString stringWithFormat:@"%@ VS %@ (%@)",currentFixture.homeTeam,currentFixture.awayTeam,currentFixture.timeDate];
            NSString *titleString = currentFixture.timeDate;
            
            Location * newFixture = [[Location alloc] init];
            
            newFixture.title = titleString;
            newFixture.snippet = snippetString;
            newFixture.venue = currentFixture.venue;

            
            [Location addFixtures:newFixture];
            
        }
    }

    for (i = 0; i < [fixturesNorth count]; i++ ){
        FixturesNorth *currentFixture = [fixturesNorth objectAtIndex:i];
        
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
            NSString *snippetString = [NSString stringWithFormat:@"%@ VS %@ (%@)",currentFixture.homeTeam,currentFixture.awayTeam,currentFixture.timeDate];
            NSString *titleString = currentFixture.timeDate;
            
            Location * newFixture = [[Location alloc] init];
            
            newFixture.title = titleString;
            newFixture.snippet = snippetString;
            newFixture.venue = currentFixture.venue;
            
            
            [Location addFixtures:newFixture];
            
        }
    }

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
    
    if ([addressStr isEqualToString:@"The Oval"]){
        addressStr = @"The Oval, Miners Welfare Park, Coventry Rd, Bedworth CV12 8NN";
    }
    if ([addressStr isEqualToString:@"Sussex FA"]){
        addressStr = @"Sussex County FA Ltd, Culver Rd, Lancing BN15 9AX";
    }
    if ([addressStr isEqualToString:@"Canvey Island FC"]){
        addressStr = @"1 Park Ln, Canvey Island, Essex SS8 7PX";
    }
    if ([addressStr isEqualToString:@"CCB Centre for Sporting Excellence"]){
        addressStr = @"9 Caerphilly Rd, Ystrad Mynach, Hengoed, Caerphilly CF82 7EP";
    }
    if ([addressStr isEqualToString:@"Slimbridge AFC"]){
        addressStr = @"Slimbridge AFC, Wisloe Road, Cambridge, Gloucestershire, GL2 7AF";
    }
    if ([addressStr isEqualToString:@"AFC Hornchurch"]){
        addressStr = @"AFC Hornchurch, The Stadium, Bridge Ave, Upminster RM14 2LX";
    }
    if ([addressStr isEqualToString:@"Gosport Borough FC"]){
        addressStr = @"Gosport Borough Football Club";
    }
    if ([addressStr isEqualToString:@"Uxbridge FC"]){
        addressStr = @"Uxbridge Football Club, Honeycroft, Horton Rd, West Drayton, Uxbridge, Middlesex UB7 8HX";
    }
    if ([addressStr isEqualToString:@"Elburton Villa FC"]){
        addressStr = @"Elburton Villa Football Club, Plymouth";
    }
    if ([addressStr isEqualToString:@"Wellbeing Park"]){
        addressStr = @"Wellbeing Park, Yarnfield Lane, Stone, Staffordshire ST15 0NF";
    }
    if ([addressStr isEqualToString:@"The WEC"]){
        addressStr = @"AFC Darwen, Anchor Rd, Darwen, Blackburn with Darwen BB3 0BB";
    }
    if ([addressStr isEqualToString:@"The WEC"]){
        addressStr = @"AFC Darwen, Anchor Rd, Darwen, Blackburn with Darwen BB3 0BB";
    }
    if ([addressStr isEqualToString:@"Shelley FC"]){
        addressStr = @"Shelley FC, Storthes Hall, Huddersfield";
    }
    if ([addressStr isEqualToString:@"Thackley AFC"]){
        addressStr = @"Thackley AFC,Ainsbury Ave, Bradford, West Yorkshire BD10 0TL";
    }
    if ([addressStr isEqualToString:@"Guiseley AFC"]){
        addressStr = @"Guiseley Football Club, Nethermoor Park, Otley Rd, Leeds LS20 8BT";
    }
    if ([addressStr isEqualToString:@"Basford United FC #1"]){
        addressStr = @"Mill Street Playing Fields, Greenwich Avenue, Basford, Nottingham, NG6 0LD";
    }
    

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
