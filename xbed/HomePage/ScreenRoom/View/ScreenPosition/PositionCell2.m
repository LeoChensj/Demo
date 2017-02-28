//
//  PositionCell2.m
//  xbed
//
//  Created by Leo.Chen on 16/7/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "PositionCell2.h"

@implementation PositionCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
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
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = Seg_Line_Color;
        [self.contentView addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(LINE_WIDTH);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            
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
        _lbTitle.textColor = Main_Text_Color;
    }
    else if(state==1)
    {
        _lbTitle.textColor = Blue_Color;
    }
}

@end
