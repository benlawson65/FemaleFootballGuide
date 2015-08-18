//
//  FixturesTableViewController.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 29/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixturesTableViewController.h"
#import "FixtureDetailTableViewController.h"

@interface FixturesTableViewController ()

@end

@implementation FixturesTableViewController

@synthesize fixtureMenu;
@synthesize fixtureChosen;

- (void)viewDidLoad {
    [super viewDidLoad];
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
     fixtureMenu = [self populateFixtureMenu];
}

- (NSArray *)populateFixtureMenu
{
    static NSArray *_fixtureMenu;
    
    // This will only be true the first time the method is called...
    //
    if (_fixtureMenu == nil)
    {
        _fixtureMenu = [[NSArray alloc] initWithObjects:@"WSL1", @"WSL2", @"WPL: Northern Division", @"WPL: Southern Division",@"Welsh Premier League",@"Scottish Premier League", nil];
    }
    return _fixtureMenu;
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
    return fixtureMenu.count;
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
    
    cell.cellLabel.text = fixtureMenu[indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    
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
    
    FixtureDetailTableViewController *fixtureDetailViewController = [[FixtureDetailTableViewController alloc] initWithNibName:@"FixtureDetailTableViewController" bundle:nil];
    
    fixtureChosen = fixtureMenu[indexPath.row];
    
    // Pass the selected object to the new view controller.
    fixtureDetailViewController.fixtureSelected = fixtureChosen;
    
    // Push the view controller.
    [self.navigationController pushViewController:fixtureDetailViewController animated:YES];
    
    //set title
    [[fixtureDetailViewController navigationItem] setTitle:fixtureChosen];
    
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
