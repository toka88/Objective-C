//
//  LoadingView.m
//  ParseJSONObjectiveC
//
//  Created by Apple on 3/3/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "LoadingView.h"
#import "CircleView.h"

//Definitions of private variables and functions
@interface LoadingView()

@property(strong, nonatomic) CircleView * gradientCircle;
@property(strong, nonatomic) NSString * const kAnimationKey;

@end


//Class implementation
@implementation LoadingView

+ (LoadingView *)loading {
    static LoadingView *sharedInstance = nil;
    if (!sharedInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedInstance = [[super allocWithZone:NULL] initWithFrame:[UIScreen mainScreen].bounds];
            // custom initialisation
            
        });
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self loading];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.kAnimationKey = @"rotation";
        self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:1];
        
        self.gradientCircle = [[CircleView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 40, self.frame.size.height /2 - 40, 80, 80)];
        //_gradientCircle = [[CircleView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 40, self.frame.size.height/2 - 40, 80, 80)];
        
        //self.gradientCircle = [[CircleView alloc] initWithFrame:self.bounds];
        
        [self addSubview:_gradientCircle];
        
        [_gradientCircle gradientCircle:@[(id)[UIColor redColor].CGColor, (id)[UIColor yellowColor].CGColor, (id)[UIColor blueColor].CGColor, (id)[UIColor greenColor].CGColor]] ;
    }
    return self;
}

-(void)startAnimating{
    
    self.alpha = 1.0;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    if ([self.gradientCircle.layer animationForKey:self.kAnimationKey] == nil) {
        
        CABasicAnimation * const animate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        
        animate.duration = 1;
        animate.repeatCount = INFINITY;
        animate.fromValue = [NSNumber numberWithFloat:0.0];
        animate.toValue = [NSNumber numberWithFloat:M_PI * 2];
        [self.gradientCircle.layer addAnimation:animate forKey:self.kAnimationKey];
    }
    
}

-(void) stopAnimating{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if ([self.gradientCircle.layer animationForKey:self.kAnimationKey] != nil) {
            [self.layer removeAnimationForKey:self.kAnimationKey];
        }
        [self removeFromSuperview];
    }];
}

@end
