//
//  IssueInvoiceMoneyInputView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IssueInvoiceMoneyInputView : UIView
{
@private
    UILabel *_lbMoney;
}

@property (nonatomic, strong)NSNumber *money;

@end
