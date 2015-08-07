//
//  LeagueDetailTableViewController.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 02/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "LeagueDetailTableViewController.h"

@interface LeagueDetailTableViewController ()

@end

@implementation LeagueDetailTableViewController

@synthesize leagueSelected;
@synthesize expandedIndexPath;
@synthesize previousTableView;
@synthesize previousIndexPath;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *returnedDataWales = [[NSString alloc] init];
    
    //retrieve data from api
    returnedDataWales = [LeagueWales getDataFromWales];
    
    //formate data and put it in fixtures object
    [LeagueWales formatData:returnedDataWales];
    
    
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
    if([leagueSelected isEqualToString:@"WPL: Southern Division"]){
        NSArray *returnedFixtures = [LeagueWales getAllLeagueTeamsWales];
        return returnedFixtures.count;
    }
    if([leagueSelected isEqualToString:@"WPL: Northern Division"]){
        NSArray *returnedFixtures = [LeagueWales getAllLeagueTeamsWales];
        return returnedFixtures.count;
    }
    if([leagueSelected isEqualToString:@"Welsh Premier League"]){
        NSArray *returnedFixtures = [LeagueWales getAllLeagueTeamsWales];
        return returnedFixtures.count;
    }
    else{
        NSArray *returnedLeagues = [LeagueWales getAllLeagueTeamsWales];
        return returnedLeagues.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

 static NSString *CellIdentifier = @"LeagueCustomView";
    LeagueCustomView *cell = (LeagueCustomView *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LeagueCustomView" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if ([leagueSelected isEqualToString:@"WPL: Southern Division"]){
        //set cell text to data
        NSArray *returnedFixtures = [LeagueWales getAllLeagueTeamsWales];
        LeagueWales *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
        
        cell.leagueTeamName.text = currentFixture.team;
        cell.leaguePoints.text = currentFixture.points;
        cell.leagueGD.text = currentFixture.goalDifference;
        cell.leagueWins.text = currentFixture.wins;
        cell.leagueDraws.text = currentFixture.draws;
        cell.leagueRank.text = currentFixture.index;
        cell.leagueLosees.text = currentFixture.losses;
    }
    if ([leagueSelected isEqualToString:@"WPL: Northern Division"]){
        //set cell text to data
        NSArray *returnedFixtures = [LeagueWales getAllLeagueTeamsWales];
        LeagueWales *currentFixture = [returnedFixtures objectAtIndex:indexPath.row];
        
        cell.leagueTeamName.text = currentFixture.team;
        cell.leaguePoints.text = currentFixture.points;
        cell.leagueGD.text = currentFixture.goalDifference;
        cell.leagueWins.text = currentFixture.wins;
        cell.leagueDraws.text = currentFixture.draws;
        cell.leagueRank.text = currentFixture.index;
        cell.leagueLosees.text = currentFixture.losses;
    }
    if ([leagueSelected isEqualToString:@"Welsh Premier League"]){
        //set cell text to data
        NSArray *returnedLeague = [LeagueWales getAllLeagueTeamsWales];
        LeagueWales *currentLeague = [returnedLeague objectAtIndex:indexPath.row];
        
        cell.leagueTeamName.text = currentLeague.team;
        cell.leaguePoints.text = currentLeague.points;
        cell.leagueGD.text = currentLeague.goalDifference;
        cell.leagueWins.text = currentLeague.wins;
        cell.leagueDraws.text = currentLeague.draws;
        cell.leagueRank.text = currentLeague.index;
        cell.leagueLosees.text = currentLeague.losses;

            cell.leagueWins.hidden = YES;
            cell.leagueDraws.hidden = YES;
            cell.leagueLosees.hidden = YES;
            cell.leagueGD.hidden = YES;
            cell.leaguePoints.hidden = YES;
            cell.gdTitle.hidden = YES;
            cell.ptsTitle.hidden = YES;
            cell.winsTitle.hidden = YES;
            cell.lossesTitle.hidden = YES;
            cell.drawsTitle.hidden = YES;
        
        //put this in expand and minimize methods!!!
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Compares the index path for the current cell to the index path stored in the expanded
    // index path variable. If the two match, return a height of 100 points, otherwise return
    // a height of 44 points.
    if ([indexPath compare:self.expandedIndexPath] == NSOrderedSame) {
        return 129.0; // Expanded height
    }
    
    return 42.0; // Normal height
    
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

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView beginUpdates]; // tell the table you're about to start making changes
    
    //set tableView so it can be accessed elsewhere

    
    // If the index path of the currently expanded cell is the same as the index that
    // has just been tapped set the expanded index to nil so that there aren't any
    // expanded cells, otherwise, set the expanded index to the index that has just
    // been selected.
    if ([indexPath compare:self.expandedIndexPath] == NSOrderedSame) {
        self.expandedIndexPath = nil;
        //retract expanded data
        
        LeagueCustomView *cell = (LeagueCustomView *)[tableView cellForRowAtIndexPath:indexPath];
        cell.leagueGD.hidden = YES;
        cell.gdTitle.hidden = YES;
        cell.ptsTitle.hidden = YES;
        cell.leaguePoints.hidden = YES;
        cell.leagueDraws.hidden = YES;
        cell.leagueWins.hidden = YES;
        cell.leagueLosees.hidden = YES;
        cell.lossesTitle.hidden = YES;
        cell.winsTitle.hidden = YES;
        cell.drawsTitle.hidden = YES;
        
    } else {
        //when cell not expanded, expand it and show details
        self.expandedIndexPath = indexPath;
        //show expanded data
        [self performSelector:@selector(delayedMethodExpand:) withObject:@[tableView, indexPath] afterDelay:0.25];
        
        //if theres has been a previously expanded cell, minimize it
        if (previousIndexPath != nil && previousTableView != nil){
            [self minimizeDetails];
        }
        
        //keep track of the last expanded cell
        previousTableView = tableView;
        previousIndexPath = indexPath;
    }
    
    [tableView endUpdates]; // tell the table you're done making your changes
}

//hides details when cell is expanded
-(void)delayedMethodExpand:(NSArray *)array{
    UITableView *tableView = [array objectAtIndex:0];
    NSIndexPath *indexPath = [array objectAtIndex:1];
    LeagueCustomView *cell = (LeagueCustomView *)[tableView cellForRowAtIndexPath:indexPath];
    cell.leagueGD.hidden = NO;
    cell.gdTitle.hidden = NO;
    cell.ptsTitle.hidden = NO;
    cell.leaguePoints.hidden = NO;
    cell.leagueDraws.hidden = NO;
    cell.leagueWins.hidden = NO;
    cell.leagueLosees.hidden = NO;
    cell.lossesTitle.hidden = NO;
    cell.winsTitle.hidden = NO;
    cell.drawsTitle.hidden = NO;
}
-(void)minimizeDetails{
    UITableView *tableView = previousTableView;
    NSIndexPath *indexPath = previousIndexPath;
    LeagueCustomView *cell = (LeagueCustomView *)[tableView cellForRowAtIndexPath:indexPath];
    cell.leagueGD.hidden = YES;
    cell.gdTitle.hidden = YES;
    cell.ptsTitle.hidden = YES;
    cell.leaguePoints.hidden = YES;
    cell.leagueDraws.hidden = YES;
    cell.leagueWins.hidden = YES;
    cell.leagueLosees.hidden = YES;
    cell.lossesTitle.hidden = YES;
    cell.winsTitle.hidden = YES;
    cell.drawsTitle.hidden = YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
