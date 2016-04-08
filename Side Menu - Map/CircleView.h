//
//  CircleView.h
//  ParseJSONObjectiveC
//
//  Created by Apple on 3/3/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

/*
 
@property(strong, nonatomic) CAShapeLayer * inBorder;
@property(strong, nonatomic) CAShapeLayer * uotBorder;
@property(strong, nonatomic) CAShapeLayer * grayCircle;

//This declaration uses only for simple data types
@property(nonatomic, assign) CGFloat lineWidth;
 
*/

-(void) gradientCircle : (NSArray*) colors;
-(NSMutableArray*)getPointsOnCircle: (int)points radiusOfCircle: (CGFloat)radius centreOfCircle :(CGPoint) centre;
@end
