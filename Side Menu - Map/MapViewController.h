//
//  MapViewController.h
//  Side Menu - Map
//
//  Created by Apple on 3/17/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import "OverlaySelectionView.h"
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

typedef struct {
    CLLocationDegrees minLatitude;
    CLLocationDegrees maxLatitude;
    CLLocationDegrees minLongitude;
    CLLocationDegrees maxLongitude;
} LocationBounds;

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, OverlaySelectionViewDelegate>

@end
