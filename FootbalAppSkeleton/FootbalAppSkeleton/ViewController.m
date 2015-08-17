//
//  ViewController.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 24/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "ViewController.h"
#import "LeagueMenuTableViewController.h"
#import "FixturesTableViewController.h"
#import "ClubSelection1TableController.h"
#import "PodcastsViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.leagueVariable.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
    self.fixtureVariable.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
    self.podcastsVariable.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
    
    self.navigationController.navigationBar.topItem.title = @"";
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title = NSLocalizedString(@"Stats", @"Clubs, Leagues and Fixtures");
    }
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)leagueButton:(id)sender {
    UITableViewController *leagueMenuView = [[LeagueMenuTableViewController alloc] initWithNibName:@"LeagueMenuTableViewController" bundle:nil];

    
    [self.navigationController pushViewController:leagueMenuView animated:YES];
    
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""style:UIBarButtonItemStylePlain
                                     target:nil
                                     action:nil];
    
    [[leagueMenuView navigationItem] setTitle:@"Leagues"];

}

- (IBAction)fixturesButton:(id)sender {
    UITableViewController *fixtureView = [[FixturesTableViewController alloc] initWithNibName:@"FixturesTableViewController" bundle:nil];
    
    [self.navigationController pushViewController:fixtureView animated:YES];
    
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    
    [[fixtureView navigationItem] setTitle:@"Fixtures (Choose by League)"];
    
}
/*
- (IBAction)clubsButton:(id)sender {
    
    UITableViewController *clubView = [[ClubSelection1TableController alloc] initWithNibName:@"ClubSelection1TableController" bundle:nil];
    
    [self.navigationController pushViewController:clubView animated:YES];
    
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    
    [[clubView navigationItem] setTitle:@"Clubs (Choose by League)"];
}
*/
- (IBAction)clubsButton:(id)sender {
    
    UIViewController *podView = [[PodcastsViewController alloc] initWithNibName:@"PodcastsViewController" bundle:nil];
    
    [self.navigationController pushViewController:podView animated:YES];
    
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    
    [[podView navigationItem] setTitle:@"Clubs (Choose by League)"];
}
@end
