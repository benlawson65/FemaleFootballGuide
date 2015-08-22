//
//  ViewController.h
//  FootbalAppSkeleton
//
//  Created by Homer Simpson on 24/07/2015.
//  Copyright (c) 2015 Ben Lawson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)leagueButton:(id)sender;
- (IBAction)fixturesButton:(id)sender;
- (IBAction)clubsButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *leagueVariable;
@property (weak, nonatomic) IBOutlet UIButton *fixtureVariable;
@property (weak, nonatomic) IBOutlet UIButton *podcastsVariable;
@property (weak, nonatomic) IBOutlet UILabel *extraText;


@end
