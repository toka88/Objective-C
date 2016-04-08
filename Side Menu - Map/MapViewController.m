//
//  MapViewController.m
//  Side Menu - Map
//
//  Created by Apple on 3/17/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import "MapViewController.h"
#import "PushButtonView.h"
#import "SWRevealViewController.h"

#import "DistanceInfoViewController.h"
#import "WeatherViewController.h"

#import <MapKit/MapKit.h>

@interface MapViewController ()

@property (strong, nonatomic) UIButton* currentLocationButton;

@property (strong, nonatomic) UIButton* changeStyleButton;

@property (strong, nonatomic) MKMapView* mapView;

@property (strong, nonatomic) PushButtonView* zoomIn;
@property (strong, nonatomic) PushButtonView* zoomOut;

@property (strong, nonatomic) CLLocationManager* locationMenager;
@property (strong, nonatomic) UIButton* startButton;
@property (strong, nonatomic) UIButton* stopButton;
@property (assign, nonatomic) BOOL isStarted;

@property (strong, nonatomic) CLLocation* lastLocation;
@property (assign, nonatomic) BOOL locationSet;

@property (assign, nonatomic) LocationBounds searchBounds;
@property (strong, nonatomic) OverlaySelectionView* overlay;

@property (assign, nonatomic) BOOL isChangingDimension;

@property (assign, nonatomic) int counter;

@property (strong, nonatomic) UIColor* polylineColor;

@property (strong, nonatomic) UILabel* currentSpeedLabel;

@property (strong, nonatomic) UILabel* distanceLabel;
@property (assign, nonatomic) double distance;

@property (strong, nonatomic) UIButton* showResButton;

@property (strong, nonatomic) NSMutableArray* locations;

@property (strong, nonatomic) UILocalNotification* localNotification;

