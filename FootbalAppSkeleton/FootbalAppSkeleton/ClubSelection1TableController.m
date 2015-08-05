//
//  ClubSelection1TableController.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 05/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "ClubSelection1TableController.h"

@interface ClubSelection1TableController ()

@end

@implementation ClubSelection1TableController

@synthesize clubMenu;
@synthesize leagueForClubChosen;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    clubMenu = [self populateClubMenu];
}

- (NSArray *)populateClubMenu
{
    static NSArray *_clubMenu;
    
    // This will only be true the first time the method is called...
    //
    if (_clubMenu == nil)
    {
        _clubMenu = [[NSArray alloc] initWithObjects:@"WSL1", @"WSL2", @"WPL: Northern Division", @"WPL: Southern Division",@"Welsh Premier League", nil];
    }
    return _clubMenu;
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
    return clubMenu.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomCellView";
    
    CustomCellView *cell = (CustomCellView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCellView" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.cellLabel.text = clubMenu[indexPath.row];
    
    //add grey arow to each cell
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClubSelection2TableController *clubView2 = [[ClubSelection2TableController alloc] initWithNibName:@"ClubSelection2TableController" bundle:nil];
    
    leagueForClubChosen = clubMenu[indexPath.row];
    
    // Pass the selected object to the new view controller and object class
    clubView2.leagueForClubSelected = leagueForClubChosen;
    
    
    // Push the view controller.
    [self.navigationController pushViewController:clubView2 animated:YES];
    
    //set title
    [[clubView2 navigationItem] setTitle:leagueForClubChosen];
    
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
