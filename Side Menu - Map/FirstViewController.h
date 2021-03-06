//
//  FirstViewController.h
//  Side Menu - Map
//
//  Created by Apple on 3/23/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"


@class FirstViewController;
@protocol FirstViewControllerDelegate <NSObject>

-(void)passTextFromFirstViewController:(FirstViewController*)viewController  text:(NSString*) text;

@end

@interface FirstViewController : UIViewController<SecondViewControllerDelegate>


@property(strong, nonatomic) NSString * text;

@property(strong, nonatomic) NSString * secondText;
@property(weak, nonatomic) id delegate;

@end
