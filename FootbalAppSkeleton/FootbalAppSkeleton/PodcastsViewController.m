//
//  PodcastsViewController.m
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 16/08/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import "PodcastsViewController.h"

@interface PodcastsViewController ()

@end

@implementation PodcastsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSString *embedHTML = @"<iframe width='60%' height='100%' scrolling='yes' frameborder='yes' src='https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/users/68929658&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;visual=true&amp;font=System 23.0&amp'></iframe>";
    
    NSString *html = [NSString stringWithFormat:@"%@" ,embedHTML];
    
    [_podcast loadHTMLString:html baseURL:nil];
    [self.view addSubview:_podcast];
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
