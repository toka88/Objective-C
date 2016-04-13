//
//  ScrollGraphUIView.m
//  Chart_ObjC
//
//  Created by Tokovic Goran on 3/7/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "ScrollGraphUIView.h"
@interface ScrollGraphUIView ()

//UI

@property (strong, nonatomic) UILabel* titleLabel;

@property (strong, nonatomic) UIView* tempView;

@property (strong, nonatomic) UIScrollView* scrollView;

// they're have setters

@property (strong, nonatomic) UIColor* startColor;
@property (strong, nonatomic) UIColor* endColor;
@property (strong, nonatomic) NSMutableArray* graphValues;
@property (assign, nonatomic) CGFloat topBorder;
@property (assign, nonatomic) CGFloat bottonBorder;
@property (assign, nonatomic) CGFloat margin;
@property (assign, nonatomic) CGFloat distanceBetweenPoints;
@property (assign, nonatomic) int maxValue;
@property (assign, nonatomic) CGFloat graphHeight;
@property (assign, nonatomic) CGFloat percentage;

@property (assign, nonatomic) int iterator;

@end

@implementation ScrollGraphUIView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self commonInit];
        [self UIInit];
    }
    return self;
}

- (void)commonInit
{

    _startColor = [UIColor colorWithRed:0.98039 green:0.9137 blue:0.87059 alpha:1];
    _endColor = [UIColor colorWithRed:0.98824 green:0.309804 blue:0.03137 alpha:1];
    _graphValues = [NSMutableArray arrayWithArray:@[ @1, @2, @3, @0, @12, @11, @3, @20, @3, @3, @12, @6, @11, @0 ]];
    _topBorder = self.frame.size.height*0.15;
    _bottonBorder = self.frame.size.height*0.15;
    _margin = self.frame.size.height*0.1;
    _distanceBetweenPoints = 40;
    _percentage = 50;
    _iterator = 0;
}

- (void)UIInit
{

    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;

    _tempView = [[UIView alloc] initWithFrame:self.bounds];
    [_tempView setBackgroundColor:[UIColor clearColor]];
    //[self addSubview:self.tempView];

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.self.topBorder)];
    [_titleLabel setText:@"Title"];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];

    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
}

