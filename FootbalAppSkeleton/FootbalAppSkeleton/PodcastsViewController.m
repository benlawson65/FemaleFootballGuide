//
//  PodcastsViewController.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 16/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "PodcastsViewController.h"
#import "MBProgressHUD.h"

@interface PodcastsViewController ()

@end

@implementation PodcastsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
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
