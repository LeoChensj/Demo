//
//  RoomEvaluateBaseInfoView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomEvaluateBaseInfoView.h"

@implementation RoomEvaluateBaseInfoView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _imgvRoom = [[UIImageView alloc] init];
        [self addSubview:_imgvRoom];
        [_imgvRoom mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(134);
            make.height.mas_equalTo(89);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.numberOfLines = 0;
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-164);
            make.height.mas_equalTo(0);
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(_imgvRoom.mas_right).offset(10);
            
        }];
        
        
        _lbDesc = [[UILabel alloc] init];
        _lbDesc.textColor = Secondary_Text_Color2;
        _lbDesc.font = Font(12);
        [self addSubview:_lbDesc];
        [_lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-164);
            make.height.mas_equalTo(12);
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(_imgvRoom.mas_right).offset(10);
            
        }];
        
        
        _imgvArrow = [[UIImageView alloc] init];
        _imgvArrow.image = [UIImage imageNamed:@"ic_search_into"];
        [self addSubview:_imgvArrow];
        [_imgvArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(14);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.bottom.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}


- (void)setRoomImage:(NSString *)roomImage
{
    _roomImage = roomImage;
    
    [_imgvRoom sd_setImageWithURL:[NSURL URLWithString:roomImage] placeholderImage:PlaceholderImage];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
    _lbTitle.lineSpace = 6;
    
    CGSize titleSize = [_lbTitle labelSize:MAIN_SCREEN_WIDTH-164];
    CGFloat titleHeight = titleSize.height;
    if(titleHeight>39) titleHeight = 39;
    
    [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(titleHeight);
        
    }];
}

- (void)setRoomAddress:(NSString *)roomAddress
{
    _roomAddress = roomAddress;
    
    _lbDesc.text = roomAddress;
}



@end
