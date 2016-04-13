//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// DIGITAL ATRIUM
//
// WebViewController.m
//
// Author IDENTITY:
//		Goran Tokovic		3/30/16	
//

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import "WebViewController.h"
#import "LoadingView.h"
#import "SWRevealViewController/SWRevealViewController.h"



//________________________________________________________________________________//
//________________________________________________________________________________//
@interface WebViewController ()

@property(strong, nonatomic) UIWebView * webView;

@property(strong, nonatomic) UIButton * backButton;
@property(strong, nonatomic) UIButton * forwardButton;



@end

//________________________________________________________________________________//
//________________________________________________________________________________//
#pragma mark -
@implementation WebViewController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    [self UIInit];
    
}


-(void)UIInit{
    
    
    SWRevealViewController *revealController = [self revealViewController];
    
#pragma mark - Disable panGEstureRecognizer
    // [revealController panGestureRecognizer];
    
    //Menu button
    
    UIImage* buttonImage = [[UIImage imageNamed:@"menu_icon (1).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    CGRect rect = CGRectMake(10, 0, 30, 25);
    
    UIButton* customButton = [[UIButton alloc] initWithFrame:rect];
    
    [customButton setImage:buttonImage forState:UIControlStateNormal];
    
    customButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [customButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    customButton.imageView.tintColor = [UIColor blackColor ];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    

    
    
    
    self.title = @"WEB View";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - (0+50))];
    self.webView.delegate = self;
    
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    
    [[LoadingView loading] startAnimating];
    
    
    //Print information about screen
    NSLog(@"Frame width: %f",self.view.frame.size.width);
    NSLog(@"Frame height: %f",self.view.frame.size.height);
    
    
    
    NSURL * googleURL = [NSURL URLWithString:@"http://www.blic.rs/"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:googleURL];
    
    [self.webView loadRequest:request];
    
    
    
    //back button
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(63.75, CGRectGetMaxY(self.webView.frame)+5, 40, 40)];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"arrow_icon_640x640.png"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:self.backButton];
    
    
    //forward buttor
    
    
    self.forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.backButton.frame)+63.75, CGRectGetMaxY(self.webView.frame)+5, 40, 40)];
    [self.forwardButton setBackgroundImage:[UIImage imageNamed:@"arrow_icon_640x640.png"] forState:UIControlStateNormal];
    [self.forwardButton addTarget:self action:@selector(forwardPressed) forControlEvents:UIControlEventTouchUpInside];
    self.forwardButton.transform = CGAffineTransformMakeRotation(M_PI);
    
    [self.view addSubview:self.forwardButton];
    
    
    
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [[LoadingView loading] stopAnimating];
    
}




#pragma mark - button
-(void)backPressed{
    
    [self.webView goBack];
    
}

-(void)forwardPressed{
    
    [self.webView goForward];
}


@end