@property (strong, nonatomic) UIBarButtonItem* weatherButton;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self UIInit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)UIInit
{
    self.view.backgroundColor = [UIColor clearColor];

    self.isChangingDimension = false;

    _counter = 0;

    // Gradient
    CAGradientLayer* gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = @[
        (id)[[UIColor colorWithRed:0.749 green:0.749 blue:0.749 alpha:1] CGColor],
        (id)[[UIColor colorWithRed:0.07854
                             green:0.07854
                              blue:0.07854
                             alpha:1] CGColor]
    ];

    [self.view.layer addSublayer:gradient];

    SWRevealViewController* revealController = [self revealViewController];

#pragma mark - Disable panGEstureRecognizer
    // [revealController panGestureRecognizer];

    // Menu button

    UIImage* buttonImage = [[UIImage imageNamed:@"menu_icon (1).png"]
        imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    CGRect rect = CGRectMake(10, 0, 30, 25);

    UIButton* customButton = [[UIButton alloc] initWithFrame:rect];

    [customButton setImage:buttonImage forState:UIControlStateNormal];

    customButton.imageView.contentMode = UIViewContentModeScaleAspectFit;

    [customButton addTarget:revealController
                     action:@selector(revealToggle:)
           forControlEvents:UIControlEventTouchUpInside];

    customButton.imageView.tintColor = [UIColor blackColor];

    UIBarButtonItem* menuButtonItem =
        [[UIBarButtonItem alloc] initWithCustomView:customButton];
    self.navigationItem.leftBarButtonItem = menuButtonItem;

    // Location

    _locationMenager = [CLLocationManager new];
    [_locationMenager setDelegate:self];
    [_locationMenager requestAlwaysAuthorization];
    _locationMenager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationMenager startUpdatingLocation];

    // Map

    _mapView = [[MKMapView alloc]
        initWithFrame:CGRectMake(20, 84, self.view.frame.size.width - 40,
                          self.view.frame.size.width - 40)];

    _mapView.layer.cornerRadius = 10;

    [_mapView setDelegate:self];
    _mapView.mapType = MKMapTypeStandard;

    NSLog(@"%@", self.mapView.userLocation.title);
    NSLog(@"%f", self.mapView.userLocation.location.coordinate.latitude);

    [_mapView setShowsUserLocation:YES];

    _mapView.showsBuildings = NO;
    _mapView.showsCompass = YES;

    [self.view addSubview:_mapView];

    self.changeStyleButton = [[UIButton alloc]
        initWithFrame:CGRectMake(20, CGRectGetMaxY(self.mapView.frame) + 20, 80,
                          30)];

    [self.changeStyleButton addTarget:self
                               action:@selector(changeStyle)
                     forControlEvents:UIControlEventTouchUpInside];
    self.changeStyleButton.backgroundColor = [UIColor whiteColor];
    self.changeStyleButton.layer.cornerRadius = 5;
    [self.changeStyleButton setTitle:@"Style" forState:UIControlStateNormal];

    [self.changeStyleButton setTitleColor:[UIColor blackColor]
                                 forState:UIControlStateNormal];
    self.changeStyleButton.titleLabel.font = [UIFont systemFontOfSize:12];
    self.changeStyleButton.tintColor = [UIColor blackColor];

    [self.view addSubview:self.changeStyleButton];

    _currentLocationButton = [[UIButton alloc]
        initWithFrame:CGRectMake(CGRectGetMaxX(self.changeStyleButton.frame) + 10,
                          CGRectGetMaxY(self.mapView.frame) + 20, 80, 30)];

    _currentLocationButton.backgroundColor = [UIColor whiteColor];
    _currentLocationButton.layer.cornerRadius = 5;
    [_currentLocationButton setTitle:@"My Location"
                            forState:UIControlStateNormal];

    [_currentLocationButton addTarget:self
                               action:@selector(showCurrentLocation)
                     forControlEvents:UIControlEventTouchUpInside];

    [_currentLocationButton setTitleColor:[UIColor blackColor]
                                 forState:UIControlStateNormal];
    _currentLocationButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_currentLocationButton];

    self.zoomIn = [[PushButtonView alloc]
        initWithFrame:CGRectMake(CGRectGetMinX(self.mapView.frame) + 20,
                          CGRectGetMinY(self.mapView.frame) + 20, 20, 20)];
    self.zoomIn.isAddButton = true;

    self.zoomIn.fillColor = [UIColor colorWithWhite:0.4 alpha:0.4];
    self.zoomIn.titleLabel.font = [UIFont boldSystemFontOfSize:20];

    [self.zoomIn addTarget:self
                    action:@selector(zoomInMap)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.zoomIn];

    self.zoomOut = [[PushButtonView alloc]
        initWithFrame:CGRectMake(CGRectGetMinX(self.mapView.frame) + 20,
                          CGRectGetMaxY(self.zoomIn.frame) + 20, 20, 20)];
    self.zoomOut.isAddButton = false;
    self.zoomOut.fillColor = [UIColor colorWithWhite:0.4 alpha:0.4];

    self.zoomOut.titleLabel.font = [UIFont boldSystemFontOfSize:20];

    [self.zoomOut addTarget:self
                     action:@selector(zoomOutMap)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.zoomOut];

    // Start - stop

    _isStarted = false;

    _startButton = [[UIButton alloc]
        initWithFrame:CGRectMake(CGRectGetMaxX(_currentLocationButton.frame) + 30,
                          CGRectGetMaxY(_mapView.frame) + 20, 50, 30)];
    [_startButton addTarget:self
                     action:@selector(startDrawingPath)
           forControlEvents:UIControlEventTouchUpInside];
    [_startButton setTitle:@"Start" forState:UIControlStateNormal];
    [_startButton setTitleColor:[UIColor blackColor]
                       forState:UIControlStateNormal];
    [_startButton setBackgroundColor:[UIColor colorWithRed:0.146171
                                                     green:1.0
                                                      blue:0.135382
                                                     alpha:1.0]];
    [self.view addSubview:_startButton];

    _stopButton = [[UIButton alloc]
        initWithFrame:CGRectMake(CGRectGetMaxX(_startButton.frame) + 10,
                          CGRectGetMaxY(_mapView.frame) + 20, 50, 30)];
    [_stopButton addTarget:self
                    action:@selector(stopDrawingPath)
          forControlEvents:UIControlEventTouchUpInside];
    [_stopButton setTitle:@"Stop" forState:UIControlStateNormal];
    [_stopButton setTitleColor:[UIColor blackColor]
                      forState:UIControlStateNormal];
    [_stopButton setBackgroundColor:[UIColor colorWithRed:1.0
                                                    green:0.0551667
                                                     blue:0.225722
                                                    alpha:1.0]];
    [self.view addSubview:_stopButton];

    _locationSet = false;

    // Overlay

    _overlay = [[OverlaySelectionView alloc] initWithFrame:self.mapView.bounds];
    _overlay.delegate = self;
    [self.mapView addSubview:_overlay];

    // Current speed label
    self.currentSpeedLabel = [[UILabel alloc]
        initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 70,
                          CGRectGetMaxY(self.startButton.frame) + 40, 140,
                          30)];
    [self.currentSpeedLabel setBackgroundColor:[UIColor whiteColor]];
    [self.currentSpeedLabel setTextAlignment:NSTextAlignmentCenter];
    self.currentSpeedLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:self.currentSpeedLabel];
    [self.currentSpeedLabel setText:@"Speed: 0 km/h"];

    // Traveled distance
    self.distance = 0;
    self.distanceLabel = [[UILabel alloc]
        initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50,
                          CGRectGetMaxY(self.currentSpeedLabel.frame) + 20,
                          100, 30)];
    [self.distanceLabel setText:@"0 km"];
    [self.distanceLabel setTextAlignment:NSTextAlignmentCenter];
    [self.distanceLabel setBackgroundColor:[UIColor whiteColor]];
    [self.distanceLabel setTextColor:[UIColor blueColor]];
    [self.distanceLabel.layer setCornerRadius:3.0];
    self.distanceLabel.font = [UIFont boldSystemFontOfSize:12];
    [self.view addSubview:self.distanceLabel];

    self.showResButton = [[UIButton alloc]
        initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 60,
                          CGRectGetMaxY(self.distanceLabel.frame) + 20,
                          120, 30)];
    [self.showResButton setTitle:@"Result" forState:UIControlStateNormal];
    [self.showResButton setTitleColor:[UIColor blackColor]
                             forState:UIControlStateNormal];
    [self.showResButton setBackgroundColor:[UIColor whiteColor]];
    [self.showResButton addTarget:self
                           action:@selector(showResult)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showResButton];

    self.locations = [NSMutableArray new];

    self.weatherButton =
        [[UIBarButtonItem alloc] initWithTitle:@"Weather"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(showWeather)];
    [self.navigationItem setRightBarButtonItem:self.weatherButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self initializeData];
}

