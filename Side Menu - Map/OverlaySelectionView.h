//
//  OverlaySelectionView.h
//  Side Menu - Map
//
//  Created by Apple on 3/21/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol OverlaySelectionViewDelegate <NSObject>

-(void)areaSelected:(CGRect) screenArea;

@optional
-(void)isChangingDimensionOfSelectedArea: (BOOL) isChanging;

-(void)startPointChanged:(CGPoint) startPoint;
-(void)endPointChanged:(CGPoint) endPoint;

@end

@interface OverlaySelectionView : UIView{
    @private
   
    CGRect dragAreaBounds;
    
    CGPoint startPoint;
    CGPoint endPoint;
    
    
}


//@property(assign, nonatomic) CGPoint startLocation;
//@property(assign,nonatomic) CGPoint endLocation;
@property(assign, nonatomic) BOOL isMoving;

@property(weak, nonatomic) id delegate;

 @property(strong, nonatomic) UIView* dragArea;

@end
