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
-(NSMutableArray*) cycleThroughFixtures;

@property (nonatomic, retain) NSArray* fixturesSouth;
@property (nonatomic, retain) NSArray* fixturesNorth;
@property (nonatomic, retain) NSArray* fixturesWSL1;
@property (nonatomic, retain) NSArray* fixturesWSL2;
@property (nonatomic, retain) NSArray* fixturesWales;
@property (nonatomic, retain) NSMutableArray* listOfFixtures;

@end
