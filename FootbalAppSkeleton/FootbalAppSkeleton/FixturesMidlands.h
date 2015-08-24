//
//  FixturesMidlands.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 24/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface FixturesMidlands : NSObject

@property (nonatomic, retain) NSString *index;
@property (nonatomic, retain) NSString *homeTeam;
@property (nonatomic, retain) NSString *awayTeam;
@property (nonatomic, retain) NSString *timeDate;
@property (nonatomic, retain) NSString *venue;
@property (nonatomic, retain) NSString *dateOnly;

+(void) addFixturesMidlands: (FixturesMidlands*)objectToAdd;
+(NSMutableArray*) getAllFixturesMidlands;
+(void) formatData: (NSString*) returnedDataMidlands;
+ (NSString *) getDataFromMidlands;
+(void)resetFixturesMidlands;
@end
