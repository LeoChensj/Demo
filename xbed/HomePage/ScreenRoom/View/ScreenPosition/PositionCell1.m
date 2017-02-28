//
//  PositionCell1.m
//  xbed
//
//  Created by Leo.Chen on 16/7/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "PositionCell1.h"


@implementation PositionCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = Background_Color;
        
        UIView *selectView = [[UIView alloc] init];
        selectView.backgroundColor = [UIColor whiteColor];
        self.selectedBackgroundView = selectView;
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = Font(14);
        [self.contentView addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(self.mas_height);
            make.center.mas_equalTo(0);
            
        }];
        
        
    }
    
    return self;
}

- (void)setModel:(ScreenRoomTagModel *)model
{
    _model = model;
    
    _lbTitle.text = model.cname;
}
- (void)setState:(NSInteger)state
{
    _state = state;
    
    if(state==0)
    {
        self.backgroundColor = Background_Color;
        self.lbTitle.textColor = Main_Text_Color;
    }
    else if(state==1)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.lbTitle.textColor = Blue_Color;
    }
}







@end
