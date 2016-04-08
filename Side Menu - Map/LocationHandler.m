//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// DIGITAL ATRIUM
//
// LocationHandler.m
//
// Author IDENTITY:
//		Apple		3/29/16	
//

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import "LocationHandler.h"
#import <MapKit/MapKit.h>



//________________________________________________________________________________//
//________________________________________________________________________________//
@interface LocationHandler ()



@end

//________________________________________________________________________________//
//________________________________________________________________________________//
#pragma mark -
@implementation LocationHandler


-(void)maxSpeed:(MaxSpeedCompletionBlock)maxSpeed{
    
    
    
    dispatch_async(location_dispatch_queue(), ^{
        
        
        maxSpeed(false, 0);
        
        
        double currentMaxSpeed = 0;
        
        
        
        for (int i = 0; i < self.locations.count; i++) {
            
            double temp = ((CLLocation*)self.locations[i]).speed*3.6;
            
            
            //Update max speed
            if (currentMaxSpeed <= temp) {
                currentMaxSpeed = temp;
            }
            
        }
        
        maxSpeed(true, currentMaxSpeed);
        
    
    
    });
    
}


-(void)averageSpeed:(AverageSpeedCompletionBlock)averageSpeed{
    
    
   
    
    dispatch_async(location_dispatch_queue(), ^{
        
        averageSpeed(false, 0);
        
        double speedSum = 0;
        
        NSLog(@"Width of array: %lu", (unsigned long)self.locations.count);
        
        for (int i=0 ; i < self.locations.count; i++) {
            
            speedSum += ((CLLocation*)self.locations[i]).speed;
            NSLog(@"\n index = %u",i);
            NSLog(@"\n\n sum = %.2f",speedSum);
            
        }
        NSLog(@"Sum of Speed: %.2f",speedSum);
        
        speedSum /= self.locations.count;
        
        speedSum *= 3.6;
        averageSpeed(true, speedSum);
        
    });
    
}


-(void)minSpeed:(MinSpeedCompletionBlock)minSpeed{
    

    
    dispatch_async(location_dispatch_queue(), ^{
        
        
        minSpeed(false, 0);
        
        
        double currentMaxSpeed = 10000;
        
        
        
        for (int i = 0; i < self.locations.count; i++) {
            
            double temp = ((CLLocation*)self.locations[i]).speed*3.6;
            
            
            //Update min speed
            if (currentMaxSpeed >= temp) {
                currentMaxSpeed = temp;
            }
            
        }
        
        minSpeed(true, currentMaxSpeed);
        
        
        
    });
    
    
}





-(void)distance:(DistanceCompletionBlock)distance{
    
    
    
    
    dispatch_async(location_dispatch_queue(), ^{
        
        distance(false,0);
        
        double dist  = 0;
        
        
        for (int i = 0; i < self.locations.count -1; i++) {
            
            dist += [((CLLocation*)self.locations[i]) distanceFromLocation:((CLLocation*)self.locations[i+1])];
            
            
        }
        
        dist /= 1000;
        NSLog(@"Distanc: %.2f",dist);
        distance(true, dist);
        
        
    });
    
    
}
    


static dispatch_queue_t location_dispatch_queue() {
    static dispatch_queue_t location_dispatch_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location_dispatch_queue = dispatch_queue_create("com.digitalatrium.goran", DISPATCH_QUEUE_SERIAL);
    });
    
    return location_dispatch_queue;
}
    



@end
