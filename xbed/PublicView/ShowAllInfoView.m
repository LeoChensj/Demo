//
//  ShowAllInfoView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ShowAllInfoView.h"

@implementation ShowAllInfoView

- (instancetype)initWithContentHeight:(CGFloat)contentHeight
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        _vContent = [[UIView alloc] init];
        _vContent.backgroundColor = [UIColor whiteColor];
        _vContent.layer.masksToBounds = YES;
        _vContent.layer.cornerRadius = 3;
        [self addSubview:_vContent];
        [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
            make.height.mas_equalTo(contentHeight);
            make.center.mas_equalTo(0);
            
        }];
        
        
        _lbtitle = [[UILabel alloc] init];
        _lbtitle.textColor = Main_Text_Color;
        _lbtitle.font = FontBold(18);
        [_vContent addSubview:_lbtitle];
        [_lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(18);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(20);
            
        }];
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = Main_Text_Color;
        [_vContent addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-60);
            make.height.mas_equalTo(1.5);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(_lbtitle.mas_bottom).offset(20);
            
        }];
        
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.alwaysBounceVertical = YES;
        [_vContent addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
            make.height.mas_equalTo(contentHeight-60-49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(line1.mas_bottom).offset(0);
            
        }];
        
        
        _textsView = [[TextsView alloc] init];
        _textsView.pointColor = Secondary_Text_Color2;
        _textsView.textColor = Main_Text_Color;
        _textsView.contentWidth = MAIN_SCREEN_WIDTH-60;
        [_scrollView addSubview:_textsView];
        [_textsView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
            make.height.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(30);
            
        }];
        
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = Blue_Color;
        [_vContent addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-60);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-49);
            
        }];
        
        
        _btnClose = [[UIButton alloc] init];
        [_btnClose setTitle:@"我知道了" forState:UIControlStateNormal];
        [_btnClose setTitleColor:Blue_Color forState:UIControlStateNormal];
        _btnClose.titleLabel.font = Font(16);
        [_vContent addSubview:_btnClose];
        [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
        }];
        
        WS(ws);
        [[_btnClose rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [ws removeFromSuperview];
            
        }];
        
        
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbtitle.text = title;
}

- (void)setContent:(NSString *)content
{
    _content = content;
    
    _textsView.content = content;
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_textsView.mas_bottom).offset(30);
        
    }];
}

- (void)setContentArray:(NSArray<NSString *> *)contentArray
{
    _contentArray = contentArray;
    
    _textsView.contentArray = contentArray;
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_textsView.mas_bottom).offset(30);
        
    }];
}







@end
