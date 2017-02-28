//
//  SpeakerVerifyView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "SpeakerVerifyView.h"

@implementation SpeakerVerifyView

- (instancetype)init
{
    if(self = [super init])
    {
        _lbInfo = [[UILabel alloc] init];
        _lbInfo.text = @"收不到验证码？试试";
        _lbInfo.textColor = Secondary_Text_Color;
        _lbInfo.font = Font(13);
        [self addSubview:_lbInfo];
        [_lbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(13);
            make.left.centerY.mas_equalTo(0);
            
        }];
        
        
        _btnVerify = [[UIButton alloc] init];
        [_btnVerify setTitle:@"语音验证码" forState:UIControlStateNormal];
        [_btnVerify setTitleColor:Blue_Color forState:UIControlStateNormal];
        _btnVerify.titleLabel.font = Font(13);
        [self addSubview:_btnVerify];
        [_btnVerify mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(13);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(_lbInfo.mas_right).offset(-5);
            
        }];
        
        
    }
    
    return self;
}

- (void)setStates:(BOOL)states
{
    _states = states;
    
    if(states==NO)
    {
        _lbInfo.text = @"收不到验证码？试试";
        _btnVerify.hidden = NO;
    }
    else
    {
        __block NSInteger sec = 60;
        
        WS(ws);
        [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler] withLeeway:0] take:61] subscribeNext:^(id x) {
            
            if(sec>0)
            {
                ws.btnVerify.hidden = YES;
                
                NSString *title = [NSString stringWithFormat:@"请在%lds后重新获取", sec];
                ws.lbInfo.text = title;
                sec--;
            }
            else
            {
                ws.states = NO;
            }
            
        }];
    }
    
}



@end
