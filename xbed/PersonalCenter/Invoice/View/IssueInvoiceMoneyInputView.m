//
//  IssueInvoiceMoneyInputView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "IssueInvoiceMoneyInputView.h"

@implementation IssueInvoiceMoneyInputView

- (instancetype)init
{
    if(self = [super init])
    {
        UIView *vInfo = [[UIView alloc] init];
        vInfo.backgroundColor = Background_Color;
        [self addSubview:vInfo];
        [vInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.top.mas_equalTo(0);
            
        }];
        
        UILabel *lbType = [[UILabel alloc] init];
        lbType.text = @"发票类型：    增值税发票";
        lbType.textColor = Secondary_Text_Color;
        lbType.font = Font(13);
        [vInfo addSubview:lbType];
        [lbType mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(155);
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        UILabel *lbContent = [[UILabel alloc] init];
        lbContent.text = @"发票内容：   住宿费";
        lbContent.textColor = Secondary_Text_Color;
        lbContent.textAlignment = NSTextAlignmentRight;
        lbContent.font = Font(13);
        [vInfo addSubview:lbContent];
        [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(15);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        UIView *vMoney = [[UIView alloc] init];
        vMoney.backgroundColor = [UIColor whiteColor];
        [self addSubview:vMoney];
        [vMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(vInfo.mas_bottom).offset(0);
            
        }];
        
        UILabel *lbMoney = [[UILabel alloc] init];
        lbMoney.text = @"发票金额";
        lbMoney.textColor = Main_Text_Color;
        lbMoney.font = Font(13);
        [vMoney addSubview:lbMoney];
        [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        
        _lbMoney = [[UILabel alloc] init];
        _lbMoney.textColor = Main_Text_Color;
        _lbMoney.font = Font(13);
        [vMoney addSubview:_lbMoney];
        [_lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-90-10);
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(90);
            make.centerY.mas_equalTo(0);

            
        }];
        
    }
    
    return self;
}

- (void)setMoney:(NSNumber *)money
{
    _money = money;
    
    _lbMoney.text = [NSNumber numberWithFloat:money.integerValue*0.01].stringValue;
}


@end
