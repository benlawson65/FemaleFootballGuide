//
//  FixturesTableViewController.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 29/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCellView.h"
#import "FixtureDetailTableViewController.h"
#import "FixturesSouth.h"

@interface FixturesTableViewController : UITableViewController <UIAlertViewDelegate>
@property (weak, nonatomic) NSArray* fixtureMenu;
- (NSArray *)populateFixtureMenu;
@property (weak, nonatomic) NSString* fixtureChosen;
- (void)testInternetConnection;
@end
