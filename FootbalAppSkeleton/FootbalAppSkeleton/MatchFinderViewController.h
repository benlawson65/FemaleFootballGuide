//
//  MatchFinderViewController.h
//  
//
//  Created by Homer Simpson on 25/07/2015.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface MatchFinderViewController : UIViewController
@property(nonatomic,retain) CLLocationManager *locationManager;
- (void)deviceLocation;
-(void)setLocation;

@end
