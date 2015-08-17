//
//  FixturesWales.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 31/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FixturesWales : NSObject

@property (nonatomic, retain) NSString *index;
@property (nonatomic, retain) NSString *homeTeam;
@property (nonatomic, retain) NSString *awayTeam;
@property (nonatomic, retain) NSString *timeDate;
@property (nonatomic, retain) NSString *venue;
@property (nonatomic, retain) NSString *dateOnly;

+(void) addFixturesWales: (FixturesWales*)objectToAdd;
+(NSMutableArray*) getAllFixturesWales;
+(void) formatData: (NSString*) returnedDataWales;
+ (NSString *) getDataFromWales;
+(void)resetFixturesWales;
+(BOOL)compareDates:(NSDate *)fixtureDate;
@end
