//
//  OverlaySelectionView.m
//  Side Menu - Map
//
//  Created by Apple on 3/21/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import "OverlaySelectionView.h"

@interface OverlaySelectionView()


@end

@implementation OverlaySelectionView



-(void)initialize{
    
        dragAreaBounds = CGRectMake(0, 0, 0, 0);
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = NO;
        //self.backgroundColor = [UIColor clearColor];
    
    self.isMoving = false;
    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch * touch = [[event allTouches] anyObject];
    dragAreaBounds.origin = [touch locationInView:self];
    
    startPoint = [touch locationInView:self];
    
    if (self.delegate != nil) {
        [self.delegate areaSelected:dragAreaBounds];
       // [delegate startPointChanged:startPoint];
        [self.delegate isChangingDimensionOfSelectedArea:true];
    }
    
    self.isMoving = true;
    
    
    
}


-(void)handleTouch:(UIEvent*) event{
    
    UITouch * touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
    
    
    dragAreaBounds.size.height = location.y - dragAreaBounds.origin.y;
    dragAreaBounds.size.width = location.x - dragAreaBounds.origin.x;
    
    
    if (self.dragArea == nil) {
        UIView* area = [[UIView alloc] initWithFrame:dragAreaBounds];
        area.backgroundColor = [UIColor blueColor];
        area.opaque = NO;
        area.alpha = 0.3f;
        area.userInteractionEnabled = NO;
        self.dragArea = area;
        [self addSubview:self.dragArea];
        
        
    }else{
        
        self.dragArea.frame = dragAreaBounds;
        
    }
    
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)even{
    
    
    [self handleTouch:even];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self handleTouch:event];
    
    UITouch * touch = [[event allTouches] anyObject];
    
    
    endPoint = [touch locationInView:self];
    
    
    if (self.delegate != nil) {
        [self.delegate areaSelected:dragAreaBounds];
     //   [delegate endPointChanged:endPoint];
        [self.delegate isChangingDimensionOfSelectedArea:false];
    }
    
    dragAreaBounds = CGRectMake(0, 0, 0, 0);
   // [self initialize];
   // self.alpha = 0.1;
}


-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [self initialize];
//    [self.dragArea removeFromSuperview];
//    self.dragArea = nil;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
