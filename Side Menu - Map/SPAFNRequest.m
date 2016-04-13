//
//  SPAFNRequest.m
//  SmartPalm
//
//  Created by Radomir Zivojinovic on 5/17/15.
//  Copyright (c) 2015 Radomir Zivojinovic. All rights reserved.
//

#import "SPAFNRequest.h"
#import "Constants.h"

@implementation SPAFNRequest
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
