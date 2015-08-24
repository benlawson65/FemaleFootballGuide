//
//  FixturesNorthernOne.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 24/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface FixturesNorthernOne : NSObject


@property (nonatomic, retain) NSString *index;
@property (nonatomic, retain) NSString *homeTeam;
@property (nonatomic, retain) NSString *awayTeam;
@property (nonatomic, retain) NSString *timeDate;
@property (nonatomic, retain) NSString *venue;
@property (nonatomic, retain) NSString *dateOnly;

+(void) addFixturesNorthernOne: (FixturesNorthernOne*)objectToAdd;
+(NSMutableArray*) getAllFixturesNorthernOne;
+(void) formatData: (NSString*) returnedDataNorthernOne;
+ (NSString *) getDataFromNorthernOne;
+(void)resetFixturesNorthernOne;

@end
