//
//  FrontViewController.m
//  Side Menu - Map
//
//  Created by Apple on 3/16/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import "FrontViewController.h"
#import "SWRevealViewController.h"
#import "FirstViewController.h"
#import "Constants.h"
#import "StreamViewController.h"

@interface FrontViewController ()

@property(strong, nonatomic) UITextField *textField;
@property(strong, nonatomic) UITextField *secondTextField;


@property(strong, nonatomic) UIButton * nextButton;


@property(strong, nonatomic) UIBarButtonItem* streamiButton;





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
    
   // [revealController panGestureRecognizer];
    
    UIImage* backgroundImage = [UIImage imageNamed:@"backgroundPic.jpg"];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = backgroundImage;
    [self.view insertSubview:imageView atIndex:0];
//
    UIImage* buttonImage = [[UIImage imageNamed:@"menu_icon (1).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    CGRect rect = CGRectMake(10, 0, 30, 25);
    
    UIButton* customButton = [[UIButton alloc] initWithFrame:rect];
    
    [customButton setImage:buttonImage forState:UIControlStateNormal];
    
    customButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [customButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    customButton.imageView.tintColor = [UIColor blackColor ];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 120, self.view.frame.size.width-60, 40)];
    [self.textField setTextAlignment:NSTextAlignmentCenter];
    [self.textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.textField setBackgroundColor:[UIColor whiteColor]];
    [self.textField setTextColor:[UIColor blackColor]];
    
   // [self.textField becomeFirstResponder];
    
    [self.view addSubview:self.textField];
    
    
    
    
    
    ///Second text field
    self.secondTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.textField.frame)+50, self.view.frame.size.width - 60, 40)];
    
    [self.secondTextField setBackgroundColor:[UIColor whiteColor]];
    [self.secondTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.secondTextField setTextAlignment:NSTextAlignmentCenter];
    [self.secondTextField setPlaceholder:@"Enter text"];
    [self.view addSubview:self.secondTextField];
    
    
    
    self.nextButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 40, CGRectGetMaxY(self.secondTextField.frame)+50, 80, 40)];
    
    
    [self.nextButton addTarget:self action: @selector(openNextController:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
    
    [self.nextButton setBackgroundColor:[UIColor whiteColor]];
    [self.nextButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:20] ;
    [self.view addSubview:self.nextButton];

    
    self.streamiButton = [[UIBarButtonItem alloc] initWithTitle:@"Stream" style:UIBarButtonItemStylePlain target:self action:@selector(streamPressed)];
    self.navigationItem.rightBarButtonItem = self.streamiButton;
    
    
    
    
    
}



-(void)streamPressed{
    
    StreamViewController* viewController = [[StreamViewController alloc] init];
    
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}



-(void)openNextController:(id)sender{
    
    
    FirstViewController* nextController = [[FirstViewController alloc] init];
    nextController.text = self.textField.text;
    nextController.secondText = self.secondTextField.text ;
    nextController.delegate = self;
    
    [self.navigationController pushViewController:nextController animated:NO];
    
    
}

-(void)passTextFromFirstViewController:(FirstViewController *)viewController text:(NSString *)text{
    
    self.textField.text = text;
}

-(void)bottomButtonPressed{
    
    FirstViewController *controller = [[FirstViewController alloc] init];
    controller.secondText = self.secondTextField.text;
    
    [self.navigationController pushViewController:controller animated:NO];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(incomingNotification:) name:notificationName object:nil];
    
}

-(void)incomingNotification:(NSNotification*)notification{
    
    NSString* text = [notification object];
    
    self.secondTextField.text = text;
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
