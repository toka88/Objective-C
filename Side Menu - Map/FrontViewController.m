//
//  FrontViewController.m
//  Side Menu - Map
//
//  Created by Apple on 3/16/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import "FrontViewController.h"
#import "SWRevealViewController.h"

@interface FrontViewController ()

@end

@implementation FrontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self UIInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)UIInit{
    
   
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController panGestureRecognizer];
    
    UIImage* backgroundImage = [UIImage imageNamed:@"backgroundPic.jpg"];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = backgroundImage;
    self.view = imageView;
    
    UIImage* buttonImage = [[UIImage imageNamed:@"menu_icon (1).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    CGRect rect = CGRectMake(10, 0, 30, 25);
    
    UIButton* customButton = [[UIButton alloc] initWithFrame:rect];
    
    [customButton setImage:buttonImage forState:UIControlStateNormal];
    
    customButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [customButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    customButton.imageView.tintColor = [UIColor blackColor ];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
