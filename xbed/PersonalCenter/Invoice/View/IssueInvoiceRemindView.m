//
//  IssueInvoiceRemindView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "IssueInvoiceRemindView.h"

@implementation IssueInvoiceRemindView

- (instancetype)init
{
    if(self = [super init])
    {
        UILabel *lbTitle = [[UILabel alloc] init];
        lbTitle.text = @"关于发票寄出：";
        lbTitle.textColor = Secondary_Text_Color;
        lbTitle.font = Font(12);
        [self addSubview:lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            
        }];
        
        
        
        NSString *remind = @"1.申请开票后我们会尽快寄出；\n2.发票金额为实付金额；\n3.请确定发票信息及邮寄地址。若重新开发票，邮费自行承担；\n4.仅开具个人账户支付的发票，企业账户的发票统一由管理员开具。";
        
        _lbValue = [[UILabel alloc] init];
        _lbValue.numberOfLines = 0;
        _lbValue.text = remind;
        _lbValue.lineSpace = 5;
        _lbValue.textColor = Secondary_Text_Color;
        _lbValue.font = Font(12);
        [self addSubview:_lbValue];
        CGSize size = [_lbValue labelSize:MAIN_SCREEN_WIDTH-20];
        [_lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(size.height);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(lbTitle.mas_bottom).offset(10);
            
        }];
        
        _myHeight = 81+size.height;
    }
    
    return self;
}

@end
