//
//  OrderDetailRoomServiceCell.m
//  xbed
//
//  Created by Leo.Chen on 16/9/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderDetailRoomServiceCell.h"

@implementation OrderDetailRoomServiceCell

- (instancetype)init
{
    if(self = [super init])
    {
        self.normalColor = [UIColor whiteColor];
        self.touchColor = White_Click_COLOR;
        
        _imgvIcon = [[UIImageView alloc] init];
        [self addSubview:_imgvIcon];
        [_imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(48);
            make.height.mas_equalTo(29);
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(self.mas_centerY).offset(-15);
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = Font(12);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.mas_centerY).offset(15);
            
        }];
        
        
        _lbDesc = [[UILabel alloc] init];
        _lbDesc.textColor = Blue_Color;
        _lbDesc.textAlignment = NSTextAlignmentCenter;
        _lbDesc.font = Font(10);
        [self addSubview:_lbDesc];
        [_lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(10);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_lbTitle.mas_bottom).offset(10);
            
        }];
        _lbDesc.hidden = YES;
        
    }
    
    return self;
}


- (void)setImageIcon:(UIImage *)imageIcon
{
    _imageIcon = imageIcon;
    
    _imgvIcon.image = imageIcon;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}
- (void)setDesc:(NSString *)desc
{
    _desc = desc;
    
    if(desc && desc.length)
    {
        _lbDesc.hidden = NO;
        _lbDesc.text = desc;
    }
}




@end
