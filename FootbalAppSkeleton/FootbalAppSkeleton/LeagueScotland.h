//
//  LeagueScotland.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 24/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeagueScotland : NSObject

@property (nonatomic, retain) NSString *index;
@property (nonatomic, retain) NSString *team;
@property (nonatomic, retain) NSString *points;
@property (nonatomic, retain) NSString *goalDifference;
@property (nonatomic, retain) NSString *wins;
@property (nonatomic, retain) NSString *draws;
@property (nonatomic, retain) NSString *losses;

+(void) addLeaguesScotland: (LeagueScotland*)objectToAdd;
+(NSMutableArray*) getAllLeagueTeamsScotland;
+(void) formatData: (NSString*) returnedDataScotland;
+ (NSString *) getDataFromScotland;
+(void)resetLeaguesScotland;

@end
