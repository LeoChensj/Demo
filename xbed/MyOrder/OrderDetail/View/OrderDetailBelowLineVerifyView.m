//
//  OrderDetailBelowLineVerifyView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderDetailBelowLineVerifyView.h"

@implementation OrderDetailBelowLineVerifyView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *lbTitle = [[UILabel alloc] init];
        lbTitle.text = @"按照法律要求，该房间还需去物业大堂验证身份证";
        lbTitle.textAlignment = NSTextAlignmentCenter;
        lbTitle.textColor = Red_Color;
        lbTitle.font = Font(14);
        [self addSubview:lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(14);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(20);
            
        }];
        
        _lbRemind = [[UILabel alloc] init];
        _lbRemind.textAlignment = NSTextAlignmentCenter;
        _lbRemind.textColor = Secondary_Text_Color;
        _lbRemind.font = Font(12);
        [self addSubview:_lbRemind];
        [_lbRemind mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(12);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(lbTitle.mas_bottom).offset(15);
            
        }];
        
        
        _button = [[UIButton alloc] init];
        _button.backgroundColor = [UIColor whiteColor];
        _button.layer.masksToBounds = YES;
        _button.layer.cornerRadius = 3;
        _button.layer.borderWidth = LINE_WIDTH;
        _button.layer.borderColor = Blue_Color.CGColor;
        [_button setTitle:@"拨打电话" forState:UIControlStateNormal];
        [_button setTitleColor:Blue_Color forState:UIControlStateNormal];
        _button.titleLabel.font = Font(13);
        [self addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(34);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_lbRemind.mas_bottom).offset(20);
            
        }];
        
        WS(ws);
        [[_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            CallPhone(ws.phone);
            
        }];
        
        
        _myHeight = 20+14+15+12+20+34+20;
    }
    
    return self;
}

- (void)setPhone:(NSString *)phone
{
    if(phone.length)
    {
        _phone = phone;
    }
    else
    {
        _phone = [DBManager getInstance].appUITextData.serviceTelephone;
    }
    
    _lbRemind.text = [NSString stringWithFormat:@"若您未找到验证身份人员，请联系我们(%@)", _phone];
}

@end
