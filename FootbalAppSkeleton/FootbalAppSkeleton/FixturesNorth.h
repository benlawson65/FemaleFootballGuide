//
//  FixturesNorth.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 31/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface FixturesNorth : NSObject

@property (nonatomic, retain) NSString *index;
@property (nonatomic, retain) NSString *homeTeam;
@property (nonatomic, retain) NSString *awayTeam;
@property (nonatomic, retain) NSString *timeDate;
@property (nonatomic, retain) NSString *venue;

+(void) addFixturesNorth: (FixturesNorth*)objectToAdd;
+(NSMutableArray*) getAllFixturesNorth;
+(void) formatData: (NSString*) returnedDataNorth;
+ (NSString *) getDataFromNorth;
+(void)resetFixturesNorth;
@end
