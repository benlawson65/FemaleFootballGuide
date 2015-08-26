//
//  FixturesTableViewController.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 29/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "FixturesTableViewController.h"
#import "FixtureDetailTableViewController.h"
#import "Reachability.h"
#import "ViewController.h"

// Add this to the interface in the .m file of your view controller

@interface FixturesTableViewController (){
    Reachability *internetReachableFoo;
}

@end

@implementation FixturesTableViewController

@synthesize fixtureMenu;
@synthesize fixtureChosen;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroud"]];
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

     fixtureMenu = [self populateFixtureMenu];
}
-(void)viewDidAppear:(BOOL)animated{
    [self testInternetConnection];
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
       // dispatch_async(dispatch_get_main_queue(), ^{
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
                                                                                     message:@"Please connect to the internet and try again in a minute"
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

- (NSArray *)populateFixtureMenu
{
    static NSArray *_fixtureMenu;
    
    // This will only be true the first time the method is called...
    //
    if (_fixtureMenu == nil)
    {
        _fixtureMenu = [[NSArray alloc] initWithObjects:@"WSL1", @"WSL2", @"WPL: Northern Division", @"WPL: Southern Division",@"WPL: Northern One",@"WPL: South East One",@"WPL: South West One",@"WPL: Midlands One",@"Welsh Premier League",@"Scottish Premier League", nil];
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
    
    //cell.backgroundColor = [UIColor clearColor];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backView;
    cell.backgroundColor = [UIColor clearColor];
    UIView * selectedBackgroundViewForCell = [[UIView alloc] init];
    [selectedBackgroundViewForCell setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.3]];
    cell.selectedBackgroundView = selectedBackgroundViewForCell;
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
