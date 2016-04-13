//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// DIGITAL ATRIUM
//
// WeatherAFRequest.m
//
// Author IDENTITY:
//		Goran Tokovic		4/1/16	
//

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import "WeatherAFRequest.h"
#import "Constants.h"



//________________________________________________________________________________//
//________________________________________________________________________________//
@interface WeatherAFRequest ()





@end

//________________________________________________________________________________//
//________________________________________________________________________________//
#pragma mark -
@implementation WeatherAFRequest



+(AFHTTPSessionManager*)prepareRequest{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.requestSerializer setTimeoutInterval:SPTimeout];
    
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    
    //    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    
    return manager;
    
}

@end
