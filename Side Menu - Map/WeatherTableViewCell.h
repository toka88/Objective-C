//
//  WeatherTableViewCell.h
//  Side Menu - Map
//
//  Created by Goran Tokovic on 4/8/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableViewCell : UITableViewCell

- (void)setCellData:(NSString*)date iconURL:(NSString*)url temperature:(NSString*)temeperature;

@end
