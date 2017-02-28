//
//  OrderDetailOpenDoorPwdView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderDetailOpenDoorPwdView.h"

@implementation OrderDetailOpenDoorPwdView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *lbTitle = [[UILabel alloc] init];
        lbTitle.text = @"开门密码";
        lbTitle.textAlignment = NSTextAlignmentCenter;
        lbTitle.textColor = Main_Text_Color;
        lbTitle.font = Font(14);
        [self addSubview:lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(14);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(30);
            
        }];
        
        
        _lbPwd = [[UILabel alloc] init];
        _lbPwd.textAlignment = NSTextAlignmentCenter;
        _lbPwd.textColor = Blue_Color;
        _lbPwd.font = Font(28);
        [self addSubview:_lbPwd];
        [_lbPwd mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(180);
            make.height.mas_equalTo(28);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(lbTitle.mas_bottom).offset(25);
            
        }];
        
        
        _btnShowPwd = [[LeoRadioButton alloc] init];
        _btnShowPwd.normalImage = [UIImage imageNamed:@"icon_password_close"];
        _btnShowPwd.selectImage = [UIImage imageNamed:@"icon_password_open"];
        _btnShowPwd.on = NO;
        [self addSubview:_btnShowPwd];
        [_btnShowPwd mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(30);
            make.left.mas_equalTo(_lbPwd.mas_right).offset(0);
            make.centerY.mas_equalTo(_lbPwd.mas_centerY).offset(0);
            
        }];
        
        WS(ws);
        [[_btnShowPwd rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(LeoRadioButton *x) {
            
            if(ws.password)
            {
                if(x.on)
                {
                    ws.lbPwd.text = ws.password;
                }
                else
                {
                    ws.lbPwd.text = @"******";
                }
            }
            
        }];
        
        
        
        
        UILabel *lbRemind = [[UILabel alloc] init];
        lbRemind.numberOfLines = 0;
        lbRemind.text = @"请按密码键盘上任意键，灯亮起后输入开门密码，听到机械开门声后，尽快扭动把手。3-4秒后，门锁会自动锁上。";
        lbRemind.lineSpace = 4;
        lbRemind.textColor = Secondary_Text_Color;
        lbRemind.font = Font(12);
        [self addSubview:lbRemind];
        CGSize sizeRemind = [lbRemind labelSize:MAIN_SCREEN_WIDTH-20];
        [lbRemind mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(sizeRemind.height);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(_lbPwd.mas_bottom).offset(30);
            
        }];
        
        
        _myHeight = 30+14+25+28+30+sizeRemind.height+30;
        
    }
    
    return self;
}



- (void)setPassword:(NSString *)password
{
    _password = password;
    
    if(_btnShowPwd.on)
    {
        _lbPwd.text = password;
    }
    else
    {
        _lbPwd.text = @"******";
    }
}


@end