- (void)initializeData
{
    self.locations = [NSMutableArray new];
}

- (void)showWeather
{
    WeatherViewController* viewController = [[WeatherViewController alloc] init];
    viewController.latitude = self.mapView.userLocation.location.coordinate.latitude;
    viewController.longitude = self.mapView.userLocation.location.coordinate.longitude;

    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)showResult
{
    DistanceInfoViewController* viewController =
        [[DistanceInfoViewController alloc] init];
    viewController.locations = self.locations;

    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Draw path

- (void)stopDrawingPath
{
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:[self.lastLocation coordinate]];
    [annotation setTitle:@"Stop"];
    [self.mapView addAnnotation:annotation];

    _lastLocation = nil;
    _isStarted = false;
    _locationSet = true;

    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    //   CLLocationCoordinate2D  loc =
    //   CLLocationCoordinate2DMake(self.lastLocation.coordinate.latitude,
    //   self.lastLocation.coordinate.longitude);
}

- (void)startDrawingPath
{
    self.locations = [NSMutableArray new];

    self.distance = 0;
    _isStarted = true;
    _locationSet = false;

    MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:self.mapView.userLocation.coordinate];
    [annotation setTitle:@"Start"];
    [self.mapView addAnnotation:annotation];

    NSLog(@"Start: %f", [self.lastLocation coordinate].latitude);

    // Post notification on screen
    self.localNotification = [[UILocalNotification alloc] init];
    self.localNotification.fireDate =
        [[NSDate alloc] initWithTimeIntervalSinceNow:10];
    self.localNotification.alertBody = @"Tracking is started";
    self.localNotification.alertTitle = @"Notification :-)";
    self.localNotification.timeZone = [NSTimeZone defaultTimeZone];
    self.localNotification.applicationIconBadgeNumber = 1;
    self.localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication]
        presentLocalNotificationNow:self.localNotification];
}

