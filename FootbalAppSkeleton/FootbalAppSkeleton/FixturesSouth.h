//
//  FixturesSouth.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 29/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FixturesSouth : NSObject

@property (nonatomic, retain) NSString *index;
@property (nonatomic, retain) NSString *homeTeam;
@property (nonatomic, retain) NSString *awayTeam;
@property (nonatomic, retain) NSString *timeDate;
@property (nonatomic, retain) NSString *venue;

+(void) addFixturesSouth: (FixturesSouth *)objectToAdd;
+(NSMutableArray*) getAllFixturesSouth;
+(void) formatData: (NSString*) returnedDataSouth;
+ (NSString *) getDataFromSouth;
+(void)resetFixturesSouth;

@end
