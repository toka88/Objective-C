//________________________________________________________________________________//
//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// Written by DIGITAL ATRIUM
//
// Weather.h
//
// Author:
//		Goran Tokovic		4/1/16
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
@interface Weather : NSObject



-(void)parseJSON:(NSDictionary*)dict;


-(void)setData:(NSString*)country city:(NSString*)city tenDaysWeather:(NSArray*) tenDaysData;


-(NSString*)getCountryName;
-(NSString*)getCityName;

-(double)getCurrentTemperatureInCelsius;
-(NSString*)getCirrentIconURL;
-(NSString*)getCurrentWeatherDescription;

- (NSArray*)getIconURLs;
- (NSArray*)getWeatherDescriptions;
-(NSArray*)getTemperatures;

-(int)getNumOfDays;

@end

