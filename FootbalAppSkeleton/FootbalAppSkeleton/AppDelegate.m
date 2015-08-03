//
//  AppDelegate.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 24/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MatchFinderViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [GMSServices provideAPIKey:@"AIzaSyCaIAN-DDnSolU0EpBfcTsOhsJyrSwF76s"];
    
    UITabBarController *myTabBarController = [[TabBarController alloc] initWithNibName:@"TabBarController" bundle:nil];
    
    UIViewController *myMatchFinderViewController = [[MatchFinderViewController alloc] initWithNibName:@"MatchFinderViewController" bundle:nil];
    
    UIViewController *myViewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    UINavigationController *myNavigationController = [[UINavigationController alloc] initWithRootViewController:myViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    myTabBarController.viewControllers = [NSArray arrayWithObjects:myNavigationController, myMatchFinderViewController, nil];

    //root view controller
    self.window.rootViewController = myTabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
