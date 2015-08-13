//
//  PlayerTableViewController.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 06/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "PlayerTableViewController.h"

@interface PlayerTableViewController ()

@end

@implementation PlayerTableViewController

@synthesize clubForPlayersChosen;
@synthesize leagueChosen;
@synthesize returnedPlayers;

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    
    //pass chosen club to object class for wsl
    if ([leagueChosen isEqualToString:@"WSL1"] || [leagueChosen isEqualToString:@"WSL2"]) {
        
        RetrieveTeamPlayersWSL *obj = [[RetrieveTeamPlayersWSL alloc] init];
        [obj setChosenClub:clubForPlayersChosen];
        
        [obj setLeagueChosen:leagueChosen];
        
        NSString *returnedDataFromClubChosen = [[NSString alloc] init];
        
        returnedDataFromClubChosen = [obj getDataFromWSL];
        
        [obj formatData:returnedDataFromClubChosen];
        
        returnedPlayers = [[NSArray alloc] init];
        returnedPlayers = [obj getAllPlayersWSL];
    }
    
    //pass chosen club to object class for premier league
    if ([leagueChosen isEqualToString:@"WPL: Northern Division"] || [leagueChosen isEqualToString:@"WPL: Southern Division"]) {
        //pass chosen club to object class for wsl
        RetrieveTeamPlayersPremierLeague *obj = [[RetrieveTeamPlayersPremierLeague alloc] init];
        [obj setChosenClub:clubForPlayersChosen];
        
        [obj setLeagueChosen:leagueChosen];
        
        NSString *returnedDataFromClubChosen = [[NSString alloc] init];
        
        returnedDataFromClubChosen = [obj getDataFromPremierLeague];
        
        [obj formatData:returnedDataFromClubChosen];
        
        returnedPlayers = [[NSArray alloc] init];
        returnedPlayers = [obj getAllPlayersPremierLeague];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setLeagueChosen:(NSString *)leagueChosenPassed{
    leagueChosen = leagueChosenPassed;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return returnedPlayers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ClubListCustomCell";
    
    PlayerListCustomCell *cell = (PlayerListCustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlayerListCustomCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    //display data for premier league
    if ([leagueChosen isEqualToString:@"WPL: Northern Division"] || [leagueChosen isEqualToString:@"WPL: Southern Division"]) {
        //set cell text to data
        RetrieveTeamPlayersPremierLeague *currentPlayerName = [returnedPlayers objectAtIndex:indexPath.row];
        
        cell.playerNameLabel.text = currentPlayerName.name;
    }
    
    //diplay data for wsl
    if ([leagueChosen isEqualToString:@"WSL1"] || [leagueChosen isEqualToString:@"WSL2"]) {
    
        //set cell text to data
        RetrieveTeamPlayersWSL *currentPlayerName = [returnedPlayers objectAtIndex:indexPath.row];
    
        cell.playerNameLabel.text = currentPlayerName.name;
        cell.positionLabel.text = currentPlayerName.position;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    return cell;

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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