- (void)showCurrentLocation
{
    float spanX = 0.00725;
    float spanY = 0.00725;
    MKCoordinateRegion region;
    region.center.latitude = self.mapView.userLocation.coordinate.latitude;
    region.center.longitude = self.mapView.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;

    [self.mapView setRegion:region animated:YES];
    NSLog(@"%f", self.mapView.userLocation.location.coordinate.latitude);
}

- (void)zoomInMap
{
    MKCoordinateRegion region = self.mapView.region;
    region.span.latitudeDelta /= 2.0;
    region.span.longitudeDelta /= 2.0;
    [self.mapView setRegion:region animated:YES];
}

- (void)zoomOutMap
{
    MKCoordinateRegion region = self.mapView.region;
    region.span.latitudeDelta = MIN(region.span.latitudeDelta * 2.0, 180.0);
    region.span.longitudeDelta = MIN(region.span.longitudeDelta * 2.0, 180.0);
    [self.mapView setRegion:region animated:YES];
}

- (void)changeStyle
{
    if (self.counter < 2) {
        self.counter++;
    }
    else {
        self.counter = 0;
    }

    switch (self.counter) {
    case 0:
        self.mapView.mapType = MKMapTypeStandard;
        break;

    case 1:
        self.mapView.mapType = MKMapTypeSatellite;
        break;

    case 2:
        self.mapView.mapType = MKMapTypeHybrid;
        break;
    }
}

- (void)locationManager:(CLLocationManager*)manager
     didUpdateLocations:(NSArray<CLLocation*>*)locations
{
    if (_isStarted) {
        if (_locationSet) {
            _lastLocation = manager.location;
            _locationSet = true;
        }
        CLLocation* newLocation = [locations firstObject];

        CLLocation* currentLocation = newLocation;

        CLLocationDistance dist =
            [currentLocation distanceFromLocation:_lastLocation];

        if (dist > 100) {
            return;
        }
        if (!_lastLocation) {
            _lastLocation = currentLocation;
            return;
        }

        //
        //        MKPointAnnotation * annotation = [[MKPointAnnotation alloc] init]
        //        ;
        //        [annotation setCoordinate:currentLocation.coordinate];
        //        [annotation setTitle:@"Start"];
        //        [self.mapView addAnnotation:annotation];

        // Update distance label
        self.distance += dist;
        self.distanceLabel.text =
            [NSString stringWithFormat:@"%.2f km", self.distance / 1000];

        [self.locations addObject:currentLocation];

        CLLocationCoordinate2D coordinates[2];
        coordinates[0] = [_lastLocation coordinate];
        coordinates[1] = [currentLocation coordinate];

        _lastLocation = currentLocation;

        MKPolyline* polyline =
            [MKPolyline polylineWithCoordinates:coordinates count:2];

        [_mapView addOverlay:polyline];

        [_mapView
            setRegion:MKCoordinateRegionMake(manager.location.coordinate,
                          MKCoordinateSpanMake(0.009, 0.009))
             animated:YES];

        if (currentLocation.speed < 3.778) {
            self.polylineColor = [UIColor greenColor];
        }
        else if (currentLocation.speed < 19.333) {
            self.polylineColor = [UIColor orangeColor];
        }
        else {
            self.polylineColor = [UIColor redColor];
        }
    }

    CLLocation* newLocation = [locations firstObject];

    [self.currentSpeedLabel
        setText:[NSString stringWithFormat:@"Speed: %.1f km/h",
                          newLocation.speed * 3.6]];
}

