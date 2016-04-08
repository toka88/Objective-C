//
//  CircleView.m
//  ParseJSONObjectiveC
//
//  Created by Apple on 3/3/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "CircleView.h"
@interface CircleView() //Redefinition in m file

@property(strong, nonatomic) UIBezierPath * circlePath;
@property(strong, nonatomic) CAShapeLayer * inBorder;
@property(strong, nonatomic) CAShapeLayer * outBorder;
@property(strong, nonatomic) NSMutableArray * segments;

//Declaration uses only for simple data types
@property(nonatomic, assign) CGFloat lineWidth;

@end

@implementation CircleView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self basicInit];
    }
    return self;
}

-(void)basicInit{
    self.backgroundColor = [UIColor clearColor];
    self.lineWidth = 5.0;
    
    self.segments = [[NSMutableArray alloc] init];
    
    UIBezierPath * inBorderPath = [UIBezierPath  bezierPath];
    [inBorderPath addArcWithCenter:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0) radius:(self.frame.size.width - 10)/2 - self.lineWidth/2 startAngle:(CGFloat) (3 * M_PI / 2) endAngle:(CGFloat)(M_PI * 7/2) clockwise:true];
    
    UIBezierPath * outBorderPath = [UIBezierPath  bezierPath];
    [outBorderPath addArcWithCenter:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0) radius:(self.frame.size.width - 10)/2 + self.lineWidth/2 startAngle:(CGFloat) (3 * M_PI / 2) endAngle:(CGFloat)(M_PI * 7/2) clockwise:true];
    
    self.circlePath = [UIBezierPath  bezierPath];
    [self.circlePath addArcWithCenter:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0) radius:(self.frame.size.width - 10)/2 startAngle:(CGFloat) (3 * M_PI / 2) endAngle:(CGFloat)(M_PI * 7/2) clockwise:true];
    
    
    self.inBorder = [[CAShapeLayer alloc] init];
    self.inBorder.path = inBorderPath.CGPath;
    self.inBorder.fillColor = [[UIColor clearColor] CGColor]; //Convert UIColor to CGColor
    self.inBorder.strokeColor = [[UIColor blackColor] CGColor];
    self.inBorder.lineWidth = 1.0;
    [self.layer addSublayer:self.inBorder];
    
    self.outBorder = [[CAShapeLayer alloc] init];
    self.outBorder.path = outBorderPath.CGPath;
    self.outBorder.fillColor = [[UIColor clearColor] CGColor];
    self.outBorder.strokeColor = [[UIColor blackColor] CGColor];
    self.outBorder.lineWidth = 1.0;
    [self.layer addSublayer:self.outBorder];
    
}

-(void) gradientCircle:(NSArray *)colors{
    
    
    CALayer * newLayer = [[CALayer alloc] init];
    newLayer.frame = self.bounds;
    
    NSMutableArray * gradientLayer =[[NSMutableArray alloc] init];
    
//    NSMutableArray* gradientLayer = [[NSMutableArray alloc] init];
    CGPoint center =  CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    
    
    NSArray* points = [self getPointsOnCircle:(int)colors.count radiusOfCircle:(self.frame.size.width - 10)/2 centreOfCircle: center];
    
    self.circlePath = [UIBezierPath bezierPath];
    [self.circlePath addArcWithCenter:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0) radius:(self.frame.size.width - 10)/2 startAngle: 0 endAngle:(CGFloat)(M_PI * 2) clockwise:true];
    
    for (int i=0; i < colors.count; i++) {
        
        
        
        [gradientLayer addObject:[[CAGradientLayer alloc] init]];
        ((CAGradientLayer*)gradientLayer[i]).frame = self.bounds;
        
        
        if (i != colors.count - 1) {
            
            ((CAGradientLayer*)gradientLayer[i]).colors = @[colors[i], colors[i+1]];
            
            NSValue * val = [points objectAtIndex:i+1];
            CGPoint pt = [val CGPointValue];
            pt.x = pt.x / self.frame.size.width;
            pt.y = pt.y / self.frame.size.height;
            ((CAGradientLayer*)gradientLayer[i]).endPoint = pt;
            
        } else {
            
            ((CAGradientLayer*)gradientLayer[i]).colors = @[colors[i], colors[0]];
            NSValue * val = [points objectAtIndex:0];
            CGPoint pt = [val CGPointValue];
            pt.x = pt.x / self.frame.size.width;
            pt.y = pt.y / self.frame.size.height;
            ((CAGradientLayer*)gradientLayer[i]).endPoint = pt;
        }
        
        NSValue * val  = [points objectAtIndex:i];
        CGPoint p = [val CGPointValue];
        p.x = p.x / self.frame.size.width;
        p.y = p.y / self.frame.size.height;
        
        ((CAGradientLayer*)gradientLayer[i]).startPoint = p;
        
        
        [self.segments addObject:[[CAShapeLayer alloc] init]];
        ((CAShapeLayer*)self.segments[i]).path = self.circlePath.CGPath;
        ((CAShapeLayer*)self.segments[i]).fillColor = [[UIColor clearColor] CGColor];
        ((CAShapeLayer*)self.segments[i]).strokeColor = [[UIColor blackColor] CGColor];
        ((CAShapeLayer*)self.segments[i]).lineWidth = self.lineWidth;
        ((CAShapeLayer*)self.segments[i]).backgroundColor = [[UIColor clearColor] CGColor];
        
        if (i == 0) {
            
            ((CAShapeLayer*)self.segments[i]).strokeStart = 0.0;
            
        }else {
            
            ((CAShapeLayer*)self.segments[i]).strokeStart = ((CAShapeLayer*)self.segments[i-1]).strokeEnd;
        }
        
        
        ((CAShapeLayer*)self.segments[i]).strokeEnd = ((CAShapeLayer*)self.segments[i]).strokeStart + (1.0 / (CGFloat)colors.count);
        
        
        
        ((CAGradientLayer*)gradientLayer[i]).mask = self.segments[i];
        [newLayer addSublayer:gradientLayer[i]];
        
    }
    
    [self.layer addSublayer:newLayer];
    
}



//Array with NSValue data
-(NSArray*)getPointsOnCircle:(int)points radiusOfCircle:(CGFloat)radius centreOfCircle:(CGPoint)centre{
    
    NSMutableArray* pointsOnCircle = [[NSMutableArray alloc] init];
    //CGPoint pointsOnCircle[points];
    CGFloat const slice = 2 * (CGFloat)M_PI / points;
    for (int i = 0; i < points; i++) {
        CGFloat const angle = slice * (CGFloat)i;
        
#pragma mark ???
        CGFloat const newX = (CGFloat)(centre.x + radius * cos(angle));
        CGFloat const newY = (CGFloat)(centre.y+ radius * sin(angle));
        [pointsOnCircle addObject: [NSValue valueWithCGPoint: CGPointMake(newX, newY)]];
    }
    NSArray* temp = [NSArray arrayWithArray:pointsOnCircle];
    return temp;
}

@end
