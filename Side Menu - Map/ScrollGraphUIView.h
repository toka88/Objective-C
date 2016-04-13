//
//  ScrollGraphUIView.h
//  Chart_ObjC
//
//  Created by Tokovic Goran on 3/7/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollGraphUIView : UIView





-(void)setTitleLabel:(NSString *)titleText color:(UIColor*)color font:(UIFont*)font;
-(void)setStartColor:(UIColor *)startColor;
-(void)setEndColor:(UIColor *)endColor;
-(void)setGraphPoints:(NSMutableArray *)graphValues;
-(void)setTopBorder:(CGFloat)topBorder;
-(void)setBottonBorder:(CGFloat)bottonBorder;
-(void)setMargin:(CGFloat)margin;
-(void)setDistanceBetweenPoints:(CGFloat)distanceBetweenPoints;


-(void)drawScrollGraph:(BOOL)animate duration:(NSTimeInterval)duration;

@end


