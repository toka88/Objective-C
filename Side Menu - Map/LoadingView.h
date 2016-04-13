//
//  LoadingView.h
//  ParseJSONObjectiveC
//
//  Created by Apple on 3/3/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

+(LoadingView*)loading;

-(void)startAnimating;
-(void)stopAnimating;

@end
