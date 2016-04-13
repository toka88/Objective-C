//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// DIGITAL ATRIUM
//
// DistanceInfoViewController.m
//
// Author IDENTITY:
//		Apple		3/29/16	
//

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import "DistanceInfoViewController.h"
#import "InfoView.h"
#import "LocationHandler.h"



//________________________________________________________________________________//
//________________________________________________________________________________//
@interface DistanceInfoViewController ()


@property(strong, nonatomic) InfoView* maxSpeedView;
@property(strong, nonatomic) InfoView * averageSpedView;
@property(strong, nonatomic) InfoView * minSpeedView;
@property(strong, nonatomic) InfoView * distanceView;

@property(strong, nonatomic) UIButton * showResutButton;

@end

//________________________________________________________________________________//
//________________________________________________________________________________//
#pragma mark -
@implementation DistanceInfoViewController

-(void)viewDidLoad{
    
    
    
    self.maxSpeedView = [[InfoView alloc] initWithFrame:CGRectMake(10, 84, self.view.frame.size.width - 20, 50)];
    [self.maxSpeedView setData:@"Max Speed" text:@""];
    [self.view addSubview:self.maxSpeedView];
    
    
    
    
    self.averageSpedView = [[InfoView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.maxSpeedView.frame)+20, self.view.frame.size.width - 20, 50)];
    [self.averageSpedView setData:@"Average Speed" text:@""];
    [self.view addSubview:self.averageSpedView];
    
    
    
    
    self.minSpeedView = [[InfoView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.averageSpedView.frame)+20, self.view.frame.size.width - 20, 50)];
    [self.minSpeedView setData:@"Min Speed" text:@""];
    [self.view addSubview:self.minSpeedView];
    
    
    
    self.distanceView = [[InfoView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.minSpeedView.frame)+20, self.view.frame.size.width - 20, 50)];
    [self.distanceView setData:@"Distance" text:@""];
    [self.view addSubview:self.distanceView];
    
    
    
    
    self.showResutButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 60,CGRectGetMaxY(self.distanceView.frame)+50, 120, 40)];
    
    [self.showResutButton setTitle:@"Show result" forState:UIControlStateNormal];
    [self.showResutButton addTarget:self action:@selector(showResult) forControlEvents:UIControlEventTouchUpInside];
    [self.showResutButton setBackgroundColor:[UIColor whiteColor]];
    [self.showResutButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:self.showResutButton];
    
    
    
    
}


-(void)showResult{
    
    LocationHandler* handler = [[LocationHandler alloc] init];
    handler.locations = self.locations;
    
    
    //-------------Update maxSpeedView data
    [handler maxSpeed:^(BOOL aSuccessful, double maxSpeed) {
        if (aSuccessful) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.maxSpeedView setData:@"MAX Speed:" text:[NSString stringWithFormat:@"%.2f km/h",maxSpeed]];
                
            });
            
        }
    }];
    
    
    
    //--------------Update averageSpeedView data
    [handler averageSpeed:^(BOOL aSuccessful, double averageSpeed) {
        if (aSuccessful) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.averageSpedView setData:@"Average Speed:" text:[NSString stringWithFormat:@"%.2f km/h", averageSpeed]];
                
            });
            
        }
    }];
    
    
    //----------------Update minSpeedView data
    [handler minSpeed:^(BOOL aSuccessful, double minSpeed) {
        if (aSuccessful) {
            dispatch_async(dispatch_get_main_queue(), ^{
            [self.minSpeedView setData:@"MIN Speed:" text:[NSString stringWithFormat:@"%.2f km/h",minSpeed]];
            });
        }
    }];
    
    
    //--------------Distance view
    [handler distance:^(BOOL aSuccessful, double distance) {
        if (aSuccessful) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.distanceView setData:@"Distance:" text:[NSString stringWithFormat:@"%.2f km", distance ]];
            });
            
        }
    }];
    
    
}

@end
