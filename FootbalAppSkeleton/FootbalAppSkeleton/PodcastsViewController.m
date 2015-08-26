//
//  PodcastsViewController.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 16/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "PodcastsViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface PodcastsViewController (){
    Reachability *internetReachableFoo;
}

@end

@implementation PodcastsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = NO;
    //self.navigationController.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:60.0/255.0 blue:0/255.0 alpha:1];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    //self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0/255.0 green:60.0/255.0 blue:0/255.0 alpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:35/255.0 green:70.0/255.0 blue:35/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    
    [self testInternetConnection];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Podcasts";
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        NSString *embedHTML = @"<iframe width='100%' height='100%' scrolling='yes' frameborder='yes' src='https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/users/68929658&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;visual=true&amp;font=System 23.0&amp'></iframe>";
        
        NSString *html = [NSString stringWithFormat:@"%@" ,embedHTML];
        
        [_podcast loadHTMLString:html baseURL:nil];
        [self.view addSubview:_podcast];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    
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
        //dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Yayyy, we have the interwebs!");
        //});
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        //dispatch_async(dispatch_get_main_queue(), ^{
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
