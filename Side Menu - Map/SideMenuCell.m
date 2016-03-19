//
//  SideMenuCell.m
//  Side Menu - Map
//
//  Created by Apple on 3/17/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import "SideMenuCell.h"

@interface SideMenuCell()




@end

@implementation SideMenuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        /******  INIT UI  ***************/
        UIImage *icon = [[UIImage imageNamed:@"concept-icon-poster60.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
        _iconView.image = icon;
        _iconView.tintColor = [UIColor blackColor];
        
        [self addSubview:_iconView];
        
        
        
        _cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconView.frame)+20, 10, self.frame.size.width - self.iconView.frame.size.width - 40, 40)];
        
        _cellTitleLabel.font = [UIFont boldSystemFontOfSize:26.0f];
        _cellTitleLabel.textColor = [UIColor blackColor];
        _cellTitleLabel.text = @"CELL";
        
        [self addSubview:self.cellTitleLabel];
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
