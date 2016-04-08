//
//  SecondViewController.h
//  Side Menu - Map
//
//  Created by Apple on 3/23/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecondViewController;
@protocol SecondViewControllerDelegate <NSObject>

-(void) passTextFromSecondViewController:(SecondViewController*) viewController text:(NSString*)text;

@end

@interface SecondViewController : UIViewController

@property(strong, nonatomic) NSString* text;
@property(strong, nonatomic) NSString* secondText;

@property(weak, nonatomic) id<SecondViewControllerDelegate>delegate;

@end