/************************************************************************************/
#pragma mark draw graph
- (void)drawScrollGraph:(BOOL)animate duration:(NSTimeInterval)duration
{

    //self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.distanceBetweenPoints * self.graphValues.count + 2* self.margin, self.frame.size.height);
    self.tempView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y , self.distanceBetweenPoints * self.graphValues.count + 2 * self.margin, self.frame.size.height);

    NSLog(@"Frame size: %f, %f", self.frame.size.width, self.frame.size.height);

    NSArray* colors = @[ (id)self.startColor.CGColor, (id)self.endColor.CGColor ];

    CAGradientLayer* backgroundGradientLayer = [[CAGradientLayer alloc] init];
    backgroundGradientLayer.frame = self.bounds;
    backgroundGradientLayer.colors = colors;
    backgroundGradientLayer.locations = @[ @0.0, @1.0 ];
    backgroundGradientLayer.startPoint = CGPointMake(0, 0);
    backgroundGradientLayer.endPoint = CGPointMake(0, 1);
    [self.layer addSublayer:backgroundGradientLayer];

    //[self addSubview:self.scrollView];

    self.maxValue = [self maxInt:self.graphValues];
    NSLog(@"\n\nMAX:%d\n", self.maxValue);

    self.graphHeight = self.tempView.frame.size.height - self.topBorder - self.bottonBorder;

    UIBezierPath* graphPath = [UIBezierPath bezierPath];

    [graphPath addArcWithCenter:CGPointMake([self calculateXPoint:0], [self calculateYPoint:[self.graphValues[0] intValue]]) radius:2 startAngle:0 endAngle:2 * 7 clockwise:true];
    [graphPath moveToPoint:CGPointMake([self calculateXPoint:0], [self calculateYPoint:[self.graphValues[0] intValue]])];

    for (int i = 1; i < self.graphValues.count; i++) {

        CGPoint temp = CGPointMake([self calculateXPoint:i], [self calculateYPoint:[self.graphValues[i] intValue]]);
        [graphPath addLineToPoint:temp];
        [graphPath addArcWithCenter:temp radius:2 startAngle:0 endAngle:2 * 7 clockwise:true];
        [graphPath addLineToPoint:temp];

        NSLog(@"Temp point: %f %f", temp.x, temp.y);
    }

    CAShapeLayer* graphLayer = [[CAShapeLayer alloc] init];
    graphLayer.path = graphPath.CGPath;
    graphLayer.strokeColor = [UIColor whiteColor].CGColor;
    graphLayer.fillColor = [UIColor clearColor].CGColor;
    graphLayer.lineWidth = 2;
    //graphLayer.cornerRadius = 50;

    //self.layer.cornerRadius = 5.0;

    UIBezierPath* clippingPath = [graphPath copy];

    [clippingPath addLineToPoint:CGPointMake([self calculateXPoint:(int)(self.graphValues.count - 1)], self.tempView.frame.size.height)];
    [clippingPath addLineToPoint:CGPointMake([self calculateXPoint:0], self.tempView.frame.size.height)];

    //[clippingPath addClip];

    CGFloat highestYPoint = [self calculateYPoint:self.maxValue];

    CAShapeLayer* clippingLayer = [[CAShapeLayer alloc] init];
    clippingLayer.path = clippingPath.CGPath;
    clippingLayer.strokeColor = [UIColor clearColor].CGColor;
    clippingLayer.fillColor = [UIColor purpleColor].CGColor;

    CAGradientLayer* underLineGradient = [[CAGradientLayer alloc] init];
    underLineGradient.frame = self.tempView.bounds;
    underLineGradient.startPoint = CGPointMake(0, highestYPoint / self.tempView.frame.size.height);
    underLineGradient.endPoint = CGPointMake(0, 1);
    underLineGradient.colors = colors;
    underLineGradient.locations = @[ @0.0, @1.0 ];
    underLineGradient.mask = clippingLayer;

    [self.tempView.layer addSublayer:underLineGradient];

    [self.tempView.layer addSublayer:graphLayer];

    UIBezierPath* topLine = [UIBezierPath bezierPath];
    [topLine moveToPoint:CGPointMake(self.margin, highestYPoint)];
    [topLine addLineToPoint:CGPointMake(self.tempView.frame.size.width - self.margin, highestYPoint)];

    CAShapeLayer* topLineLayer = [[CAShapeLayer alloc] init];
    topLineLayer.path = topLine.CGPath;
    topLineLayer.lineWidth = 1;
    topLineLayer.strokeColor = [UIColor colorWithWhite:1 alpha:0.8].CGColor;
    topLineLayer.fillColor = [UIColor clearColor].CGColor;
    [self.tempView.layer addSublayer:topLineLayer];

    UIBezierPath* bottonLinePath = [UIBezierPath bezierPath];
    [bottonLinePath moveToPoint:CGPointMake(self.margin, [self calculateYPoint:0])];
    [bottonLinePath addLineToPoint:CGPointMake(self.tempView.frame.size.width - self.margin, [self calculateYPoint:0])];

    CAShapeLayer* bottonLineLayer = [[CAShapeLayer alloc] init];
    bottonLineLayer.path = bottonLinePath.CGPath;
    bottonLineLayer.lineWidth = 1;
    bottonLineLayer.strokeColor = [UIColor colorWithWhite:1 alpha:0.8].CGColor;
    bottonLineLayer.fillColor = [UIColor clearColor].CGColor;
    [self.tempView.layer addSublayer:bottonLineLayer];

    UIBezierPath* compareLinePath = [UIBezierPath bezierPath];
    [compareLinePath moveToPoint:CGPointMake(self.margin, self.graphHeight * (100 - self.percentage) / 100 + self.topBorder)];
    [compareLinePath addLineToPoint:CGPointMake(self.tempView.frame.size.width - self.margin, self.graphHeight * (100 - self.percentage) / 100 + self.topBorder)];

    CAShapeLayer* compareLine = [[CAShapeLayer alloc] init];
    compareLine.path = compareLinePath.CGPath;
    compareLine.lineWidth = 1;
    compareLine.strokeColor = [UIColor colorWithWhite:1 alpha:0.8].CGColor;
    compareLine.fillColor = [UIColor clearColor].CGColor;
    [self.tempView.layer addSublayer:compareLine];

    NSMutableArray* dotViews = [[NSMutableArray alloc] init];
    UIView* dotView = [[UIView alloc] initWithFrame:self.tempView.bounds];
    [dotView setBackgroundColor:[UIColor clearColor]];
    //Dots
    for (int i = 0; i < self.graphValues.count; i++) {

        UIBezierPath* dotPath = [UIBezierPath bezierPath];
        [dotPath addArcWithCenter:CGPointMake([self calculateXPoint:i], [self calculateYPoint:[self.graphValues[i] intValue]]) radius:4 startAngle:0 endAngle:2 * 4 clockwise:true];

        CAShapeLayer* dotLayer = [[CAShapeLayer alloc] init];
        dotLayer.path = dotPath.CGPath;
        dotLayer.strokeColor = [UIColor whiteColor].CGColor;
        dotLayer.fillColor = [UIColor whiteColor].CGColor;
        dotLayer.strokeStart = 0.0;
        dotLayer.strokeEnd = 1.0;

        //[dotViews addObject:[[UIView alloc] initWithFrame:self.tempView.bounds]];

        // [(UIView*)dotViews[i] setBackgroundColor:[UIColor clearColor]];

        //[((UIView*)dotViews[i]).layer addSublayer:dotLayer];
        [dotView.layer addSublayer:dotLayer];

        // [self.tempView addSubview:dotViews[i]];
    }

    //[self.tempView addSubview:dotView];

    [self.scrollView setContentSize:CGSizeMake(self.tempView.frame.size.width, self.scrollView.contentSize.height)];
    [self.scrollView setShowsHorizontalScrollIndicator:false];
    [self.scrollView addSubview:self.tempView];

    [self addSubview:self.scrollView];

    [self addSubview:self.titleLabel];

