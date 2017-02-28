//
//  IssueInvoiceInfoView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "TouchView.h"
#import "InvoiceRespModel.h"

@interface IssueInvoiceInfoView : TouchView
{
@private
    UILabel *_lbTitle;
    UILabel *_lbPerson;
}

@property (nonatomic, strong)InvoiceModel *model;

@end
