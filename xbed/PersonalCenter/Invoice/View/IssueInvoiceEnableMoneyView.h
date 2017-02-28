//
//  IssueInvoiceEnableMoneyView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  可开票金额  弃用

#import <UIKit/UIKit.h>

@interface IssueInvoiceEnableMoneyView : UIView
{
@private
    UILabel *_lbMoney;
}

@property (nonatomic, strong)NSNumber *enableInvoiceMoney;//可开发票金额

@end
