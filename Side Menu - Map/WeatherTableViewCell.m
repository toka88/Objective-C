//
//  WeatherTableViewCell.m
//  Side Menu - Map
//
//  Created by Goran Tokovic on 4/8/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import "WeatherTableViewCell.h"

@interface WeatherTableViewCell ()

@property (strong, nonatomic) UILabel* dateLabel;
@property (strong, nonatomic) UIImageView* iconImageView;
@property (strong, nonatomic) UILabel* temperatureLabel;

@end

@implementation WeatherTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{

    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height)];
    [self.dateLabel setTextColor:[UIColor whiteColor]];
    [self.dateLabel setTextAlignment:NSTextAlignmentLeft];
    [self.dateLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Regular" size:12]];
    [self addSubview:self.dateLabel];

    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - self.frame.size.height / 2, 0, self.frame.size.height, self.frame.size.height)];
    [self addSubview:self.iconImageView];

    self.temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame), 0, self.frame.size.width - 10 - CGRectGetMaxX(self.iconImageView.frame), self.frame.size.height)];
    [self.temperatureLabel setTextColor:[UIColor whiteColor]];
    [self.temperatureLabel setTextAlignment:NSTextAlignmentRight];
    [self.temperatureLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Regular" size:12]];
    [self addSubview:self.temperatureLabel];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(NSString*)date iconURL:(NSString*)url temperature:(NSString*)temeperature
{
    
    [self.dateLabel setText:date];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        if (data == nil) {
            return ;
        }
        
        UIImage * iconImage = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.iconImageView setImage:iconImage];
            [self.iconImageView setContentMode:UIViewContentModeScaleAspectFill];
        });
        
        
    });
    
    
}

@end
