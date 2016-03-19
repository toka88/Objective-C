//
//  PushButtonView.m
//  Chart_ObjC
//
//  Created by Apple on 3/10/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "PushButtonView.h"

@implementation PushButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _fillColor = [UIColor greenColor];
        _isAddButton = true;
    }
    return self;
}



-(void)drawRect:(CGRect)rect{
    
    UIBezierPath* path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [self.fillColor setFill];
    [path fill];
    
    
    CGFloat const plusHeight = 3.0;
    CGFloat const plusWidth = MIN(self.bounds.size.width, self.bounds.size.height) * 0.6;
    
    //Create the path
    UIBezierPath * plusPath = [UIBezierPath bezierPath];
    
    //set the path's line width to the height of the stroke
    plusPath.lineWidth = plusHeight;
    
    //move the initial point of the path to the the start of the horisontal stroke
    [plusPath moveToPoint:CGPointMake(self.bounds.size.width/2 - plusWidth/2 + 0.5, self.bounds.size.height/2 + 0.5)];
    
    //add a topint to the path at the end of the stroke
    [plusPath addLineToPoint:CGPointMake(self.bounds.size.width/2 + plusWidth/2 + 0.5, self.bounds.size.height/2+ 0.5)];
    
    //Vertical line
    
    if (self.isAddButton) {
        
        [plusPath moveToPoint:CGPointMake(self.bounds.size.width/2 + 0.5, self.bounds.size.height/2 - plusWidth/2 + 0.5)];
        
        [plusPath addLineToPoint:CGPointMake(self.bounds.size.width/2 + 0.5, self.bounds.size.height/2 + plusWidth/2 + 0.5)];
    }
    
    
    
    
    
    [[UIColor whiteColor] setStroke];
    
    [plusPath stroke];
    
    
    
}

@end
