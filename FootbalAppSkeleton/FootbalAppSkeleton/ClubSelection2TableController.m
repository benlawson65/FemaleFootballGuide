//
//  ClubSelection2TableController.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 05/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "ClubSelection2TableController.h"

@interface ClubSelection2TableController ()

@end

@implementation ClubSelection2TableController

@synthesize leagueForClubSelected;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //send league selected to object class to decide which api to take data from
    ClubsForLeagueChosen *obj = [[ClubsForLeagueChosen alloc] init];
    [obj setLeagueForClubChosenPassed:leagueForClubSelected];
    
    NSString *returnedDataFromLeagueChosen = [[NSString alloc] init];
    
    returnedDataFromLeagueChosen = [obj getDataForLeagueChosen];
    
    [obj formatData:returnedDataFromLeagueChosen];
    
    
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
    NSArray *returnedClubs = [ClubsForLeagueChosen getAllClubsForLeagueChosen];
    return returnedClubs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ClubListCustomCell";
    
    ClubListCustomCell *cell = (ClubListCustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ClubListCustomCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    //set cell text to data
    NSArray *returnedClubs = [ClubsForLeagueChosen getAllClubsForLeagueChosen];
    ClubsForLeagueChosen *currentClubName = [returnedClubs objectAtIndex:indexPath.row];
    
    cell.labelTeam.text = currentClubName.team;
    
    //add grey arow to each cell
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
