//________________________________________________________________________________//
//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// Written by DIGITAL ATRIUM
//
// WeatherViewController.h
//
// Author:
//		Goran Tokovic		4/4/16
//    

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import <UIKit/UIKit.h>


////////////////////////////////////////////////////////////////////////////////
//________________________________________________________________________________//
//________________________________________________________________________________//
/**
 *
 */
@interface WeatherViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource>

@property(assign, nonatomic) double latitude;
@property(assign, nonatomic) double longitude;

@end

