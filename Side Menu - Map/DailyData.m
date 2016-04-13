//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// DIGITAL ATRIUM
//
// DailyData.m
//
// Author IDENTITY:
//		Goran Tokovic		4/8/16	
//

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import "DailyData.h"



//________________________________________________________________________________//
//________________________________________________________________________________//
@interface DailyData ()

@property(strong, nonatomic) NSString* iconURL;
@property(strong, nonatomic) NSString* weatherDescription;
@property(assign, nonatomic) double temperature;

@end

//________________________________________________________________________________//
//________________________________________________________________________________//
#pragma mark -
@implementation DailyData

-(void)setDailyData:(double)temperature iconURL:(NSString *)url weatherDescription:(NSString *)description{
    
    self.temperature = temperature;
    self.iconURL = url;
    self.weatherDescription = description;
    
}

-(double)getTemperature{
    return self.temperature - 273.15;
}

-(NSString*)getIconURL{
    return self.iconURL;
    
}

-(NSString*)getWeatherDescription{
    
    return self.weatherDescription;
}


@end
