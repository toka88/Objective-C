//
//  InfoView.m
//  Side Menu - Map
//
//  Created by Apple on 3/29/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import "InfoView.h"

@interface InfoView()

@property(strong, nonatomic) UILabel* label;
@property(strong, nonatomic) UILabel* textField;

@end


@implementation InfoView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    
    if (self) {
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        [self.label setTextColor:[UIColor whiteColor]];
        [self addSubview:self.label];
        
        
        self.textField = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.label.frame)+10, self.frame.size.width, 20)];
        [self.textField setBackgroundColor:[UIColor whiteColor]];
        [self.textField setTextAlignment:NSTextAlignmentCenter];
        [self.textField setTextColor:[UIColor blackColor]];
        [self addSubview:self.textField];
        
        
    }
    
    return self;
}



-(void)setData:(NSString *)title text:(NSString *)text{
    
    
    [self.label setText:title];
    [self.textField setText:text];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
