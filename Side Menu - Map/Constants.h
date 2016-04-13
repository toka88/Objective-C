//
//  Constants.h
//  Side Menu - Map
//
//  Created by Apple on 3/23/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import "Weather.h"
//#import "WeatherBaseService.h"

#ifndef Constants_h
#define Constants_h

static NSString *const notificationName = @"firstNotification";
static NSString * const secondNotificationName = @"secondNotification";



typedef void (^MaxSpeedCompletionBlock)(BOOL aSuccessful, double maxSpeed);
typedef void (^AverageSpeedCompletionBlock) (BOOL aSuccessful, double averageSpeed);
typedef  void  (^MinSpeedCompletionBlock)(BOOL aSuccessful,double minSpeed);

typedef void (^DistanceCompletionBlock)(BOOL aSuccessful,double distance);



//load JSON
typedef void(^WeatherLoadingCompletionBlock) (BOOL aSuccessful, NSError * anError, NSDictionary * dict);

typedef void (^WeatherDataCompletionBlock)(NSString* country, NSString* city, double tepmerature, NSString* icon, NSString* iconDescription);

typedef void (^WeatherObjectCompletionBlock)(Weather* weatherObject);




#define SPTimeout 30.0
#endif /* Constants_h */
