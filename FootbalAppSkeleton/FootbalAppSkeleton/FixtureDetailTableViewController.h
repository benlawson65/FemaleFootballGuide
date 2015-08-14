//
//  FixtureDetailTableViewController.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 29/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FixtureDetailTableViewController.h"
#import "FixtureCustomCellView.h"

@interface FixtureDetailTableViewController : UITableViewController
@property(weak, nonatomic) NSString *fixtureSelected;
@property (strong, nonatomic) NSMutableArray *allTableData;
@property (strong, nonatomic) NSMutableArray *filteredTableData;
@property (weak, nonatomic) IBOutlet UISearchBar *searchbarFixtures;
@property BOOL isFiltered;
@end
