//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// DIGITAL ATRIUM
//
// WeatherUserService.m
//
// Author IDENTITY:
//		Goran Tokovic		4/5/16	
//

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import "WeatherUserService.h"
#import "WeatherBaseService.h"
#import "Weather.h"
#import "DailyData.h"



//________________________________________________________________________________//
//________________________________________________________________________________//
@interface WeatherUserService ()

@end

//________________________________________________________________________________//
//________________________________________________________________________________//
#pragma mark -
@implementation WeatherUserService


+ (WeatherUserService *)sharedInstance {
    static WeatherUserService *sharedInstance = nil;
    if (!sharedInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedInstance = [[super allocWithZone:NULL] init];
            // custom initialisation
        });
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

-(instancetype)init{
    
    self = [super init];
    if (self) {
        //Initialize data
    }
    return  self;
}



-(void)getWeatherData:(NSString*)url CompletionBlock:(WeatherObjectCompletionBlock)aCompletion{
    
    
    [[WeatherBaseService sharedInstance] loadWeatherDataFromUrl:url withCompletion:^(BOOL aSuccessful, NSError *anError, NSDictionary *dict) {
        
        if (aSuccessful) {
        
        
        NSLog(@"Response: %@", dict);
            
            //Country and city
            NSDictionary* sys = dict[@"city"];
            NSString* country = sys[@"country"];
            NSString* city = sys[@"name"];
            
            NSLog(@"***************************************\n Country: %@, City: %@",country,city);

        
        
        //Temperature
        NSLog(@"***************: %@",dict[@"list"]);
        NSArray* list = dict[@"list"];
            
            NSMutableArray* weatherData = [NSMutableArray new];
            
            
            for (int i = 0; i < list.count; i++) {
                
                NSDictionary* tempDict = ((NSDictionary*) list[i])[@"temp"];
                double temperature = [tempDict[@"max"] doubleValue];
                
                NSArray* weatherArray = ((NSDictionary*) list[i])[@"weather"];
                NSString * icon = ((NSDictionary*)weatherArray[0])[@"icon"];
                NSString* iconUrl = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png",icon];
                
                NSString* weatherDescription = ((NSDictionary*)weatherArray[0])[@"description"];
                
                NSLog(@"******************************\n %d.iteration\n temperature: %2.1f,\n iconURL: %@,\n description: %@",i, temperature, iconUrl, weatherDescription);
                
                DailyData* dailyData = [DailyData new];
                [dailyData setDailyData:temperature iconURL:iconUrl weatherDescription:weatherDescription];
                
                [weatherData addObject: dailyData];
            }
            

        
        Weather* weather = [[Weather alloc] init];
        
            [weather setData:country city:city tenDaysWeather:weatherData];
        
        aCompletion(weather);
        }

        
    } withParams:nil];
    
    
}



@end
