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
static NSMutableArray *fixtureList;

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
    
    fixtureList = [[NSMutableArray alloc] init];
    
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
    for (i = 0; i < [fixturesWSL1 count]; i++ ){
        FixturesWSL1 *currentFixture = [fixturesWSL1 objectAtIndex:i];
        
        NSDateFormatter *dateFormatFixture = [[NSDateFormatter alloc]init];
        
        //[dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
        [dateFormatFixture setDateFormat:@"EEEE d MMMM yyyy H:m"];
        [dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"]];
        [dateFormatFixture setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];

        
        NSDate *fixtureDate = [[NSDate alloc] init];
        fixtureDate = [dateFormatFixture dateFromString:currentFixture.timeDate];
        
        //check fixture is in the future
        BOOL showFixture = [self compareDatesWSL:fixtureDate];
        
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
    for (i = 0; i < [fixturesWSL2 count]; i++ ){
        FixturesWSL2 *currentFixture = [fixturesWSL2 objectAtIndex:i];
        
        NSDateFormatter *dateFormatFixture = [[NSDateFormatter alloc]init];
        
        //[dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
        [dateFormatFixture setDateFormat:@"EEEE d MMMM yyyy H:m"];
        [dateFormatFixture setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"]];
        [dateFormatFixture setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        
        
        NSDate *fixtureDate = [[NSDate alloc] init];
        fixtureDate = [dateFormatFixture dateFromString:currentFixture.timeDate];
        
        //check fixture is in the future
        BOOL showFixture = [self compareDatesWSL:fixtureDate];
        
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
-(BOOL)compareDatesWSL:(NSDate *)fixtureDate{
    //get date and time
    
    NSDate *realDate = [[NSDate alloc] init];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat:@"EEEE d MMMM yyyy H:m"];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"]];
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
+(CLLocationCoordinate2D) getLocationFromAddressString: (NSString*) venueStr {
    double latitude = 0, longitude = 0;
    
    NSString *addressStr = [[NSString alloc] initWithString:venueStr];
    
    NSInteger i = 0;
    for(i = 0; i < [fixtureList count]; i++){
        if ([addressStr isEqualToString:[fixtureList objectAtIndex:i]]){
            
            CLLocationCoordinate2D centreDuplicate;
            centreDuplicate.longitude = 0.000001;
            centreDuplicate.latitude = 0.000001;
            return centreDuplicate;
        }
    }
    [fixtureList addObject:addressStr];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"fixtureCoordinates" ofType:@"json"];
    
    NSError *error;
    //NSHTTPURLResponse *responseCode = nil;
    
    NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding  error:&error];
    
    if(error){
        NSLog(@"Error reading json file");
    }

    
    error =  nil;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    NSArray *coordinates = [json objectForKey:addressStr];
    
    latitude = [[coordinates objectAtIndex:0] doubleValue];
    longitude = [[coordinates objectAtIndex:1] doubleValue];
    
    //if cant find already specified location, find it now
    if ([coordinates isEqualToArray:nil]){
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

    }
    
    
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    
    if (center.latitude == 0.000000 && center.longitude == 0.000000){
        NSLog(@"%@", addressStr);
    }
    return center;
    
}

+ (void)getDirections:(CLLocation *)sourceLocation toDestination:(CLLocation *)destinationLocation onMap:(GMSMapView *)mapView_{
    NSString *baseUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=false,&key=AIzaSyCaIAN-DDnSolU0EpBfcTsOhsJyrSwF76s", sourceLocation.coordinate.latitude,  sourceLocation.coordinate.longitude, destinationLocation.coordinate.latitude,  destinationLocation.coordinate.longitude];
    
    NSURL *url = [NSURL URLWithString:[baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"Url: %@", url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        GMSMutablePath *path = [GMSMutablePath path];
        
        NSError *error = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        NSArray *routes = [result objectForKey:@"routes"];
        
        NSDictionary *firstRoute = [routes objectAtIndex:0];
        
        NSDictionary *leg =  [[firstRoute objectForKey:@"legs"] objectAtIndex:0];
        
        NSArray *steps = [leg objectForKey:@"steps"];
        
        int stepIndex = 0;
        
        CLLocationCoordinate2D stepCoordinates[1  + [steps count] + 1];
        
        for (NSDictionary *step in steps) {
            
            NSDictionary *start_location = [step objectForKey:@"start_location"];
            stepCoordinates[++stepIndex] = [self coordinateWithLocation:start_location];
            [path addCoordinate:[self coordinateWithLocation:start_location]];
            
            NSString *polyLinePoints = [[step objectForKey:@"polyline"] objectForKey:@"points"];
            GMSPath *polyLinePath = [GMSPath pathFromEncodedPath:polyLinePoints];
            for (int p=0; p<polyLinePath.count; p++) {
                [path addCoordinate:[polyLinePath coordinateAtIndex:p]];
            }
            
            
            if ([steps count] == stepIndex){
                NSDictionary *end_location = [step objectForKey:@"end_location"];
                stepCoordinates[++stepIndex] = [self coordinateWithLocation:end_location];
                [path addCoordinate:[self coordinateWithLocation:end_location]];
            }
        }
        
        GMSPolyline *polyline = nil;
        polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeColor = [UIColor grayColor];
        polyline.strokeWidth = 3.f;
        polyline.map = mapView_;
    }];
}

+ (CLLocationCoordinate2D)coordinateWithLocation:(NSDictionary*)location
{
    double latitude = [[location objectForKey:@"lat"] doubleValue];
    double longitude = [[location objectForKey:@"lng"] doubleValue];
    
    return CLLocationCoordinate2DMake(latitude, longitude);
}
@end
