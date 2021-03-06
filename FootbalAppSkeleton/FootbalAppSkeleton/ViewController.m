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
#import <sys/sysctl.h>


@interface ViewController ()

@end

@implementation ViewController

@synthesize extraText;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //make top status bar white so it can be seen on black background
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.leagueVariable.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
    self.fixtureVariable.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
    self.podcastsVariable.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
    
    self.navigationController.navigationBar.topItem.title = @"";
    

}

-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //run method to get device model
    NSString *model = [self platformNiceString];
    NSLog(@"%@", model);
    
    //hide extra text if running on iphone 4 or ipad
    if([model isEqualToString:@"iPhone 4"]){
        extraText.hidden = YES;
    }

    
    //set navigation bar to translucent
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    //self.navigationController.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:60.0/255.0 blue:0/255.0 alpha:1];
    //self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0/255.0 green:60.0/255.0 blue:0/255.0 alpha:1];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController setNavigationBarHidden: YES animated:YES];
    
    //[self performSelector:@selector(hideNavbar) withObject:(nil)
//afterDelay:(0.3)];
}
-(void)hideNavbar{
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.translucent = YES;
    
}

//get phone model
-(NSString *)platformRawString{
    size_t size;
    sysctlbyname("hw.machine",NULL,&size,NULL,0);
    
    char *machine = malloc(size);
    
    sysctlbyname("hw.machine",machine,&size,NULL,0);
    
    NSString *platform = [NSString stringWithUTF8String:machine];
    
    free(machine);
    
    return platform;
    
}

-(NSString *)platformNiceString{
    NSString *platform = [self platformRawString];
    
    if ([platform isEqualToString:@"iPhone1,1"]){    return @"iPhone 4";}
    if ([platform isEqualToString:@"iPhone1,2"]){    return @"iPhone 4";}
    if ([platform isEqualToString:@"iPhone2,1"]) {   return @"iPhone 4"; }
    
    
    if([platform isEqualToString:@"iPhone3,1"]){
        return @"iPhone 4";
    }
    if([platform isEqualToString:@"iPhone3,3"]){
        return @"iPhone 4";
    }
    if([platform isEqualToString:@"iPhone4,1"]){
        return @"iPhone 4";
    }
    if([platform isEqualToString:@"iPhone4,2"]){
        return @"iPhone 4";
    }
    if([platform isEqualToString:@"iPhone4,3"]){
        return @"iPhone 4";
    }
    if([platform isEqualToString:@"iPhone4,5"]){
        return @"iPhone 4";
    }
    if([platform isEqualToString:@"iPhone4,6"]){
        return @"iPhone 4";
    }
    if([platform isEqualToString:@"iPhone4,7"]){
        return @"iPhone 4";
    }
    if([platform isEqualToString:@"iPhone4,8"]){
        return @"iPhone 4";
    }
    if([platform isEqualToString:@"iPhone4,9"]){
        return @"iPhone 4";
    }
    
    else {
        return platform;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title = NSLocalizedString(@"Stats", @"Clubs, Leagues and Fixtures");
        self.tabBarItem.image = [UIImage imageNamed:@"Statistics-25"];
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
    
    [[podView navigationItem] setTitle:@"Podcasts"];
}
@end
