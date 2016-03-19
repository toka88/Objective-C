//
//  MenuTableViewController.m
//  Side Menu - Map
//
//  Created by Apple on 3/16/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import "MenuTableViewController.h"
#import "SideMenuCell.h"
#import "MapViewController.h"
#import "AppDelegate.h"
#import "SWRevealViewController.h"
#import "FrontViewController.h"
#import "ImageViewController.h"

@interface MenuTableViewController ()

@property(strong, nonatomic) NSArray* titlesArray;
@property(strong, nonatomic) NSString* menuReuseIdentifier;

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"Menu";
    _menuReuseIdentifier = @"menuCell";
    
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    
    
    _titlesArray = @[@"Main Screen",@"Map", @"Picture"];
    
    [self.tableView registerClass:[SideMenuCell class] forCellReuseIdentifier:self.menuReuseIdentifier];
    
    CAGradientLayer* gradien = [CAGradientLayer layer];
    gradien.frame = self.view.bounds;
    
    gradien.colors = @[(id)[[UIColor colorWithRed:0.749 green:0.749 blue:0.749 alpha:1]CGColor],(id)[[UIColor colorWithRed:0.07854 green:0.07854 blue:0.07854 alpha:1]CGColor]];
    [self.tableView.backgroundView.layer addSublayer:gradien];
    //self.tableView.backgroundColor  = [UIColor clearColor];
    
    //self.tableView.backgroundColor = [UIColor purpleColor];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titlesArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SideMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:self.menuReuseIdentifier forIndexPath:indexPath];
    
    
    cell.cellTitleLabel.text = self.titlesArray[indexPath.row];
    if (indexPath.row == 1) {
        cell.iconView.image = [[UIImage imageNamed:@"icon_1320_white60.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        //cell.iconView.tintColor = [UIColor blackColor];
    }else if(indexPath.row == 2){
        
        cell.iconView.image = [[UIImage imageNamed:@"phone-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  60;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        FrontViewController *fc = [[FrontViewController alloc] init];
        UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:fc];
        
        [self.revealViewController pushFrontViewController:navigationController animated:YES];
        
    }else if (indexPath.row == 1) {
        MapViewController * mapController = [[MapViewController alloc] init];
        
        UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:mapController];
        
        [self.revealViewController pushFrontViewController:navigationController animated:YES];
    }else if (indexPath.row == 2){
        
        ImageViewController * imageViewController = [[ImageViewController alloc] init];
        
        UINavigationController *navigationController =
        [[UINavigationController alloc] initWithRootViewController:imageViewController];
        
        [self.revealViewController pushFrontViewController:navigationController animated:YES];
    }
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
