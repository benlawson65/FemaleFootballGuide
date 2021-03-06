//  FixtureDetailTableViewController.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 29/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixtureDetailTableViewController.h"
#import "FixturesSouth.h"
#import "FixturesNorth.h"
#import "FixturesWales.h"
#import "FixturesWSL1.h"
#import "FixturesWSL2.h"
#import "FixturesScotland.h"
#import "FixturesMidlands.h"
#import "FixturesNorthernOne.h"
#import "FixturesSouthEast.h"
#import "FixturesSouthWest.h"
#import "ViewController.h"

@interface FixtureDetailTableViewController ()

@end

@implementation FixtureDetailTableViewController

@synthesize fixtureSelected;
@synthesize allTableData;
@synthesize filteredTableData;
@synthesize isFiltered;
@synthesize found;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{
                                                                                                 NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                                                 NSFontAttributeName : [UIFont systemFontOfSize:15]
                                                                                                 }];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroud"]];
    [tempImageView setFrame:self.tableView.frame];
    _searchbarFixtures.searchBarStyle = UISearchBarStyleMinimal;
    _searchbarFixtures.tintColor = [UIColor whiteColor];
    
    self.tableView.backgroundView = tempImageView;
    
    //self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = NO;
    //self.navigationController.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:60.0/255.0 blue:0/255.0 alpha:1];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    //self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0/255.0 green:60.0/255.0 blue:0/255.0 alpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:35/255.0 green:70.0/255.0 blue:35/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //searchBarFixtures.delegate = (id)self;
    allTableData = [[NSMutableArray alloc] init];
    filteredTableData = [[NSMutableArray alloc] init];
    isFiltered = FALSE;
    found = FALSE;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    
    if([fixtureSelected isEqualToString:@"WPL: Southern Division"]){
        NSString *returnedDataSouth = [[NSString alloc] init];
        
        //retrieve data from api
        returnedDataSouth = [FixturesSouth getDataFromSouth];
        
        //if(![[FixturesSouth getStatusCodeString] isEqualToString:@"200"]){
         //   [self dataUnreachable];
        //}
        
        //formate data and put it in fixtures object
        [FixturesSouth formatData:returnedDataSouth];
     
        NSArray *returnedFixtures = [FixturesSouth getAllFixturesSouth];
        NSInteger arrayAmount = [returnedFixtures count];
        NSInteger i = 0;
        for(i = 0; i < arrayAmount; i++){
            FixturesSouth *currentFixture = [returnedFixtures objectAtIndex:i];
            NSString *fixtureTitle = [NSString stringWithFormat:@"%@ VS %@",currentFixture.homeTeam,currentFixture.awayTeam];
            [allTableData addObject:fixtureTitle];
        }
      

    }
    if([fixtureSelected isEqualToString:@"WPL: Northern One"]){
        NSString *returnedDataNorthernOne = [[NSString alloc] init];
        
        //retrieve data from api
        returnedDataNorthernOne = [FixturesNorthernOne getDataFromNorthernOne];
        
        //formate data and put it in fixtures object
        [FixturesNorthernOne formatData:returnedDataNorthernOne];
       
        NSArray *returnedFixtures = [FixturesNorthernOne getAllFixturesNorthernOne];
        NSInteger arrayAmount = [returnedFixtures count];
        NSInteger i = 0;
        for(i = 0; i < arrayAmount; i++){
            FixturesNorthernOne *currentFixture = [returnedFixtures objectAtIndex:i];
            NSString *fixtureTitle = [NSString stringWithFormat:@"%@ VS %@",currentFixture.homeTeam,currentFixture.awayTeam];
            [allTableData addObject:fixtureTitle];
        }
        
        
    }
    
    if([fixtureSelected isEqualToString:@"WPL: South West One"]){
        NSString *returnedDataSouthWest = [[NSString alloc] init];
        
        //retrieve data from api
        returnedDataSouthWest = [FixturesSouthWest getDataFromSouthWest];
        
        //formate data and put it in fixtures object
        [FixturesSouthWest formatData:returnedDataSouthWest];
        
        NSArray *returnedFixtures = [FixturesSouthWest getAllFixturesSouthWest];
        NSInteger arrayAmount = [returnedFixtures count];
        NSInteger i = 0;
        for(i = 0; i < arrayAmount; i++){
            FixturesSouthWest *currentFixture = [returnedFixtures objectAtIndex:i];
            NSString *fixtureTitle = [NSString stringWithFormat:@"%@ VS %@",currentFixture.homeTeam,currentFixture.awayTeam];
            [allTableData addObject:fixtureTitle];
        }
        
        
    }
    
    if([fixtureSelected isEqualToString:@"WPL: South East One"]){
        NSString *returnedDataSouthEast = [[NSString alloc] init];
        
        //retrieve data from api
        returnedDataSouthEast = [FixturesSouthEast getDataFromSouthEast];
        
        //formate data and put it in fixtures object
        [FixturesSouthEast formatData:returnedDataSouthEast];
        
        NSArray *returnedFixtures = [FixturesSouthEast getAllFixturesSouthEast];
        NSInteger arrayAmount = [returnedFixtures count];
        NSInteger i = 0;
        for(i = 0; i < arrayAmount; i++){
            FixturesSouthEast *currentFixture = [returnedFixtures objectAtIndex:i];
            NSString *fixtureTitle = [NSString stringWithFormat:@"%@ VS %@",currentFixture.homeTeam,currentFixture.awayTeam];
            [allTableData addObject:fixtureTitle];
        }
        
        
    }
    
    if([fixtureSelected isEqualToString:@"WPL: Midlands One"]){
        NSString *returnedDataMidlands = [[NSString alloc] init];
        
        //retrieve data from api
        returnedDataMidlands = [FixturesMidlands getDataFromMidlands];
        
        //formate data and put it in fixtures object
        [FixturesMidlands formatData:returnedDataMidlands];
        
        NSArray *returnedFixtures = [FixturesMidlands getAllFixturesMidlands];
        NSInteger arrayAmount = [returnedFixtures count];
        NSInteger i = 0;
        for(i = 0; i < arrayAmount; i++){
            FixturesMidlands *currentFixture = [returnedFixtures objectAtIndex:i];
            NSString *fixtureTitle = [NSString stringWithFormat:@"%@ VS %@",currentFixture.homeTeam,currentFixture.awayTeam];
            [allTableData addObject:fixtureTitle];
        }
        
        
    }
    if([fixtureSelected isEqualToString:@"Welsh Premier League"]){
        NSString *returnedDataWales = [[NSString alloc] init];
        
        //retrieve data from api
        returnedDataWales = [FixturesWales getDataFromWales];
        
        //formate data and put it in fixtures object
        [FixturesWales formatData:returnedDataWales];
    
        NSArray *returnedFixtures = [FixturesWales getAllFixturesWales];
        NSInteger arrayAmount = [returnedFixtures count];
        NSInteger i = 0;
        for(i = 0; i < arrayAmount; i++){
            FixturesWales *currentFixture = [returnedFixtures objectAtIndex:i];
            NSString *fixtureTitle = [NSString stringWithFormat:@"%@ VS %@",currentFixture.homeTeam,currentFixture.awayTeam];
            [allTableData addObject:fixtureTitle];
        }
     
        
    }
    if([fixtureSelected isEqualToString:@"WSL1"]){
        NSString *returnedDataWSL1 = [[NSString alloc] init];
        
        //retrieve data from api
        returnedDataWSL1 = [FixturesWSL1 getDataFromWSL1];
        
        //formate data and put it in fixtures object
        [FixturesWSL1 formatData:returnedDataWSL1];
     
        NSArray *returnedFixtures = [FixturesWSL1 getAllFixturesWSL1];
        NSInteger arrayAmount = [returnedFixtures count];
        NSInteger i = 0;
        for(i = 0; i < arrayAmount; i++){
            FixturesWSL1 *currentFixture = [returnedFixtures objectAtIndex:i];
            NSString *fixtureTitle = [NSString stringWithFormat:@"%@ VS %@",currentFixture.homeTeam,currentFixture.awayTeam];
            [allTableData addObject:fixtureTitle];
        }
      
        
    }
    if([fixtureSelected isEqualToString:@"WSL2"]){
        NSString *returnedDataWSL2 = [[NSString alloc] init];
        
        //retrieve data from api
        returnedDataWSL2 = [FixturesWSL2 getDataFromWSL2];
        
        //formate data and put it in fixtures object
        [FixturesWSL2 formatData:returnedDataWSL2];
      
        NSArray *returnedFixtures = [FixturesWSL2 getAllFixturesWSL2];
        NSInteger arrayAmount = [returnedFixtures count];
        NSInteger i = 0;
        for(i = 0; i < arrayAmount; i++){
            FixturesWSL2 *currentFixture = [returnedFixtures objectAtIndex:i];
            NSString *fixtureTitle = [NSString stringWithFormat:@"%@ VS %@",currentFixture.homeTeam,currentFixture.awayTeam];
            [allTableData addObject:fixtureTitle];
        }
       
        
    }
    if([fixtureSelected isEqualToString:@"Scottish Premier League"]){
        NSString *returnedDataScotland = [[NSString alloc] init];
        
        //retrieve data from api
        returnedDataScotland = [FixturesScotland getDataFromScotland];
        
        //formate data and put it in fixtures object
        [FixturesScotland formatData:returnedDataScotland];
        
        NSArray *returnedFixtures = [FixturesScotland getAllFixturesScotland];
        NSInteger arrayAmount = [returnedFixtures count];
        NSInteger i = 0;
        for(i = 0; i < arrayAmount; i++){
            FixturesScotland *currentFixture = [returnedFixtures objectAtIndex:i];
            NSString *fixtureTitle = [NSString stringWithFormat:@"%@ VS %@",currentFixture.homeTeam,currentFixture.awayTeam];
            [allTableData addObject:fixtureTitle];
        }
        
        
    }
    if([fixtureSelected isEqualToString:@"WPL: Northern Division"]){
        NSString *returnedDataNorth = [[NSString alloc] init];
        
        //retrieve data from api
        returnedDataNorth = [FixturesNorth getDataFromNorth];
        
        //formate data and put it in fixtures object
        [FixturesNorth formatData:returnedDataNorth];
        
        NSArray *returnedFixtures = [FixturesNorth getAllFixturesNorth];
        NSInteger arrayAmount = [returnedFixtures count];
        NSInteger i = 0;
        for(i = 0; i < arrayAmount; i++){
            FixturesNorth *currentFixture = [returnedFixtures objectAtIndex:i];
            NSString *fixtureTitle = [NSString stringWithFormat:@"%@ VS %@",currentFixture.homeTeam,currentFixture.awayTeam];
            [allTableData addObject:fixtureTitle];
        }
        
        
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden: NO animated:YES];

}


