//________________________________________________________________________________//
//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// Written by DIGITAL ATRIUM
//
// WeatherBaseService.h
//
// Author:
//		Goran Tokovic		4/1/16
//    

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import <Foundation/Foundation.h>
#import "Constants.h"

////////////////////////////////////////////////////////////////////////////////
//________________________________________________________________________________//
//________________________________________________________________________________//
/**
 *
 */
@interface WeatherBaseService : NSObject


+(WeatherBaseService*) sharedInstance;

-(void)loadWeatherDataFromUrl:(NSString*)url withCompletion:(WeatherLoadingCompletionBlock) aCompletion withParams:(NSDictionary*) params;


@end

