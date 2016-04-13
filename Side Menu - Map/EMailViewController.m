//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// DIGITAL ATRIUM
//
// EMailViewController.m
//
// Author IDENTITY:
//		Apple		3/28/16	
//

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import "EMailViewController.h"
#import "SWRevealViewController/SWRevealViewController.h"




//________________________________________________________________________________//
//________________________________________________________________________________//
@interface EMailViewController ()


@property(strong, nonatomic) UIButton * composeMailButton;

@end

//________________________________________________________________________________//
//________________________________________________________________________________//
#pragma mark -
@implementation EMailViewController



-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self UIInit];
    
}




-(void)UIInit{
    
    
    
    
    
    self.view.backgroundColor = [UIColor clearColor];
    

    
    // Gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = @[(id)[[UIColor colorWithRed:0.749 green:0.749 blue:0.749 alpha:1]CGColor],(id)[[UIColor colorWithRed:0.07854 green:0.07854 blue:0.07854 alpha:1]CGColor]];
    
    [self.view.layer addSublayer:gradient];
    
    
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
    
    

    
    
    self.composeMailButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 70, self.view.frame.size.height/2 - 20, 140, 40)];
    [self.composeMailButton setTitle:@"Compose mail" forState:UIControlStateNormal];
    [self.composeMailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.composeMailButton setBackgroundColor:[UIColor whiteColor]];
    [self.composeMailButton addTarget:self action:@selector(composeNewMail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.composeMailButton];
    
    
    
    
}


-(void)composeNewMail{
    
    
    NSString * emailTitle = @"Test Email";
    NSString * messageBody = @"Programmatically generated e-mail";
    NSArray * emailAddress = @[@"tokan988@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:emailAddress];
    

    
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