-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length == 0){
        isFiltered = FALSE;
    }
    else{
        isFiltered = TRUE;
        filteredTableData = [[NSMutableArray alloc] init];
        for (NSString *fixtureTitle in allTableData){
            NSRange nameRange = [fixtureTitle rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound){
                [filteredTableData addObject:fixtureTitle];
            }
        }
    }
    [self.tableView reloadData];
}

-(void)dataUnreachable{
    NSLog(@"data unreachable method");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Data Unavailable"
                                                                             message:@"We are sorry the data is not available at this time, please let us know and we will fix it as soon as possible"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action){
                                                         [self.navigationController popToRootViewControllerAnimated:YES];
                                                     }]; //You can use a block here to handle a press on this button
    [alertController addAction:actionOk];
    
    //[alertController dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController pushViewController:myViewController animated:YES];
    //[self presentViewController:alertController animated:YES completion:nil];
    [[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController presentViewController:alertController animated:YES completion:^{}];
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];

}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    NSInteger rowCount;
    if(self.isFiltered){
        rowCount = filteredTableData.count;
    }
    else{
        rowCount = allTableData.count;
    }
    return rowCount;
  /*  if([fixtureSelected isEqualToString:@"WPL: Southern Division"]){
        NSArray *returnedFixtures = [FixturesSouth getAllFixturesSouth];
        return returnedFixtures.count;
    }
    if([fixtureSelected isEqualToString:@"WPL: Northern Division"]){
        NSArray *returnedFixtures = [FixturesNorth getAllFixturesNorth];
        return returnedFixtures.count;
    }
    if([fixtureSelected isEqualToString:@"Welsh Premier League"]){
        NSArray *returnedFixtures = [FixturesWales getAllFixturesWales];
        return returnedFixtures.count;
    }
    if([fixtureSelected isEqualToString:@"WSL1"]){
        NSArray *returnedFixtures = [FixturesWSL1 getAllFixturesWSL1];
        return returnedFixtures.count;
    }
    if([fixtureSelected isEqualToString:@"WSL2"]){
        NSArray *returnedFixtures = [FixturesWSL2 getAllFixturesWSL2];
        return returnedFixtures.count;
    }
    else{
            NSArray *returnedFixtures = [FixturesSouth getAllFixturesSouth];
            return returnedFixtures.count;
    }
   */

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"FixtureCustomCellView";
    
    FixtureCustomCellView *cell = (FixtureCustomCellView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FixtureCustomCellView" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    UIView * selectedBackgroundViewForCell = [[UIView alloc] init];
    [selectedBackgroundViewForCell setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.3]];
    cell.selectedBackgroundView = selectedBackgroundViewForCell;
    
    if ([fixtureSelected isEqualToString:@"WPL: Southern Division"]){
        
        
        //set cell text to data
        NSArray *returnedFixtures = [FixturesSouth getAllFixturesSouth];
        
        if(isFiltered){
            NSString *awayAndHome = [[NSString alloc] init];
            NSInteger i = 0;
            found = FALSE;
            for(i = 0; i < [returnedFixtures count]; i++){
                
                FixturesSouth *currentFixture = [returnedFixtures objectAtIndex:i];
                awayAndHome = [NSString stringWithFormat:@"%@ VS %@", currentFixture.homeTeam, currentFixture.awayTeam];
                
                if([[filteredTableData objectAtIndex:indexPath.row] isEqualToString:awayAndHome] && found == FALSE){
                    cell.homeTeam.text = currentFixture.homeTeam;
                    cell.awayTeam.text = currentFixture.awayTeam;
                    cell.time.text = currentFixture.timeDate;
                    cell.venue.text = currentFixture.venue;
                    found = TRUE;
                }
            }
        }
        
        else{
            FixturesSouth *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
            cell.homeTeam.text = currentFixture.homeTeam;
            cell.awayTeam.text = currentFixture.awayTeam;
            cell.time.text = currentFixture.timeDate;
            cell.venue.text = currentFixture.venue;
        }
        
    }
    if ([fixtureSelected isEqualToString:@"WPL: South East One"]){
        
        
        //set cell text to data
        NSArray *returnedFixtures = [FixturesSouthEast getAllFixturesSouthEast];
        
        if(isFiltered){
            NSString *awayAndHome = [[NSString alloc] init];
            NSInteger i = 0;
            found = FALSE;
            for(i = 0; i < [returnedFixtures count]; i++){
                
                FixturesSouthEast *currentFixture = [returnedFixtures objectAtIndex:i];
                awayAndHome = [NSString stringWithFormat:@"%@ VS %@", currentFixture.homeTeam, currentFixture.awayTeam];
                
                if([[filteredTableData objectAtIndex:indexPath.row] isEqualToString:awayAndHome] && found == FALSE){
                    cell.homeTeam.text = currentFixture.homeTeam;
                    cell.awayTeam.text = currentFixture.awayTeam;
                    cell.time.text = currentFixture.timeDate;
                    cell.venue.text = currentFixture.venue;
                    found = TRUE;
                }
            }
        }
        else{
            FixturesSouthEast *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
            cell.homeTeam.text = currentFixture.homeTeam;
            cell.awayTeam.text = currentFixture.awayTeam;
            cell.time.text = currentFixture.timeDate;
            cell.venue.text = currentFixture.venue;
        }
    }
        
    if ([fixtureSelected isEqualToString:@"WPL: South West One"]){
        
        
        //set cell text to data
        NSArray *returnedFixtures = [FixturesSouthWest getAllFixturesSouthWest];
        
        if(isFiltered){
            NSString *awayAndHome = [[NSString alloc] init];
            NSInteger i = 0;
            found = FALSE;
            for(i = 0; i < [returnedFixtures count]; i++){
                
                FixturesSouthWest *currentFixture = [returnedFixtures objectAtIndex:i];
                awayAndHome = [NSString stringWithFormat:@"%@ VS %@", currentFixture.homeTeam, currentFixture.awayTeam];
                
                if([[filteredTableData objectAtIndex:indexPath.row] isEqualToString:awayAndHome] && found == FALSE){
                    cell.homeTeam.text = currentFixture.homeTeam;
                    cell.awayTeam.text = currentFixture.awayTeam;
                    cell.time.text = currentFixture.timeDate;
                    cell.venue.text = currentFixture.venue;
                    found = TRUE;
                }
            }
        }
        else{
            FixturesSouthWest *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
            cell.homeTeam.text = currentFixture.homeTeam;
            cell.awayTeam.text = currentFixture.awayTeam;
            cell.time.text = currentFixture.timeDate;
            cell.venue.text = currentFixture.venue;
        }
    }
    if ([fixtureSelected isEqualToString:@"WPL: Northern One"]){
        
        
        //set cell text to data
        NSArray *returnedFixtures = [FixturesNorthernOne getAllFixturesNorthernOne];
        
        if(isFiltered){
            NSString *awayAndHome = [[NSString alloc] init];
            NSInteger i = 0;
            found = FALSE;
            for(i = 0; i < [returnedFixtures count]; i++){
                
                FixturesNorthernOne *currentFixture = [returnedFixtures objectAtIndex:i];
                awayAndHome = [NSString stringWithFormat:@"%@ VS %@", currentFixture.homeTeam, currentFixture.awayTeam];
                
                if([[filteredTableData objectAtIndex:indexPath.row] isEqualToString:awayAndHome] && found == FALSE){
                    cell.homeTeam.text = currentFixture.homeTeam;
                    cell.awayTeam.text = currentFixture.awayTeam;
                    cell.time.text = currentFixture.timeDate;
                    cell.venue.text = currentFixture.venue;
                    found = TRUE;
                }
            }
        }
        else{
            FixturesNorthernOne *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
            cell.homeTeam.text = currentFixture.homeTeam;
            cell.awayTeam.text = currentFixture.awayTeam;
            cell.time.text = currentFixture.timeDate;
            cell.venue.text = currentFixture.venue;
        }
    }
    
    if ([fixtureSelected isEqualToString:@"WPL: Midlands One"]){
        
        
        //set cell text to data
        NSArray *returnedFixtures = [FixturesMidlands getAllFixturesMidlands];
        
        if(isFiltered){
            NSString *awayAndHome = [[NSString alloc] init];
            NSInteger i = 0;
            found = FALSE;
            for(i = 0; i < [returnedFixtures count]; i++){
                
                FixturesMidlands *currentFixture = [returnedFixtures objectAtIndex:i];
                awayAndHome = [NSString stringWithFormat:@"%@ VS %@", currentFixture.homeTeam, currentFixture.awayTeam];
                
                if([[filteredTableData objectAtIndex:indexPath.row] isEqualToString:awayAndHome] && found == FALSE){
                    cell.homeTeam.text = currentFixture.homeTeam;
                    cell.awayTeam.text = currentFixture.awayTeam;
                    cell.time.text = currentFixture.timeDate;
                    cell.venue.text = currentFixture.venue;
                    found = TRUE;
                }
            }
        }
        else{
            FixturesMidlands *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
            cell.homeTeam.text = currentFixture.homeTeam;
            cell.awayTeam.text = currentFixture.awayTeam;
            cell.time.text = currentFixture.timeDate;
            cell.venue.text = currentFixture.venue;
        }
    }


    if ([fixtureSelected isEqualToString:@"WPL: Northern Division"]){
        //set cell text to data
        NSArray *returnedFixtures = [FixturesNorth getAllFixturesNorth];
        
        if(isFiltered){
            NSString *awayAndHome = [[NSString alloc] init];
            NSInteger i = 0;
            found = FALSE;
            for(i = 0; i < [returnedFixtures count]; i++){
                
                FixturesNorth *currentFixture = [returnedFixtures objectAtIndex:i];
                awayAndHome = [NSString stringWithFormat:@"%@ VS %@", currentFixture.homeTeam, currentFixture.awayTeam];
                
                if([[filteredTableData objectAtIndex:indexPath.row] isEqualToString:awayAndHome] && found == FALSE){
                    cell.homeTeam.text = currentFixture.homeTeam;
                    cell.awayTeam.text = currentFixture.awayTeam;
                    cell.time.text = currentFixture.timeDate;
                    cell.venue.text = currentFixture.venue;
                    NSLog(@"Fixture Set");
                    found = TRUE;
                }
            }
        }
        else{
            FixturesNorth *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
            cell.homeTeam.text = currentFixture.homeTeam;
            cell.awayTeam.text = currentFixture.awayTeam;
            cell.time.text = currentFixture.timeDate;
            cell.venue.text = currentFixture.venue;
        }
        
    }
    if ([fixtureSelected isEqualToString:@"Welsh Premier League"]){
        //set cell text to data
        NSArray *returnedFixtures = [FixturesWales getAllFixturesWales];
        
        if(isFiltered){
            NSString *awayAndHome = [[NSString alloc] init];
            NSInteger i = 0;
            found = FALSE;
            for(i = 0; i < [returnedFixtures count]; i++){
                
                FixturesWales *currentFixture = [returnedFixtures objectAtIndex:i];
                awayAndHome = [NSString stringWithFormat:@"%@ VS %@", currentFixture.homeTeam, currentFixture.awayTeam];
                
                if([[filteredTableData objectAtIndex:indexPath.row] isEqualToString:awayAndHome] && found == FALSE){
                    cell.homeTeam.text = currentFixture.homeTeam;
                    cell.awayTeam.text = currentFixture.awayTeam;
                    cell.time.text = currentFixture.timeDate;
                    cell.venue.text = currentFixture.venue;
                    NSLog(@"Fixture Set");
                    found = TRUE;
                }
            }
        }
        else{
            FixturesWales *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
            cell.homeTeam.text = currentFixture.homeTeam;
            cell.awayTeam.text = currentFixture.awayTeam;
            cell.time.text = currentFixture.timeDate;
            cell.venue.text = currentFixture.venue;
        }
        
    }
    if ([fixtureSelected isEqualToString:@"WSL1"]){
        //set cell text to data
        NSArray *returnedFixtures = [FixturesWSL1 getAllFixturesWSL1];
        
        if(isFiltered){
            NSString *awayAndHome = [[NSString alloc] init];
            NSInteger i = 0;
            found = FALSE;
            for(i = 0; i < [returnedFixtures count]; i++){
                
                FixturesWSL1 *currentFixture = [returnedFixtures objectAtIndex:i];
                awayAndHome = [NSString stringWithFormat:@"%@ VS %@", currentFixture.homeTeam, currentFixture.awayTeam];
                
                if([[filteredTableData objectAtIndex:indexPath.row] isEqualToString:awayAndHome] && found == FALSE){
                    cell.homeTeam.text = currentFixture.homeTeam;
                    cell.awayTeam.text = currentFixture.awayTeam;
                    cell.time.text = currentFixture.timeDate;
                    cell.venue.text = currentFixture.venue;
                    NSLog(@"Fixture Set");
                    found = TRUE;
                }
            }
        }
        else{
            FixturesWSL1 *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
            cell.homeTeam.text = currentFixture.homeTeam;
            cell.awayTeam.text = currentFixture.awayTeam;
            cell.time.text = currentFixture.timeDate;
            cell.venue.text = currentFixture.venue;
        }
        
    }
    if ([fixtureSelected isEqualToString:@"WSL2"]){
        //set cell text to data
        NSArray *returnedFixtures = [FixturesWSL2 getAllFixturesWSL2];
        
        if(isFiltered){
            NSString *awayAndHome = [[NSString alloc] init];
            NSInteger i = 0;
            found = FALSE;
            for(i = 0; i < [returnedFixtures count]; i++){
                
                FixturesWSL2 *currentFixture = [returnedFixtures objectAtIndex:i];
                awayAndHome = [NSString stringWithFormat:@"%@ VS %@", currentFixture.homeTeam, currentFixture.awayTeam];
                
                if([[filteredTableData objectAtIndex:indexPath.row] isEqualToString:awayAndHome] && found == FALSE){
                    cell.homeTeam.text = currentFixture.homeTeam;
                    cell.awayTeam.text = currentFixture.awayTeam;
                    cell.time.text = currentFixture.timeDate;
                    cell.venue.text = currentFixture.venue;
                    NSLog(@"Fixture Set");
                    found = TRUE;
                }
            }
        }
        else{
            FixturesWSL2 *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
            cell.homeTeam.text = currentFixture.homeTeam;
            cell.awayTeam.text = currentFixture.awayTeam;
            cell.time.text = currentFixture.timeDate;
            cell.venue.text = currentFixture.venue;
        }
    }
    if ([fixtureSelected isEqualToString:@"Scottish Premier League"]){
        //set cell text to data
        NSArray *returnedFixtures = [FixturesScotland getAllFixturesScotland];
        
        if(isFiltered){
            NSString *awayAndHome = [[NSString alloc] init];
            NSInteger i = 0;
            found = FALSE;
            for(i = 0; i < [returnedFixtures count]; i++){
                
                FixturesScotland *currentFixture = [returnedFixtures objectAtIndex:i];
                awayAndHome = [NSString stringWithFormat:@"%@ VS %@", currentFixture.homeTeam, currentFixture.awayTeam];
                
                if([[filteredTableData objectAtIndex:indexPath.row] isEqualToString:awayAndHome] && found == FALSE){
                    cell.homeTeam.text = currentFixture.homeTeam;
                    cell.awayTeam.text = currentFixture.awayTeam;
                    cell.time.text = currentFixture.timeDate;
                    cell.venue.text = currentFixture.venue;
                    NSLog(@"Fixture Set");
                    found = TRUE;
                }
            }
        }
        else{
            FixturesScotland *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
            cell.homeTeam.text = currentFixture.homeTeam;
            cell.awayTeam.text = currentFixture.awayTeam;
            cell.time.text = currentFixture.timeDate;
            cell.venue.text = currentFixture.venue;
        }
    }

    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        return 362;
    }
    else {
        
        return 204;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate
/*
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FixtureDetailViewController *fixtureDetail = [[FixtureDetailViewController alloc] initWithNibName:@"FixtureDetailViewController" bundle:nil];
    
    
   NSArray *returnedFixtures = [FixturesSouth getAllFixturesSouth];
    FixturesSouth *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
    
    //send varibles for fixture to detail view
    NSString *homeAwayMerge = [NSString stringWithFormat:@"%@ VS %@", currentFixture.homeTeam, currentFixture.awayTeam];
    
    fixtureDetail.homeVsAwayStr = homeAwayMerge;
    fixtureDetail.fixtureTimeStr = currentFixture.timeDate;
    fixtureDetail.fixtureVenueStr = currentFixture.venue;
    
    //[self.navigationController pushViewController:fixtureDetail animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
