//
//  RoomDetailNoticeView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/9.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailNoticeView.h"

@implementation RoomDetailNoticeView

@synthesize btnAll = _btnAll;

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"入住须知";
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = FontBold(16);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(16);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(30);
            
        }];
        
        
        
        _textsView = [[TextsView alloc] init];
        _textsView.pointColor = Secondary_Text_Color2;
        _textsView.textColor = Main_Text_Color;
        _textsView.contentWidth = MAIN_SCREEN_WIDTH-30;
        [self addSubview:_textsView];
        [_textsView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_lbTitle.mas_bottom).offset(20);
            
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


- (void)setNotice:(NSString *)notice
{
    _notice = notice;
    
    _textsView.content2 = notice;
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(30+16+20+_textsView.height+30+34+30);
        
    }];
}

- (void)setNoticeArray:(NSArray<NSString *> *)noticeArray
{
    if(noticeArray==nil || noticeArray.count<=0)
    {
        self.hidden = YES;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
    }
    else
    {
        self.hidden = NO;
        
        if(noticeArray.count>3)
        {
            _noticeArray = [noticeArray subarrayWithRange:NSMakeRange(0, 3)];
        }
        else
        {
            _noticeArray = noticeArray;
        }
        
        _textsView.contentArray = _noticeArray;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(30+16+20+_textsView.height+30+34+30);
            
        }];
    }
}



- (UIButton *)btnAll
{
    if(_btnAll==nil)
    {
        _btnAll = [[UIButton alloc] init];
        _btnAll.layer.masksToBounds = YES;
        _btnAll.layer.cornerRadius = 2;
        _btnAll.layer.borderColor = Blue_Color.CGColor;
        _btnAll.layer.borderWidth = LINE_WIDTH;
        [_btnAll setTitle:@"查看详情" forState:UIControlStateNormal];
        [_btnAll setTitleColor:Blue_Color forState:UIControlStateNormal];
        _btnAll.titleLabel.font = Font(12);
        [self addSubview:_btnAll];
        [_btnAll mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(34);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_textsView.mas_bottom).offset(30);
            
        }];
    }
    
    return _btnAll;
}

@end
