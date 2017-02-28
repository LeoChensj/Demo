//
//  IssueInvoiceEnableMoneyView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "IssueInvoiceEnableMoneyView.h"

@implementation IssueInvoiceEnableMoneyView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbMoney = [[UILabel alloc] init];
        _lbMoney.textColor = Main_Text_Color;
        _lbMoney.textAlignment = NSTextAlignmentCenter;
        _lbMoney.font = Font(13);
        [self addSubview:_lbMoney];
        [_lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(20);
            make.center.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

- (void)setEnableInvoiceMoney:(NSNumber *)enableInvoiceMoney
{
    _enableInvoiceMoney = enableInvoiceMoney;
    
    NSString *string = [NSString stringWithFormat:@"可开票金额：￥%@", [NSNumber numberWithFloat:enableInvoiceMoney.floatValue/100]];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:(NSString *)NSForegroundColorAttributeName value:Blue_Color range:NSMakeRange(6, string.length-6)];
    [attrString addAttribute:(NSString *)NSFontAttributeName value:Font(16) range:NSMakeRange(6, string.length-6)];
    _lbMoney.attributedText = (NSAttributedString *)attrString;
}

@end