#pragma mark Animation
    if (animate) {

        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = duration;
        animation.fromValue = [NSNumber numberWithFloat:0.0];
        animation.toValue = [NSNumber numberWithFloat:1.0];
        [graphLayer addAnimation:animation forKey:@"strokeEndAnimation"];

        CABasicAnimation* animateGradient = [CABasicAnimation animationWithKeyPath:@"endPoint"];
        animateGradient.duration = duration;
        animateGradient.fromValue = [NSNumber valueWithCGPoint:CGPointMake(0, highestYPoint / self.tempView.frame.size.height)];

        animateGradient.toValue = [NSNumber valueWithCGPoint:CGPointMake(0, 1)];
        [underLineGradient addAnimation:animateGradient forKey:@"slide"];

        [UIView animateWithDuration:duration delay:duration options:nil animations:^{
            nil;
        }
            completion:^(BOOL finished) {
                CABasicAnimation* animateCircles = [CABasicAnimation animationWithKeyPath:@"opacity"];
                animateCircles.duration = duration;
                animateCircles.fromValue = [NSNumber numberWithFloat:0.0];
                animateCircles.toValue = [NSNumber numberWithFloat:1.0];
                [dotView.layer addAnimation:animateCircles forKey:@"opacity"];
            }];
        //
        //        [UIView animateWithDuration:duration animations:^{
        //            //graphLayer.strokeStart = 0.0;
        //            graphLayer.strokeStart = 0.0;
        //            //graphLayer.strokeEnd = 1.0;
        //        } completion:^(BOOL finished) {
        //
        //
        //
        //        }];
        //

        //        CABasicAnimation* animateCircles = [CABasicAnimation animationWithKeyPath:@"opacity"];
        //        animateCircles.duration = duration;
        //        animateCircles.fromValue = [NSNumber numberWithFloat:0.0];
        //        animateCircles.toValue = [NSNumber numberWithFloat:1.0];
        //        [dotView.layer addAnimation:animateCircles forKey:@"opacity"];
        //

        //
        //[self animateDots:dotViews duration:(duration/dotViews.count)];
    }
}

- (void)animateDots:(NSMutableArray*)newViews duration:(NSTimeInterval)duration
{

    [UIView animateKeyframesWithDuration:duration delay:0 options:nil animations:^{
        ((UIView*)newViews[self.iterator]).alpha = 0.0;
        ((UIView*)newViews[self.iterator]).alpha = 1.0;

    }
        completion:^(BOOL finished) {
            self.iterator++;
            [self.tempView addSubview:(UIView*)newViews[self.iterator]];
            if (self.iterator < newViews.count) {

                [self animateDots:newViews duration:duration];
            }
            else {
                self.iterator = 0;
            }

        }];
}

- (CGFloat)calculateXPoint:(int)column
{
    CGFloat spacer = self.distanceBetweenPoints;
    CGFloat x = (CGFloat)column * spacer;
    x += self.margin + 2;
    return x;
}

- (CGFloat)calculateYPoint:(int)graphPoint
{
    CGFloat y = ((CGFloat)graphPoint) / (CGFloat)self.maxValue * (CGFloat)self.graphHeight;
    y = self.graphHeight + self.topBorder - y;
    return y;
}

//Get max value from the array

- (int)maxInt:(NSMutableArray*)array
{
    int max = 0;
    for (int i = 0; i < array.count; i++) {
        int temp = [array[i] intValue];

        NSLog(@"%d", temp);

        if (max <= temp) {
            max = temp;
        }
    }
    return max;
}

/************************************************************************************/

#pragma mark Setters
- (void)setTitleLabel:(NSString*)title color:(UIColor*)color font:(UIFont*)font
{
    if (title != nil) {
        [self.titleLabel setText:title];
    }

    if (color != nil) {
        [self.titleLabel setTextColor:color];
    }

    if (font != nil) {
        [self.titleLabel setFont:font];
    }
}

- (void)setCompareLine:(CGFloat)percentage
{
    self.percentage = percentage;
}

- (void)setStartColor:(UIColor*)startColor
{
    if (startColor != nil) {
        self.startColor = startColor;
    }
}

- (void)setEndColor:(UIColor*)endColor
{
    if (endColor != nil) {
        self.endColor = endColor;
    }
}

- (void)setGraphPoints:(NSArray*)graphValues
{
    if (graphValues != nil) {
        [self.graphValues removeAllObjects];
        self.graphValues = [NSMutableArray arrayWithArray:graphValues];
    }
}

- (void)setTopBorder:(CGFloat)topBorder
{

    self.topBorder = topBorder;
}

- (void)setBottonBorder:(CGFloat)bottonBorder
{
    self.bottonBorder = bottonBorder;
}

- (void)setMargin:(CGFloat)margin
{
    self.margin = margin;
}

- (void)setDistanceBetweenPoints:(CGFloat)distanceBetweenPoints
{
    self.distanceBetweenPoints = distanceBetweenPoints;
}

@end
