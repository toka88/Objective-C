//
//  SecondViewController.m
//  Side Menu - Map
//
//  Created by Apple on 3/23/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import "SecondViewController.h"
#import "Constants.h"

@interface SecondViewController ()


@property(strong, nonatomic) UITextField* textField;
@property(strong, nonatomic) UITextField* bottomTextField;


@end


@implementation SecondViewController

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
    
    self.bottomTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.textField.frame)+50, self.view.frame.size.width-60, 40)];
    [self.bottomTextField setTextAlignment:NSTextAlignmentCenter];
    [self.bottomTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.bottomTextField setBackgroundColor:[UIColor whiteColor]];
    [self.textField setTextColor: [UIColor blackColor]];
    [self.bottomTextField setText:self.secondText];
    [self.view addSubview:self.bottomTextField];
 
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    if (self.delegate != nil) {
        [self.delegate passTextFromSecondViewController:self text:self.textField.text];
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName: notificationName object:self.bottomTextField.text];
    
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
