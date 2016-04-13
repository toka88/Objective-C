//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// DIGITAL ATRIUM
//
// WeatherBaseService.m
//
// Author IDENTITY:
//		Goran Tokovic		4/1/16	
//

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import "WeatherBaseService.h"
#import "SPAFNRequest.h"



//________________________________________________________________________________//
//________________________________________________________________________________//
@interface WeatherBaseService ()

@end

//________________________________________________________________________________//
//________________________________________________________________________________//
#pragma mark -
@implementation WeatherBaseService


+ (WeatherBaseService *)sharedInstance {
    static WeatherBaseService *sharedInstance = nil;
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



-(void)loadWeatherDataFromUrl:(NSString *)url withCompletion:(WeatherLoadingCompletionBlock)aCompletion withParams:(NSDictionary *)params{
    
    
    AFHTTPSessionManager * manager = [SPAFNRequest prepareRequest];
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * jsonDict = (NSDictionary*) responseObject;
        if (!jsonDict) {
            if (aCompletion) {
                aCompletion(NO, nil, nil);
            }
        }
        else{
            if (aCompletion) {
                aCompletion(YES, nil, jsonDict);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (task.response != nil) {
            //TODO:
        }
        aCompletion(NO, error,nil);
        
    }];
    
    
    
    
}


@end
