//
//  SPAFNRequest.h
//  SmartPalm
//
//  Created by Radomir Zivojinovic on 5/17/15.
//  Copyright (c) 2015 Radomir Zivojinovic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface SPAFNRequest : NSObject
+(AFHTTPSessionManager*)prepareRequest;
@end
