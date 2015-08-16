//
//  FixturesScotland.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 16/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FixturesScotland : NSObject

@property (nonatomic, retain) NSString *index;
@property (nonatomic, retain) NSString *homeTeam;
@property (nonatomic, retain) NSString *awayTeam;
@property (nonatomic, retain) NSString *timeDate;
@property (nonatomic, retain) NSString *venue;
@property (nonatomic, retain) NSString *dateOnly;

+(void) addFixturesScotland: (FixturesScotland*)objectToAdd;
+(NSMutableArray*) getAllFixturesScotland;
+(void) formatData: (NSString*) returnedDataScotland;
+ (NSString *) getDataFromScotland;
+(void)resetFixturesScotland;

@end
