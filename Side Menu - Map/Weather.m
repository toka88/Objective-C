//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// DIGITAL ATRIUM
//
// Weather.m
//
// Author IDENTITY:
//		Goran Tokovic		4/1/16
//

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import "JSONParserBaseService.h"
#import "Weather.h"
#import "DailyData.h"


//________________________________________________________________________________//
//________________________________________________________________________________//
@interface Weather ()

@property (strong, nonatomic) NSString* iconUrl;
@property (strong, nonatomic) NSString* country;
@property (strong, nonatomic) NSString* city;
@property (assign, nonatomic) double temperature;
@property (strong, nonatomic) NSString* weatherDescription;
@property (strong, nonatomic) NSArray* tenDaysData;

@end

//________________________________________________________________________________//
//________________________________________________________________________________//
#pragma mark -
@implementation Weather

- (void)setData:(NSString*)country city:(NSString*)city  tenDaysWeather:(NSArray*) tenDaysData
{

    
    self.country = country;
    self.city = city;
    self.tenDaysData = tenDaysData;
    
}

- (void)parseJSON:(NSDictionary*)dict
{

    NSLog(@"Response: %@", dict);

    //Temperature
    NSLog(@"***************: %@", dict[@"main"]);
    NSDictionary* main = dict[@"main"];

    NSNumber* temperature = main[@"temp"];
    NSLog(@"\n\nTemperature: %f", [temperature doubleValue]);
    self.temperature = [temperature doubleValue];

    //Country and city
    NSDictionary* sys = dict[@"sys"];
    self.country = sys[@"country"];
    self.city = dict[@"name"];

    //Icon
    NSArray* weather = dict[@"weather"];

    self.weatherDescription = ((NSDictionary*)weather[0])[@"main"];

    NSString* icon = ((NSDictionary*)weather[0])[@"icon"];
    self.iconUrl = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", icon];

    NSLog(@"\n\nCountry: %@\nCity: %@ \nTemperature: %2.1f \nIcon %@ \nWeather description: %@", self.country, self.city, self.temperature, self.iconUrl, self.weatherDescription);
}



- (NSString*)getCityName
{

    return self.city;
}

- (NSString*)getCountryName
{

    return self.country;
}

- (double)getCurrentTemperatureInCelsius
{

    return [((DailyData*)self.tenDaysData[0])  getTemperature];
    
}

-(NSString*)getCirrentIconURL{
    
    return [((DailyData*)self.tenDaysData[0])  getIconURL];
}

-(NSString*)getCurrentWeatherDescription{
    
    return [((DailyData*)self.tenDaysData[0])  getWeatherDescription];
}

- (DailyData*)getWeatherDescriptions:(int)numDaysFromCurrentDate
{

    return self.tenDaysData[numDaysFromCurrentDate];
}

- (NSArray*)getIconURLs
{

    NSMutableArray* urls = [NSMutableArray new];
    
    for (int i = 0;  i < self.tenDaysData.count; i++) {
        [urls addObject:[((DailyData*)self.tenDaysData[i]) getIconURL]];
    }
    
    return urls;
}

-(NSArray*)getTemperatures{
    
    NSMutableArray* temepratures = [NSMutableArray new];
    
    for (int i = 0;  i < self.tenDaysData.count; i++) {
        
        DailyData * data = self.tenDaysData[i];
        
        [temepratures addObject:[NSNumber numberWithDouble:data.getTemperature] ];
    }
    
    return temepratures;
    
}

-(int)getNumOfDays{
    
    return (int)self.tenDaysData.count;
    
}

@end
