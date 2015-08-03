//
//  FixtureCustomCellView.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 29/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FixtureCustomCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *homeTeam;

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *venue;
@property (weak, nonatomic) IBOutlet UILabel *awayTeam;

@end
