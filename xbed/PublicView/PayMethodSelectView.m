//
//  PayMethodSelectView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "PayMethodSelectView.h"

@implementation PayMethodSelectCell

- (instancetype)init
{
    if(self = [super init])
    {
        self.normalColor = [UIColor whiteColor];
        self.touchColor = White_Click_COLOR;
        
        _imgvIcon = [[UIImageView alloc] init];
        [self addSubview:_imgvIcon];
        [_imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(34);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(25);
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(18);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(_imgvIcon.mas_right).offset(30);
            
        }];
        
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = Seg_Line_Color;
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.bottom.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

- (void)setImgIcon:(UIImage *)imgIcon
{
    _imgIcon = imgIcon;
    
    _imgvIcon.image = imgIcon;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}

- (void)setHaveLine:(BOOL)haveLine
{
    _haveLine = haveLine;
    
    _line.hidden = !haveLine;
}


@end

@implementation PayMethodSelectView

- (instancetype)init
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        _vContent = [[UIView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT, MAIN_SCREEN_WIDTH, 60*2+49)];
        _vContent.backgroundColor = [UIColor whiteColor];
        [self addSubview:_vContent];
        
        
        _vCancel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-_vContent.size.height)];
        [self addSubview:_vCancel];
        UITapGestureRecognizer *tapCancel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close2)];
        [_vCancel addGestureRecognizer:tapCancel];
        
        
        
        
//        _cellApplePay = [[PayMethodSelectCell alloc] init];
//        _cellApplePay.imgIcon = [UIImage imageNamed:@"ic_apple_pay"];
//        _cellApplePay.title = @"Apple Pay";
//        _cellApplePay.haveLine = YES;
//        [_vContent addSubview:_cellApplePay];
//        [_cellApplePay mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
//            make.height.mas_equalTo(60);
//            make.left.mas_equalTo(0);
//            make.top.mas_equalTo(0);
//            
//        }];
        
        
        _cellWechat = [[PayMethodSelectCell alloc] init];
        _cellWechat.imgIcon = [UIImage imageNamed:@"ic_wetchat"];
        _cellWechat.title = @"微信支付";
        _cellWechat.haveLine = YES;
        [_vContent addSubview:_cellWechat];
        [_cellWechat mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(60);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            
        }];
        
        
//        _cellAlipay = [[PayMethodSelectCell alloc] init];
//        _cellAlipay.imgIcon = [UIImage imageNamed:@"ic_zhifubao"];
//        _cellAlipay.title = @"支付宝支付";
//        _cellAlipay.haveLine = YES;
//        [_vContent addSubview:_cellAlipay];
//        [_cellAlipay mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
//            make.height.mas_equalTo(60);
//            make.left.mas_equalTo(0);
//            make.top.mas_equalTo(_cellWechat.mas_bottom).offset(0);
//            
//        }];
        
        
        _cellUnion = [[PayMethodSelectCell alloc] init];
        _cellUnion.imgIcon = [UIImage imageNamed:@"ic_union_pay"];
        _cellUnion.title = @"银联支付";
        _cellUnion.haveLine = NO;
        [_vContent addSubview:_cellUnion];
        [_cellUnion mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(60);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellWechat.mas_bottom).offset(0);
            
        }];
        
        
        UIButton *btnClose = [[UIButton alloc] init];
        btnClose.backgroundColor = Background_Color;
        [btnClose setTitle:@"关闭" forState:UIControlStateNormal];
        [btnClose setTitleColor:Secondary_Text_Color forState:UIControlStateNormal];
        btnClose.titleLabel.font = Font(16);
        [_vContent addSubview:btnClose];
        [btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellUnion.mas_bottom).offset(0);
            
        }];
        
        WS(ws);
        [[btnClose rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [ws close2];
            
        }];
        
    }
    
    return self;
}



- (void)addPayMethodSelectViewCloseBlock:(PayMethodSelectViewCloseBlock)closeBlock
{
    self.closeBlock = closeBlock;
}

- (void)show
{
    [UIView animateWithDuration:0.2 animations:^{
        
        _vContent.origin = CGPointMake(0, MAIN_SCREEN_HEIGHT-(60*2+49));
        
    }];
}

- (void)close
{
    [UIView animateWithDuration:0.2 animations:^{
        
        _vContent.origin = CGPointMake(0, MAIN_SCREEN_HEIGHT);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}
- (void)close2
{
    [UIView animateWithDuration:0.2 animations:^{
        
        _vContent.origin = CGPointMake(0, MAIN_SCREEN_HEIGHT);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
    if(self.closeBlock)
    {
        self.closeBlock();
    }
}



@end
