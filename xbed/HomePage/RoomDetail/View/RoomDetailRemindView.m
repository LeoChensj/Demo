//
//  RoomDetailRemindView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailRemindView.h"

@implementation RoomDetailRemindView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Background_Color;
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"特别提醒";
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.textColor = Blue_Color;
        _lbTitle.font = FontBold(16);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(16);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(30);
            
        }];
        
        
        _textsView = [[TextsView alloc] init];
        _textsView.pointColor = Blue_Color;
        _textsView.textColor = Blue_Color;
        _textsView.contentWidth = MAIN_SCREEN_WIDTH-30;
        [self addSubview:_textsView];
        [_textsView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_lbTitle.mas_bottom).offset(20);
            
        }];
        
    }
    
    return self;
}

- (void)setRemindColor:(UIColor *)remindColor
{
    _remindColor = remindColor;
    
    _textsView.pointColor = remindColor;
    _textsView.textColor = remindColor;
}

- (void)setRemind:(NSString *)remind
{
    _remind = remind;
    
    _textsView.content = remind;
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(30+16+20+_textsView.height+25);
        
    }];
}

- (void)setRemindArray:(NSArray<NSString *> *)remindArray
{
    _remindArray = remindArray;
    
    if(remindArray==nil || remindArray.count<=0)
    {
        self.hidden = YES;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
    }
    else
    {
        self.hidden = NO;
        
        _textsView.contentArray = remindArray;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(30+16+20+_textsView.height+25);
            
        }];
    }
}


@end
