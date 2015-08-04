//
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

@interface FixtureDetailTableViewController ()

@end

@implementation FixtureDetailTableViewController

@synthesize fixtureSelected;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([fixtureSelected isEqualToString:@"WPL: Southern Division"]){
        NSString *returnedDataSouth = [[NSString alloc] init];
        
        //retrieve data from api
        returnedDataSouth = [FixturesSouth getDataFromSouth];
        
        //formate data and put it in fixtures object
        [FixturesSouth formatData:returnedDataSouth];

    }
    
    if([fixtureSelected isEqualToString:@"WPL: Northern Division"]){
        NSString *returnedDataNorth = [[NSString alloc] init];
        
        //retrieve data from api
        returnedDataNorth = [FixturesNorth getDataFromNorth];
        
        //formate data and put it in fixtures object
        [FixturesNorth formatData:returnedDataNorth];
        
    }
    if([fixtureSelected isEqualToString:@"Welsh Premier League"]){
        NSString *returnedDataWales = [[NSString alloc] init];
        
        //retrieve data from api
        returnedDataWales = [FixturesWales getDataFromWales];
        
        //formate data and put it in fixtures object
        [FixturesWales formatData:returnedDataWales];
        
    }
    if([fixtureSelected isEqualToString:@"WSL1"]){
        NSString *returnedDataWSL1 = [[NSString alloc] init];
        
        //retrieve data from api
        returnedDataWSL1 = [FixturesWSL1 getDataFromWSL1];
        
        //formate data and put it in fixtures object
        [FixturesWSL1 formatData:returnedDataWSL1];
        
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

    if([fixtureSelected isEqualToString:@"WPL: Southern Division"]){
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
    else{
            NSArray *returnedFixtures = [FixturesSouth getAllFixturesSouth];
            return returnedFixtures.count;
    }


}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"FixtureCustomCellView";
    
    FixtureCustomCellView *cell = (FixtureCustomCellView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FixtureCustomCellView" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    
    if ([fixtureSelected isEqualToString:@"WPL: Southern Division"]){
        //set cell text to data
        NSArray *returnedFixtures = [FixturesSouth getAllFixturesSouth];
        FixturesSouth *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
        
        cell.homeTeam.text = currentFixture.homeTeam;
        cell.awayTeam.text = currentFixture.awayTeam;
        cell.time.text = currentFixture.timeDate;
        cell.venue.text = currentFixture.venue;
    }
    if ([fixtureSelected isEqualToString:@"WPL: Northern Division"]){
        //set cell text to data
        NSArray *returnedFixtures = [FixturesNorth getAllFixturesNorth];
        FixturesNorth *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
        
        cell.homeTeam.text = currentFixture.homeTeam;
        cell.awayTeam.text = currentFixture.awayTeam;
        cell.time.text = currentFixture.timeDate;
        cell.venue.text = currentFixture.venue;
    }
    if ([fixtureSelected isEqualToString:@"Welsh Premier League"]){
        //set cell text to data
        NSArray *returnedFixtures = [FixturesWales getAllFixturesWales];
        FixturesWales *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
        
        cell.homeTeam.text = currentFixture.homeTeam;
        cell.awayTeam.text = currentFixture.awayTeam;
        cell.time.text = currentFixture.timeDate;
        cell.venue.text = currentFixture.venue;
    }
    if ([fixtureSelected isEqualToString:@"WSL1"]){
        //set cell text to data
        NSArray *returnedFixtures = [FixturesWSL1 getAllFixturesWSL1];
        FixturesWSL1 *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
        
        cell.homeTeam.text = currentFixture.homeTeam;
        cell.awayTeam.text = currentFixture.awayTeam;
        cell.time.text = currentFixture.timeDate;
        cell.venue.text = currentFixture.venue;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 177;
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
