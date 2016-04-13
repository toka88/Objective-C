//
//  AppDelegate.m
//  Side Menu - Map
//
//  Created by Apple on 3/16/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import "AppDelegate.h"
#import "SWRevealViewController.h"
#import "MenuTableViewController.h"
#import "FrontViewController.h"

@interface AppDelegate ()

@property(strong, nonatomic) UINavigationController* rearNavigationController;

//@property(strong, nonatomic) UINavigationController* frontNavigationController;

@property(strong, nonatomic) UIViewController* viewController;

@end



@implementation AppDelegate





- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIUserNotificationSettings * notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    FrontViewController* frontViewController = [[FrontViewController alloc] init];
    MenuTableViewController* menuController = [[MenuTableViewController alloc] init];
    
    UINavigationController * frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    
    UINavigationController * rearNavigationController = [[UINavigationController alloc] initWithRootViewController:menuController];
    
    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    
   // mainRevealController.delegate = self;
    
    self.viewController = mainRevealController;
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible]
    ;
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)goToController:(UIViewController*) controller{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MenuTableViewController *rearViewController = [[MenuTableViewController alloc] init];
    
    [self.frontNavigationController setViewControllers:@[controller] animated:NO];
    
    self.rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:self.rearNavigationController frontViewController:self.frontNavigationController];
    
    [self.rearNavigationController setNavigationBarHidden:YES];
    
    [self.frontNavigationController setNavigationBarHidden:NO];
    
    //revealController.delegate = self;
    
    
    self.viewController = revealController;
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    
}

@end
