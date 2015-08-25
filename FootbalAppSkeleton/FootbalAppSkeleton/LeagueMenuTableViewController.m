//
//  LeagueMenuTableViewController.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 27/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "LeagueMenuTableViewController.h"
#import "Reachability.h"

@interface LeagueMenuTableViewController (){
    Reachability *internetReachableFoo;
}

@end

@implementation LeagueMenuTableViewController

@synthesize leagueMenu;
@synthesize leagueChosen;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testInternetConnection];
    self.tableView.backgroundColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    
    leagueMenu = [self populateLeagueMenu];
}

// Checks if we have an internet connection or not
- (void)testInternetConnection
{
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    __weak typeof(self) weakSelf = self;
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
      //  dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Yayyy, we have the interwebs!");
       // });
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
       // dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Someone broke the internet :(");
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet Connection"
                                                                                     message:@"Please connect to the internet or try again in a minute"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action){
                                                                 [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                                                             }]; //You can use a block here to handle a press on this button
            [alertController addAction:actionOk];
            
            //[alertController dismissViewControllerAnimated:YES completion:nil];
            //[self.navigationController pushViewController:myViewController animated:YES];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
            //[[self navigationController] pushViewController:myViewController animated:YES];
            
       // });
    };
    
    [internetReachableFoo startNotifier];
}

- (NSArray *)populateLeagueMenu
{
    static NSArray *_leagueMenu;
    
    // This will only be true the first time the method is called...
    //
    if (_leagueMenu == nil)
    {
        _leagueMenu = [[NSArray alloc] initWithObjects:@"Welsh Premier League",@"Scottish Premier League", nil];
    }
    
    return _leagueMenu;
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
    return leagueMenu.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *CellIdentifier = @"CustomCellView";
    
    CustomCellView *cell = (CustomCellView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCellView" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    //add grey arow to each cell
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    cell.cellLabel.text = leagueMenu[indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.textLabel.text = leagueMenu[indexPath.row];
    
    return cell;
}
 */

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 86;
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



// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for exdample:
    // Create the next view controller.
    LeagueDetailTableViewController *leagueDetailViewController = [[LeagueDetailTableViewController alloc] initWithNibName:@"LeagueDetailTableViewController" bundle:nil];
     
     leagueChosen = leagueMenu[indexPath.row];
    
    // Pass the selected object to the new view controller.
     leagueDetailViewController.leagueSelected = leagueChosen;
     
    // Push the view controller.
    [self.navigationController pushViewController:leagueDetailViewController animated:YES];
    
     //set title
     [[leagueDetailViewController navigationItem] setTitle:leagueChosen];
     
     //set back button
     self.navigationItem.backBarButtonItem =
     [[UIBarButtonItem alloc] initWithTitle:@""style:UIBarButtonItemStylePlain
                                     target:nil
                                     action:nil];
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
