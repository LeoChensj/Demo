//
//  InvoiceRecordDetailView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvoiceRecordRespModel.h"

@interface InvoiceRecordDetailCell : UIView
{
@private
    UILabel *_lbTitle;
    UILabel *_lbValue;
    UIView *_line;
}

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *value;
@property (nonatomic, strong)UIColor *valueColor;
@property (nonatomic, assign)BOOL haveLine;

@end



@interface InvoiceRecordDetailView : UIScrollView
{
@private
    InvoiceRecordDetailCell *_cellState;
    InvoiceRecordDetailCell *_cellPrice;
    InvoiceRecordDetailCell *_cellTitle;
    InvoiceRecordDetailCell *_cellType;
    InvoiceRecordDetailCell *_cellCompany;
    InvoiceRecordDetailCell *_cellNo;
    InvoiceRecordDetailCell *_cellRealName;
    InvoiceRecordDetailCell *_cellPhone;
    InvoiceRecordDetailCell *_cellArea;
    InvoiceRecordDetailCell *_cellAddress;
}

@property (nonatomic, strong)InvoiceRecordModel *invoiceRecordDetail;

@end
