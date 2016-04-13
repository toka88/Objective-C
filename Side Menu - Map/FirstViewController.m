//
//  FirstViewController.m
//  Side Menu - Map
//
//  Created by Apple on 3/23/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import "FirstViewController.h"
#import "Constants.h"

@interface FirstViewController ()

@property(strong, nonatomic) UITextField * textField;
@property(strong, nonatomic) UIButton * nextButton;
@property(strong, nonatomic) UITextField* secondTextField;
@property(strong, nonatomic) UIButton* bottomButton;
@property(strong, nonatomic) NSString* notificationData;

extern NSString * const notificationName;

@end

@implementation FirstViewController

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
    
    
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0.4]];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 120, self.view.frame.size.width-60, 40)];
    [self.textField setTextAlignment:NSTextAlignmentCenter];
    [self.textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.textField setBackgroundColor:[UIColor whiteColor]];
    [self.textField setTextColor:[UIColor blackColor]];
    [self.textField setText:self.text];
    
    // [self.textField becomeFirstResponder];
    
    [self.view addSubview:self.textField];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(incomingNotification:) name:notificationName object:nil];
    
    
    ///Second text field
    self.secondTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.textField.frame)+50, self.view.frame.size.width - 60, 40)];
    
    [self.secondTextField setBackgroundColor:[UIColor whiteColor]];
    [self.secondTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.secondTextField setTextAlignment:NSTextAlignmentCenter];
    [self.secondTextField setPlaceholder:@"Enter text"];
    [self.view addSubview:self.secondTextField];
    self.secondTextField.text = self.secondText;
    
    
    
    
    self.nextButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 40, CGRectGetMaxY(self.secondTextField.frame)+50, 80, 40)];
    
    
    [self.nextButton addTarget:self action: @selector(openNextController:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
    
    [self.nextButton setBackgroundColor:[UIColor whiteColor]];
    [self.nextButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:20] ;
    [self.view addSubview:self.nextButton];

    
   
    
    

    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    if (self.delegate != nil) {
        [self.delegate passTextFromFirstViewController:self text:self.textField.text];
    }
    
    if (self.secondTextField.text != self.notificationData) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self.secondTextField.text];
    }
    
    
}


-(void)incomingNotification: (NSNotification*)notification{
    
    NSString* text = [notification object];
    self.secondTextField.text = text;
    self.notificationData = text;
}


-(void)openNextController:(id)sender{
    
    SecondViewController* nextController = [[SecondViewController alloc] init];
    
    nextController.text = self.textField.text;
    nextController.secondText = self.secondTextField.text;
    nextController.delegate = self;
    
    [self.navigationController pushViewController:nextController animated:YES];
    
    
    
}

-(void)passTextFromSecondViewController:(SecondViewController *)viewController text:(NSString *)text{
    
    self.textField.text = text;
    
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
