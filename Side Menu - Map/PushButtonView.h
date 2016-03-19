//
//  PushButtonView.h
//  Chart_ObjC
//
//  Created by Apple on 3/10/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface PushButtonView : UIButton

@property(strong, nonatomic) IBInspectable UIColor* fillColor;
@property(assign, nonatomic) IBInspectable BOOL isAddButton;


@end
