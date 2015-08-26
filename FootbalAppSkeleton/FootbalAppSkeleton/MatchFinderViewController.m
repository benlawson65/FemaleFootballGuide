//
//  MatchFinderViewController.m
//  
//
//  Created by Homer Simpson on 25/07/2015.
//
//

#import "MatchFinderViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "ViewController.h"

@interface MatchFinderViewController (){
    Reachability *internetReachableFoo;

}

@end

@implementation MatchFinderViewController{
    GMSMapView *mapView_;
    CLLocationManager *locationManager;
    

    
}
//@synthesize locationManager;

static NSString* snippetUpdate;
static BOOL internetCheckFinished;
@synthesize noLocationFound;
static BOOL locationWorks;
static BOOL firstLoad;

- (void)viewDidLoad {
    [super viewDidLoad];
    firstLoad = TRUE;
    locationWorks = FALSE;
    [self testInternetConnection];
    noLocationFound = TRUE;
    // Do any additional setup after loading the view from its nib.

    //[self testInternetConnection];
    //init array for holding list of polylines for directions to fixture
    }
-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    if(!firstLoad){
        if(!locationWorks){
            [self testInternetConnection];
        }
    }
}



-(void)noInternetAlertView{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet Connection"
                                                                             message:@"Please connect to the internet or try again in a minute"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    //ViewController myViewController = [[ViewController alloc] init];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action){
                                                         locationWorks = FALSE;
                                                         [self.navigationController popViewControllerAnimated:YES];
                                                     }]; //You can use a block here to handle a press on this button
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
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
       dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Yayyy, we have the interwebs!");
        [Location initPolyLines];
        
        //shows loading label on the page while view is loading
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
        hud.labelText = @"Finding Location...";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = weakSelf;
            locationManager.distanceFilter = kCLDistanceFilterNone;
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
            [locationManager requestWhenInUseAuthorization];
            [locationManager startMonitoringSignificantLocationChanges];
            [locationManager startUpdatingLocation];
         //   [self setLocation];
            
            NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
            
            NSLog(@"location: %@", theLocation);
            //while(locationManager.location.coordinate.latitude == 0 && locationManager.location.coordinate.longitude == 0){
            //    [self deviceLocation];
            //}
            
           // [self setLocation];
            // [self performSelector:@selector(deviceLocation) withObject:nil afterDelay:5 ];
            
            
            
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
        
        
        

        });
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Someone broke the internet :(");
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet Connection"
                                                                                     message:@"Please connect to the internet or try again in a minute"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            //ViewController myViewController = [[ViewController alloc] init];
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action){
                                                                locationWorks = FALSE;
                                                                 //[weakSelf.navigationController popToViewController:myViewController animated:YES];
                                                                 [weakSelf.tabBarController setSelectedIndex:0];
                                                                 firstLoad = FALSE;
                                                                 //[weakSelf.]
                                                                 //[weakSelf presentViewController:myViewController animated:YES completion:nil];
                                                             }]; //You can use a block here to handle a press on this button
            [alertController addAction:actionOk];
            
            //[alertController dismissViewControllerAnimated:YES completion:nil];
            //[self.navigationController pushViewController:myViewController animated:YES];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
            //[[self navigationController] pushViewController:myViewController animated:YES];
            
        });
        internetCheckFinished = TRUE;
    };
    
    [internetReachableFoo startNotifier];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Location Not Available"
                                                                             message:@"Please allow the app to use location"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    //ViewController myViewController = [[ViewController alloc] init];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action){
                                                         firstLoad = FALSE;
                                                         locationWorks = FALSE;
                                                         //[weakSelf.navigationController popToViewController:myViewController animated:YES];
                                                         [self.tabBarController setSelectedIndex:0];
                                                         //[weakSelf.]
                                                         //[weakSelf presentViewController:myViewController animated:YES completion:nil];
                                                     }]; //You can use a block here to handle a press on this button
    [alertController addAction:actionOk];
    
    //[alertController dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController pushViewController:myViewController animated:YES];
    [self presentViewController:alertController animated:YES completion:nil];
    //[[self navigationController] pushViewController:myViewController animated:YES];
    noLocationFound = TRUE;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [locationManager stopUpdatingLocation];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Match Finder...";
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
    NSLog(@"didUpdateToLocation: %@", newLocation);
        
    GMSCameraPosition* camera =
    [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude zoom: 8];
    //      [GMSCameraPosition cameraWithTarget: currentPosition zoom: 10];
    mapView_.camera = camera;
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    
    Location *locationObj = [[Location alloc] init];
    [locationObj getAllFixtures];
    [locationObj cycleThroughFixtures];
    
    NSMutableArray *returnedFixtures = [Location returnAllFixtures];
    NSInteger i = 0;
    
    
    
    for (i = 0; i < [returnedFixtures count]; i++){
        
        locationObj = [returnedFixtures objectAtIndex:i];
        
        NSString *snippet = locationObj.snippet;
        snippetUpdate = snippet;
        
        
        
        CLLocationCoordinate2D location = [Location getLocationFromAddressString:locationObj.venue];
        
        if (location.longitude == 0.000000 && location.latitude == 0.000000){
            GMSMarker *testMarker = [[GMSMarker alloc] init];
            location.longitude = location.longitude + i;
            testMarker.position = location;
            testMarker.title = locationObj.venue;
            testMarker.snippet = snippet;
            testMarker.map = mapView_;
            
        }
        else if(!(location.longitude == 0.000001 && location.latitude == 0.000001)){
            GMSMarker *testMarker = [[GMSMarker alloc] init];
            testMarker.position = location;
            testMarker.title = locationObj.venue;
            testMarker.snippet = snippet;
            testMarker.map = mapView_;
        }
        
        
    }

    
    self.view = mapView_;
    mapView_.delegate = self;
    noLocationFound = YES;
        locationWorks = TRUE;
        firstLoad = FALSE;
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    });
    
}


-(void)setLocation {
    GMSCameraPosition* camera =
    [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude zoom: 8];
    //      [GMSCameraPosition cameraWithTarget: currentPosition zoom: 10];
    mapView_.camera = camera;
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    
    self.view = mapView_;
    mapView_.delegate = self;

}

- (void)deviceLocation {
    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
    NSLog(@"location: %@", theLocation);
}



-(BOOL) mapView:(GMSMapView *) mapView
didTapMarker:(GMSMarker *)marker{
    //convert maker location
    CLLocation *markerLocation = [[CLLocation alloc] initWithLatitude:marker.position.latitude longitude:marker.position.longitude];
    
    //run get directions method and send it origin and destination location from user location to
    //markerlocation
    [Location resetPolyLines];
    [Location getDirections:locationManager.location toDestination:markerLocation onMap:mapView];

            NSString *durationLocation = [Location getDuration];
            NSString *distanceLocation = [Location getDistance];
            //NSString *snippetUpdateTemp = [NSString stringWithFormat:@"%@ (%@ %@)",snippetUpdate,distanceLocation,durationLocation];
            
        NSString *currentSnippet = [NSString stringWithFormat:@"%@ (%@ %@)",marker.snippet,distanceLocation,durationLocation];

        marker.snippet = currentSnippet;
    
    
    
    return NO;

    
    
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
    self.tabBarItem.image = [UIImage imageNamed:@"Search-25"];
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
