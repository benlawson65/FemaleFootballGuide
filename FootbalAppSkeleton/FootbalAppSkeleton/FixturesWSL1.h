//
//  FixturesWSL1.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 04/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FixturesWSL1 : NSObject

@property (nonatomic, retain) NSString *index;
@property (nonatomic, retain) NSString *homeTeam;
@property (nonatomic, retain) NSString *awayTeam;
@property (nonatomic, retain) NSString *timeDate;
@property (nonatomic, retain) NSString *venue;
@property (nonatomic, retain) NSString *dateOnly;

+(void) addFixturesWSL1: (FixturesWSL1*)objectToAdd;
+(NSMutableArray*) getAllFixturesWSL1;
+(void) formatData: (NSString*) returnedDataWSL1;
+ (NSString *) getDataFromWSL1;
+(void)resetFixturesWSL1;

@end
