//
//  FixturesWSL2.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 10/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
@interface FixturesWSL2 : NSObject

@property (nonatomic, retain) NSString *index;
@property (nonatomic, retain) NSString *homeTeam;
@property (nonatomic, retain) NSString *awayTeam;
@property (nonatomic, retain) NSString *timeDate;
@property (nonatomic, retain) NSString *venue;
@property (nonatomic, retain) NSString *dateOnly;

+(void) addFixturesWSL2: (FixturesWSL2*)objectToAdd;
+(NSMutableArray*) getAllFixturesWSL2;
+(void) formatData: (NSString*) returnedDataWSL2;
+ (NSString *) getDataFromWSL2;
+(void)resetFixturesWSL2;

@end
