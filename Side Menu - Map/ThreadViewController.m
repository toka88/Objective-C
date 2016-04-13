//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// DIGITAL ATRIUM
//
// ThreadViewController.m
//
// Author IDENTITY:
//		Goran Tokovic		3/25/16
//

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import "ThreadViewController.h"
#import "LoadingView.h"
#import "SWRevealViewController/SWRevealViewController.h"
#import "PushButtonView.h"



//________________________________________________________________________________//
//________________________________________________________________________________//
@interface ThreadViewController ()


@property(strong, nonatomic) UIButton * loadingButton;
@property(strong, nonatomic) PushButtonView * plusButton;
@property(strong, nonatomic) PushButtonView * minusButton;
@property(strong,nonatomic) UILabel* resultLabel;

@property(assign, nonatomic) int counter;
@property(assign, nonatomic) int secondCounter;

@end

//________________________________________________________________________________//
//________________________________________________________________________________//
#pragma mark -
@implementation ThreadViewController


-(void)viewDidLoad{
    
    
    SWRevealViewController *revealController = [self revealViewController];
        UIImage* buttonImage = [[UIImage imageNamed:@"menu_icon (1).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    CGRect rect = CGRectMake(10, 0, 30, 25);
    
    UIButton* customButton = [[UIButton alloc] initWithFrame:rect];
    
    [customButton setImage:buttonImage forState:UIControlStateNormal];
    
    customButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [customButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    customButton.imageView.tintColor = [UIColor blackColor ];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    
    self.title = @"Thread";
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
    
    
    
    self.loadingButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 40, 100, 80, 30)];
    [self.loadingButton addTarget:self action:@selector(loadingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.loadingButton setTitle:@"Loading" forState:UIControlStateNormal];
    [self.loadingButton setBackgroundColor:[UIColor whiteColor]];
    [self.loadingButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [self.view addSubview:self.loadingButton];
    
    self.counter = 0;
    
    self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 30, CGRectGetMaxY(self.loadingButton.frame)+100, 60, 60)];
    [self.resultLabel setText:[NSString stringWithFormat:@"%d",self.counter]];
    self.resultLabel.font = [UIFont boldSystemFontOfSize:30];
    [self.resultLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.resultLabel];
    
    
    self.plusButton = [[PushButtonView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 40, CGRectGetMaxY(self.resultLabel.frame)+20, 80, 80)];
    self.plusButton.isAddButton = YES;
    self.plusButton.fillColor = [UIColor colorWithRed:0.0745 green:0.5098 blue:0.149 alpha:1];
    
    [self.plusButton addTarget:self action:@selector(plusButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.plusButton];
    
    
    self.minusButton = [[PushButtonView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 20, CGRectGetMaxY(self.plusButton.frame)+20, 40, 40)];
    self.minusButton.isAddButton = NO;
    self.minusButton.fillColor = [UIColor colorWithRed:0.698 green:0.09411 blue:0.2902 alpha:1];
    [self.minusButton addTarget:self action:@selector(minusButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.minusButton];
    
    
    
  //  [[LoadingView loading] startAnimating];
    
//    dispatch_queue_t loadingQueue = dispatch_queue_create("loadingQueue", NULL);
//    
//    dispatch_async(loadingQueue, ^{
//        
//        sleep(5);
//        
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [[LoadingView loading] stopAnimating];
//        });
//        
//        
//    });
//    
    
    
    
}


-(void)plusButtonPressed{
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        
        self.counter++;
        sleep(2);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.resultLabel.text = [NSString stringWithFormat:@"%d", self.counter];
            
            
        });
        
    });
    
}


-(void)minusButtonPressed{
    
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(globalQueue, ^{
        self.counter--;
        sleep(2);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.resultLabel.text = [NSString stringWithFormat:@"%d",self.counter];
        });
        
    });
    
    
}


-(void) viewWillAppear:(BOOL)animated{
    
    [[LoadingView loading] startAnimating];
    
    dispatch_queue_t loadingQueue = dispatch_queue_create("loadingQueue", NULL);
    
    dispatch_async(loadingQueue, ^{
        
        sleep(2);
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[LoadingView loading] stopAnimating];
        });
        
        
    });
    
}

-(void)loadingButtonPressed:(id)sender{
    
    
    [[LoadingView loading] startAnimating];
    
    dispatch_queue_t loadingQueue = dispatch_queue_create("loadingQueue", NULL);
    
    dispatch_async(loadingQueue, ^{
        
        sleep(5);
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[LoadingView loading] stopAnimating];
        });
        
        
    });
    
    

    
}





@end
