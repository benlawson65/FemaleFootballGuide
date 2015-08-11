//
//  MatchFinderViewController.m
//  
//
//  Created by Homer Simpson on 25/07/2015.
//
//

#import "MatchFinderViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MatchFinderViewController ()

@end

@implementation MatchFinderViewController{
    GMSMapView *mapView_;
}
@synthesize locationManager;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    [self setLocation];
    
    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
    
    NSLog(@"location: %@", theLocation);
    while(locationManager.location.coordinate.latitude == 0 && locationManager.location.coordinate.longitude == 0){
        [self deviceLocation];
    }
    
    [self setLocation];
   // [self performSelector:@selector(deviceLocation) withObject:nil afterDelay:5 ];
    
    Location *locationObj = [[Location alloc] init];
    [locationObj getAllFixtures];
    [locationObj cycleThroughFixtures];
    
    NSMutableArray *listOfLocations = [[NSMutableArray alloc] init];
    NSMutableArray *returnedFixtures = [Location returnAllFixtures];
    NSInteger i = 0;
    
    for (i = 0; i < [returnedFixtures count]; i++){
        
        locationObj = [returnedFixtures objectAtIndex:i];
        
        NSString *snippet = locationObj.snippet;
    
        
    
        CLLocationCoordinate2D location = [Location getLocationFromAddressString:locationObj.venue];
        NSLog(@"Longditude: %f Latitude: %f Venue: %@",location.longitude, location.latitude, locationObj.venue);
        NSInteger j = 0;
        BOOL duplicateVenueFound = false;
        
        for (j = 0; j < [listOfLocations count]; j++){
            if([locationObj.venue isEqualToString:[listOfLocations objectAtIndex:j]]){
                
                duplicateVenueFound = true;
                j = [listOfLocations count];
            }
            else{
                duplicateVenueFound = false;
            }
        }
        if(!duplicateVenueFound){
            if(!(location.latitude == 0.000000 && location.longitude == 0.00000)) {
            GMSMarker *testMarker = [[GMSMarker alloc] init];
            testMarker.position = location;
            testMarker.title = locationObj.venue;
            testMarker.snippet = snippet;
            testMarker.map = mapView_;
            
            //keep list of locations for stopping multiple markers in same place
            [listOfLocations addObject:locationObj.venue];
            }

        }
        if(location.latitude == 0.000000 && location.longitude == 0.00000 && !duplicateVenueFound){
            location.longitude = location.longitude + i;
            GMSMarker *testMarker = [[GMSMarker alloc] init];
            testMarker.position = location;
            testMarker.title = locationObj.venue;
            testMarker.snippet = snippet;
            testMarker.map = mapView_;
            [listOfLocations addObject:locationObj.venue];
        }
        
        
    }
}

-(void)setLocation {
    GMSCameraPosition* camera =
    [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude zoom: 8];
    //      [GMSCameraPosition cameraWithTarget: currentPosition zoom: 10];
    mapView_.camera = camera;
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    
    
    self.view = mapView_;
}

- (void)deviceLocation {
    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
    NSLog(@"location: %@", theLocation);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title = NSLocalizedString(@"Match Finder", @"Google Maps UI for fixtures");
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

@end