- (MKOverlayRenderer*)mapView:(MKMapView*)mapView
           rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer* polylineRender =
        [[MKPolylineRenderer alloc] initWithOverlay:overlay];

    [self.currentSpeedLabel setBackgroundColor:self.polylineColor];

    polylineRender.strokeColor = self.polylineColor;
    polylineRender.lineWidth = 4;
    return polylineRender;
}

#pragma mark - OverlaySelectionViewDelegate

- (void)areaSelected:(CGRect)screenArea
{
    CGPoint point = screenArea.origin;

    point.y -= 0;

    CLLocationCoordinate2D upperLeft =
        [_mapView convertPoint:point toCoordinateFromView:_mapView];
    point.x += screenArea.size.width;
    CLLocationCoordinate2D upperRight =
        [_mapView convertPoint:point toCoordinateFromView:_mapView];
    point.x -= screenArea.size.width;
    point.y += screenArea.size.height;
    CLLocationCoordinate2D lowerLeft =
        [_mapView convertPoint:point toCoordinateFromView:_mapView];
    point.x += screenArea.size.width;
    CLLocationCoordinate2D lowerRight =
        [_mapView convertPoint:point toCoordinateFromView:_mapView];

    _searchBounds.minLatitude = MIN(lowerLeft.latitude, lowerRight.latitude);
    _searchBounds.minLongitude = MIN(upperLeft.longitude, lowerLeft.longitude);
    _searchBounds.maxLatitude = MAX(upperLeft.latitude, upperRight.latitude);
    _searchBounds.maxLongitude = MAX(upperRight.longitude, lowerRight.longitude);

    //    NSLog(@"\n\nMINLatitude: %f",_searchBounds.minLatitude);
    //    NSLog(@"MINLongitude: %f",_searchBounds.minLongitude);
    //    NSLog(@"MAXLatitude: %f",_searchBounds.maxLatitude);
    //    NSLog(@"MAXLongitude: %f",_searchBounds.maxLongitude);
}

- (void)zoomSelectedArea
{
    MKCoordinateSpan span = MKCoordinateSpanMake(
        fabs(self.searchBounds.maxLatitude - self.searchBounds.minLatitude),
        fabs(self.searchBounds.maxLongitude - self.searchBounds.minLongitude));

    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(
        (self.searchBounds.minLatitude + _searchBounds.maxLatitude) / 2,
        (self.searchBounds.minLongitude + _searchBounds.maxLongitude) / 2);

    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);

    [self.mapView setRegion:region animated:YES];
}

- (void)isChangingDimensionOfSelectedArea:(BOOL)isChanging
{
    if (self.isChangingDimension == true && isChanging == false) {
        [self zoomSelectedArea];
        //[self.mapView removeFromSuperview];
    }

    self.isChangingDimension = isChanging;

    self.overlay.dragArea.alpha = isChanging ? 0.3 : 0.0;
}

//-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation
//*)userLocation{
//
//    if (_isStarted) {
//        [self.mapView
//        setRegion:MKCoordinateRegionMake(userLocation.coordinate,
//        MKCoordinateSpanMake(0.009f, 0.009f)) animated:YES];
//
//        CLLocation* currentLocation = userLocation;
//
//
//
//    }

//  [self.mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate,
//  MKCoordinateSpanMake(0.009f, 0.009f)) animated:YES];

//    float spanX = 0.00725;
//    float spanY = 0.00725;
//    MKCoordinateRegion region;
//    region.center.latitude = self.mapView.userLocation.coordinate.latitude;
//    region.center.longitude = self.mapView.userLocation.coordinate.longitude;
//    region.span.latitudeDelta = spanX;
//    region.span.longitudeDelta = spanY;
//
//    [self.mapView setRegion:region animated:YES];

//}

@end
