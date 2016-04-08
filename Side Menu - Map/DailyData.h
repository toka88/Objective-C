//________________________________________________________________________________//
//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// Written by DIGITAL ATRIUM
//
// DailyData.h
//
// Author:
//		Goran Tokovic		4/8/16
//

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import <Foundation/Foundation.h>

////////////////////////////////////////////////////////////////////////////////
//________________________________________________________________________________//
//________________________________________________________________________________//
/**
 *
 */
@interface DailyData : NSObject

- (void)setDailyData:(double)temperature iconURL:(NSString*)url weatherDescription:(NSString*)description;

-(double)getTemperature;
-(NSString*)getIconURL;
-(NSString*)getWeatherDescription;


@end