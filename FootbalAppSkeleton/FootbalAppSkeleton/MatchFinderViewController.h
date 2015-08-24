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
#import "Location.h"

@interface MatchFinderViewController : UIViewController <GMSMapViewDelegate>
@property(nonatomic,retain) CLLocationManager *locationManager;
- (void)deviceLocation;
-(void)setLocation;
//-(BOOL) mapView:(GMSMapView *) mapView didTapMarker:(GMSMarker *)marker;
- (void) mapView:(GMSMapView *) mapView
didTapInfoWindowOfMarker:(GMSMarker *) marker;
@property (strong, nonatomic) IBOutlet UILabel *directionBar;

@end
