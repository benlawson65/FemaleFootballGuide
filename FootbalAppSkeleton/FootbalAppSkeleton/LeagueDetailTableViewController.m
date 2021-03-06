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
@synthesize expandedIndexPaths;
@synthesize expandedCellFound;
@synthesize firstLoad;
@synthesize cellsizeStatus;
@synthesize selected;
@synthesize selectedAgain;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroud"]];
    [tempImageView setFrame:self.tableView.frame];
    
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
    
    expandedIndexPaths = [[NSMutableArray alloc] init];
    NSString *returnedDataWales = [[NSString alloc] init];
    NSString *returnedDataScotland = [[NSString alloc] init];
    expandedCellFound = FALSE;
    firstLoad = TRUE;
    BOOL b = NO;
    cellsizeStatus = [[NSMutableArray alloc] initWithObjects:
                      [NSNumber numberWithBool:b],[NSNumber numberWithBool:b],[NSNumber numberWithBool:b],[NSNumber numberWithBool:b],[NSNumber numberWithBool:b],[NSNumber numberWithBool:b],[NSNumber numberWithBool:b],[NSNumber numberWithBool:b],[NSNumber numberWithBool:b],[NSNumber numberWithBool:b],[NSNumber numberWithBool:b],[NSNumber numberWithBool:b], nil];
    if([leagueSelected isEqualToString:@"Welsh Premier League"]){
        //retrieve data from api
        returnedDataWales = [LeagueWales getDataFromWales];
    
        //formate data and put it in fixtures object
        [LeagueWales formatData:returnedDataWales];
    }
    if([leagueSelected isEqualToString:@"Scottish Premier League"]){
        //retrieve data from api
        returnedDataScotland = [LeagueScotland getDataFromScotland];
        
        //formate data and put it in fixtures object
        [LeagueScotland formatData:returnedDataScotland];
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
    if([leagueSelected isEqualToString:@"Scottish Premier League"]){
        NSArray *returnedFixtures = [LeagueScotland getAllLeagueTeamsScotland];
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
    
    if ([leagueSelected isEqualToString:@"Scottish Premier League"]){
        //set cell text to data
        NSArray *returnedLeague = [LeagueScotland getAllLeagueTeamsScotland];
        LeagueScotland *currentLeague = [returnedLeague objectAtIndex:indexPath.row];
        
        if(![[cellsizeStatus objectAtIndex:indexPath.row] boolValue]){
            // [self delayedMethodExpand:@[tableView, indexPath]];
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
            NSLog(@"%ld",(long)indexPath.row);
        }
        else{
            //  [self minimizeDetails:@[indexPath, tableView]];
            
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
        
        
        cell.leagueTeamName.text = currentLeague.team;
        cell.leaguePoints.text = currentLeague.points;
        cell.leagueGD.text = currentLeague.goalDifference;
        cell.leagueWins.text = currentLeague.wins;
        cell.leagueDraws.text = currentLeague.draws;
        cell.leagueRank.text = currentLeague.index;
        cell.leagueLosees.text = currentLeague.losses;
        NSLog(firstLoad ? @"Yes" : @"No");
        
        if(firstLoad){
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            
            //if just set last cell on first load of view controller set firstLoad to false
            if([returnedLeague count] - 1 == indexPath.row){
                firstLoad = FALSE;
            }
            /*
             NSInteger i = 0;
             expandedCellFound = FALSE;
             for(i = 0;i < [expandedIndexPaths count]; i++){
             if([indexPath compare:[expandedIndexPaths objectAtIndex:i]] == NSOrderedSame){
             [self delayedMethodExpand:@[tableView, indexPath]];
             expandedCellFound = TRUE;
             }
             }
             if(!expandedCellFound){
             [self minimizeDetails:@[indexPath, tableView]];
             }*/
            
            
        }
    }
    
    if ([leagueSelected isEqualToString:@"Welsh Premier League"]){
        //set cell text to data
        NSArray *returnedLeague = [LeagueWales getAllLeagueTeamsWales];
        LeagueWales *currentLeague = [returnedLeague objectAtIndex:indexPath.row];
        
        if(![[cellsizeStatus objectAtIndex:indexPath.row] boolValue]){
            // [self delayedMethodExpand:@[tableView, indexPath]];
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
            NSLog(@"%ld",(long)indexPath.row);
        }
        else{
            //  [self minimizeDetails:@[indexPath, tableView]];
            
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

        
        cell.leagueTeamName.text = currentLeague.team;
        cell.leaguePoints.text = currentLeague.points;
        cell.leagueGD.text = currentLeague.goalDifference;
        cell.leagueWins.text = currentLeague.wins;
        cell.leagueDraws.text = currentLeague.draws;
        cell.leagueRank.text = currentLeague.index;
        cell.leagueLosees.text = currentLeague.losses;
        NSLog(firstLoad ? @"Yes" : @"No");

    if(firstLoad){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        
        //if just set last cell on first load of view controller set firstLoad to false
       if([returnedLeague count] - 1 == indexPath.row){
            firstLoad = FALSE;
        }
        /*
        NSInteger i = 0;
        expandedCellFound = FALSE;
        for(i = 0;i < [expandedIndexPaths count]; i++){
            if([indexPath compare:[expandedIndexPaths objectAtIndex:i]] == NSOrderedSame){
                [self delayedMethodExpand:@[tableView, indexPath]];
                expandedCellFound = TRUE;
            }
        }
        if(!expandedCellFound){
            [self minimizeDetails:@[indexPath, tableView]];
        }*/
        
        
    }
        
        //put this in expand and minimize methods!!!
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //
   // if(!firstLoad){
        if(![[cellsizeStatus objectAtIndex:indexPath.row] boolValue]){
            cell.backgroundColor = [UIColor colorWithWhite:0/255 alpha:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        
        else{
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.4];
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
   // }
   // }
   //
    //}
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
    
        if ([[cellsizeStatus objectAtIndex:indexPath.row] boolValue]){
            return 307;
        }
        else{
            return 90;
        }
    }
    else{
        if ([[cellsizeStatus objectAtIndex:indexPath.row] boolValue]){
            return 129.0;
        }
        else{
            return 42.0;
        }
    }
    
    /*//if this indx path has been clicked expand
    if ([indexPath compare:self.expandedIndexPath] == NSOrderedSame) {
        NSLog(@"being expanded");
        return 129.0; // Expanded height
        
    }
    
    //else check its in the array of index paths that are set to be expanded and if so keep expanded
    else{
        
        NSInteger i = 0;
        for (i = 0; i< [expandedIndexPaths count]; i++){
            if([indexPath compare:[expandedIndexPaths objectAtIndex:i]] == NSOrderedSame){
                NSLog(@"continue being expanded");
                return 129.0;
            }
        }
    }

    NSLog(@"cell is or should be minmized");
    return 42.0; // Normal height
    */
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
    //NSInteger i = 0;
    
    //resent if cell is found each time a cell is clicked on
    //expandedCellFound = FALSE;
    
    if([[cellsizeStatus objectAtIndex:indexPath.row] boolValue]){
        
        BOOL b = 0;
        NSNumber *num = [NSNumber numberWithBool:b];
        [cellsizeStatus replaceObjectAtIndex:indexPath.row withObject:num];
        [self minimizeDetails:@[indexPath, tableView]];
    }
    else{
        BOOL b = 1;
        NSNumber *num = [NSNumber numberWithBool:b];
        
        [cellsizeStatus replaceObjectAtIndex:indexPath.row withObject:num];
        [self performSelector:@selector(delayedMethodExpand:) withObject:@[tableView, indexPath] afterDelay:0.25];
    }
        
    /*if(!expandedCellFound) {
        //when cell not expanded, expand it and show details
        self.expandedIndexPath = indexPath;
        [expandedIndexPaths addObject:indexPath];
        BOOL obj = TRUE;
        obj = [cellsizeStatus objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
        //show expanded data
        [self performSelector:@selector(delayedMethodExpand:) withObject:@[tableView, indexPath] afterDelay:0.25];
        
        //if theres has been a previously expanded cell, minimize it
        if (previousIndexPath != nil && previousTableView != nil){
            //[self minimizeDetails];
        }
        
        //keep track of the last expanded cell
        previousTableView = tableView;
        previousIndexPath = indexPath;
    }*/
    
    [tableView endUpdates]; // tell the table you're done making your changes
}

//hides details when cell is expanded
-(void)delayedMethodExpand:(NSArray *)array{
    UITableView *tableView = [array objectAtIndex:0];
    NSIndexPath *indexPath = [array objectAtIndex:1];
    LeagueCustomView *cell = (LeagueCustomView *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5];
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//used to hide previous cell (fixes bug)
-(void)minimizeDetails:(NSArray*)array{
    UITableView *tableView = [array objectAtIndex:1];
    NSIndexPath *indexPath = [array objectAtIndex:0];
    LeagueCustomView *cell = (LeagueCustomView *)[tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:0/255 alpha:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
