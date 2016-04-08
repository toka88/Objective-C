//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// DIGITAL ATRIUM
//
// JSONParserBaseService.m
//
// Author IDENTITY:
//		Goran Tokovic		4/1/16	
//

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import "JSONParserBaseService.h"



//________________________________________________________________________________//
//________________________________________________________________________________//
@interface JSONParserBaseService ()

@end

//________________________________________________________________________________//
//________________________________________________________________________________//
#pragma mark -
@implementation JSONParserBaseService

+ (JSONParserBaseService *)sharedInstance {
    static JSONParserBaseService *sharedInstance = nil;
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



-(void)loadData:(NSString *)url arrayWithData:(WeatherDataCompletionBlock)data{
    
    [self loadWeatherDataFromUrl:url withCompletion:^(BOOL aSuccessful, NSError *anError, NSDictionary *dict) {
        
        if (aSuccessful) {
            
            
            NSLog(@"Response: %@", dict);
            
            
            //Temperature
            NSLog(@"***************: %@",dict[@"main"]);
            NSDictionary* main = dict[@"main"];
            
            NSNumber* temperature = main[@"temp"];
            NSLog(@"\n\nTemperature: %f", [temperature doubleValue]);
            
            //Country and city
            NSDictionary* sys = dict[@"sys"];
            NSString* country = sys[@"country"];
            
            NSString* city = dict[@"name"];
            
            NSLog(@"\n\nCountry: %@, city: %@",country,  city);
            
            
            //Icon
            NSArray* weather = dict[@"weather"];
            
            NSString* description = ((NSDictionary*)weather[0])[@"main"];
            NSString* icon = ((NSDictionary*)weather[0])[@"icon"];
            
            NSLog(@"descriprion: %@, icon: %@", description,icon);
            
            data(country, city, [temperature doubleValue], icon, description);
            
        }
        
        
    } withParams:nil];
    
    
}



@end
