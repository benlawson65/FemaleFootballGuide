//
//  Location.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 10/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "FixturesWales.h"
#import "FixturesWSL1.h"
#import "FixturesWSL2.h"
#import "FixturesSouth.h"
#import "FixturesNorth.h"


@interface Location : NSObject

+(CLLocationCoordinate2D) getLocationFromAddressString: (NSString*) addressStr;
-(void) getAllFixtures;
-(void) cycleThroughFixtures;
+(NSMutableArray *)returnAllFixtures;
+(void)resetFixtures;
-(BOOL)compareDatesWSL:(NSDate *)fixtureDate;
-(BOOL)compareDates:(NSDate *)fixtureDate;
+(void)getDirections:(CLLocation *)sourceLocation toDestination:(CLLocation *)destinationLocation onMap:(GMSMapView *)mapView_;
+(NSString*)getDuration;
+(NSString*)getDistance;
+(BOOL)getBackgroundThreadStatus;
+(void)initPolyLines;
+(void)resetPolyLines;

@property (nonatomic, retain) NSArray* fixturesSouth;
@property (nonatomic, retain) NSArray* fixturesNorth;
@property (nonatomic, retain) NSArray* fixturesWSL1;
@property (nonatomic, retain) NSArray* fixturesWSL2;
@property (nonatomic, retain) NSArray* fixturesWales;
@property (nonatomic, retain) NSMutableArray* listOfFixtures;

@property (nonatomic, retain) NSString *venue;
@property (nonatomic, retain) NSString *snippet;
@property (nonatomic, retain) NSString *title;


@end
