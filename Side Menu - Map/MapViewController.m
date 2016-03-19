//
//  MapViewController.m
//  Side Menu - Map
//
//  Created by Apple on 3/17/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import "MapViewController.h"
#import "SWRevealViewController.h"
#import "PushButtonView.h"


#import <MapKit/MapKit.h>

@interface MapViewController()

@property(strong, nonatomic) UIButton* currentLocationButton;

@property(strong, nonatomic) UIButton* changeStyleButton;

@property(strong, nonatomic) MKMapView* mapView;

@property(strong, nonatomic) PushButtonView* zoomIn;
@property(strong, nonatomic) PushButtonView* zoomOut;

@property(strong, nonatomic) CLLocationManager * locationMenager;
@property(strong, nonatomic) UIButton* startButton;
@property(strong,nonatomic) UIButton* stopButton;
@property(assign, nonatomic) BOOL isStarted;



@property(assign, nonatomic) int counter;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self UIInit];
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


-(void)UIInit{
    
    self.view.backgroundColor = [UIColor clearColor];
    
    _counter = 0;
    
    // Gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = @[(id)[[UIColor colorWithRed:0.749 green:0.749 blue:0.749 alpha:1]CGColor],(id)[[UIColor colorWithRed:0.07854 green:0.07854 blue:0.07854 alpha:1]CGColor]];
    
    [self.view.layer addSublayer:gradient];
    
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController panGestureRecognizer];
    
    //Menu button
    
    UIImage* buttonImage = [[UIImage imageNamed:@"menu_icon (1).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    CGRect rect = CGRectMake(10, 0, 30, 25);
    
    UIButton* customButton = [[UIButton alloc] initWithFrame:rect];
    
    [customButton setImage:buttonImage forState:UIControlStateNormal];
    
    customButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [customButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    customButton.imageView.tintColor = [UIColor blackColor ];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    
    
    
    
    //Location
    
    _locationMenager = [CLLocationManager new];
    [_locationMenager setDelegate:self];
    [_locationMenager requestAlwaysAuthorization];
    
    
    //Map
    
    
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(20, 84, self.view.frame.size.width - 40, self.view.frame.size.width - 40)];
    
    _mapView.layer.cornerRadius = 10;
    
    [_mapView setDelegate:self];
    _mapView.mapType = MKMapTypeStandard;
    
    
    NSLog(@"%@",self.mapView.userLocation.title);
    NSLog(@"%f", self.mapView.userLocation.location.coordinate.latitude);
    
    [_mapView setShowsUserLocation:YES];
    
    [self.view addSubview:_mapView];
    
    
    
    self.changeStyleButton = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.mapView.frame)+20, 80, 30)];
    
    [self.changeStyleButton addTarget:self action:@selector(changeStyle) forControlEvents:UIControlEventTouchUpInside];
    self.changeStyleButton.backgroundColor = [UIColor whiteColor];
    self.changeStyleButton.layer.cornerRadius = 5;
    [self.changeStyleButton setTitle:@"Style" forState:UIControlStateNormal];
    
    [self.changeStyleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.changeStyleButton.titleLabel.font = [UIFont systemFontOfSize:12];
    self.changeStyleButton.tintColor = [UIColor blackColor];
    
    [self.view addSubview:self.changeStyleButton];
    
    _currentLocationButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.changeStyleButton.frame)+ 10 , CGRectGetMaxY(self.mapView.frame)+20, 80, 30)];
    
    
    _currentLocationButton.backgroundColor = [UIColor whiteColor];
    _currentLocationButton.layer.cornerRadius = 5;
    [_currentLocationButton setTitle:@"My Location" forState:UIControlStateNormal];
    
    [_currentLocationButton addTarget:self action:@selector(showCurrentLocation) forControlEvents:UIControlEventTouchUpInside];
    
    [_currentLocationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _currentLocationButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_currentLocationButton];
    
    
    self.zoomIn = [[PushButtonView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.mapView.frame) + 20, CGRectGetMinY(self.mapView.frame)+20, 20, 20)];
    self.zoomIn.isAddButton = true;
    
    self.zoomIn.fillColor = [UIColor colorWithWhite:0.4 alpha:0.4];
    self.zoomIn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    
    [self.zoomIn addTarget:self action:@selector(zoomInMap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.zoomIn];
    
    
    
    
    self.zoomOut = [[PushButtonView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.mapView.frame)+20, CGRectGetMaxY(self.zoomIn.frame)+20, 20, 20)];
    self.zoomOut.isAddButton = false;
    self.zoomOut.fillColor = [UIColor colorWithWhite:0.4 alpha:0.4];
    
    self.zoomOut.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    [self.zoomOut addTarget:self action:@selector(zoomOutMap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.zoomOut];
    
    
    
    //Start - stop
    
    _isStarted = false;
    
    _startButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_currentLocationButton.frame) +30 , CGRectGetMaxY(_mapView.frame)+20, 50, 30)];
    [_startButton addTarget:self action:@selector(startDrawingPath) forControlEvents:UIControlEventTouchUpInside];
    [_startButton setTitle:@"Start" forState:UIControlStateNormal];
    [_startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_startButton setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_startButton];
    
    
    _stopButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_startButton.frame) +10 , CGRectGetMaxY(_mapView.frame)+20, 50, 30)];
    [_stopButton addTarget:self action:@selector(stopDrawingPath) forControlEvents:UIControlEventTouchUpInside];
    [_stopButton setTitle:@"Stop" forState:UIControlStateNormal];
    [_stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_stopButton setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_stopButton];
    
}

-(void)stopDrawingPath{
    
    _isStarted = false;
}

-(void)startDrawingPath{
    
    _isStarted = true;
}


-(void)showCurrentLocation{
    
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

- (void)zoomInMap {
    MKCoordinateRegion region = self.mapView.region;
    region.span.latitudeDelta /= 2.0;
    region.span.longitudeDelta /= 2.0;
    [self.mapView setRegion:region animated:YES];
}

- (void)zoomOutMap{
    MKCoordinateRegion region = self.mapView.region;
    region.span.latitudeDelta  = MIN(region.span.latitudeDelta  * 2.0, 180.0);
    region.span.longitudeDelta = MIN(region.span.longitudeDelta * 2.0, 180.0);
    [self.mapView setRegion:region animated:YES];
}


-(void)changeStyle{
    
    if (self.counter<2) {
        self.counter++;
    }else{
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


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    if (_isStarted) {
        [self.mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.009f, 0.009f)) animated:YES];
    }
    
  //  [self.mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.009f, 0.009f)) animated:YES];
    
//    float spanX = 0.00725;
//    float spanY = 0.00725;
//    MKCoordinateRegion region;
//    region.center.latitude = self.mapView.userLocation.coordinate.latitude;
//    region.center.longitude = self.mapView.userLocation.coordinate.longitude;
//    region.span.latitudeDelta = spanX;
//    region.span.longitudeDelta = spanY;
//    
//    [self.mapView setRegion:region animated:YES];
    
}





@end
