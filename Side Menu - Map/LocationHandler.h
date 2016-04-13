//________________________________________________________________________________//
//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// Written by DIGITAL ATRIUM
//
// LocationHandler.h
//
// Author:
//		Apple		3/29/16
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
@interface LocationHandler : NSObject


@property(strong, nonatomic) NSArray * locations;


//Speed
-(void)maxSpeed:(MaxSpeedCompletionBlock) maxSpeed;
-(void)averageSpeed:(AverageSpeedCompletionBlock) averageSpeed;
-(void)minSpeed:(MinSpeedCompletionBlock) minSpeed;


//Distance
-(void)distance:(DistanceCompletionBlock) distance;


@end

