//
//  InvoiceRecordDetailView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceRecordDetailView.h"

@implementation InvoiceRecordDetailCell

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(13);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(65);
            make.height.mas_equalTo(13);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
            
        }];
        
        
        _lbValue = [[UILabel alloc] init];
        _lbValue.textColor = Main_Text_Color;
        _lbValue.textAlignment = NSTextAlignmentRight;
        _lbValue.font = Font(13);
        [self addSubview:_lbValue];
        [_lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-80-10);
            make.height.mas_equalTo(13);
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-10);
            
        }];
        
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = Seg_Line_Color;
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.bottom.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}
- (void)setValue:(NSString *)value
{
    _value = value;
    
    _lbValue.text = value;
}
- (void)setValueColor:(UIColor *)valueColor
{
    _valueColor = valueColor;
    
    _lbValue.textColor = valueColor;
}
- (void)setHaveLine:(BOOL)haveLine
{
    _haveLine = haveLine;
    
    _line.hidden = !haveLine;
}

@end



@implementation InvoiceRecordDetailView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor  = Background_Color;
        self.showsVerticalScrollIndicator = NO;
        self.alwaysBounceVertical = YES;
        self.contentInset = UIEdgeInsetsMake(15, 0, 10, 0);
        self.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH, 10+490+10);
        
        _cellState = [[InvoiceRecordDetailCell alloc] init];
        _cellState.title = @"邮寄状态";
        _cellState.valueColor = Blue_Color;
        [self addSubview:_cellState];
        [_cellState mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            
        }];
        
        _cellPrice = [[InvoiceRecordDetailCell alloc] init];
        _cellPrice.title = @"开票金额";
        [self addSubview:_cellPrice];
        [_cellPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellState.mas_bottom).offset(0);
            
        }];
        
        _cellTitle = [[InvoiceRecordDetailCell alloc] init];
        _cellTitle.title = @"发票抬头";
        [self addSubview:_cellTitle];
        [_cellTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellPrice.mas_bottom).offset(0);
            
        }];
        
        _cellType = [[InvoiceRecordDetailCell alloc] init];
        _cellType.title = @"发票类型";
        _cellType.value = @"普通增值税发票";
        [self addSubview:_cellType];
        [_cellType mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellTitle.mas_bottom).offset(0);
            
        }];
        
        _cellCompany = [[InvoiceRecordDetailCell alloc] init];
        _cellCompany.title = @"快递公司";
        [self addSubview:_cellCompany];
        [_cellCompany mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellType.mas_bottom).offset(0);
            
        }];
        
        _cellNo = [[InvoiceRecordDetailCell alloc] init];
        _cellNo.title = @"快递单号";
        _cellNo.haveLine = NO;
        [self addSubview:_cellNo];
        [_cellNo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellCompany.mas_bottom).offset(0);
            
        }];
        
        _cellRealName = [[InvoiceRecordDetailCell alloc] init];
        _cellRealName.title = @"收件人";
        [self addSubview:_cellRealName];
        [_cellRealName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellNo.mas_bottom).offset(10);
            
        }];
        
        _cellPhone = [[InvoiceRecordDetailCell alloc] init];
        _cellPhone.title = @"联系电话";
        [self addSubview:_cellPhone];
        [_cellPhone mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellRealName.mas_bottom).offset(0);
            
        }];
        
        _cellArea = [[InvoiceRecordDetailCell alloc] init];
        _cellArea.title = @"城市区域";
        [self addSubview:_cellArea];
        [_cellArea mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellPhone.mas_bottom).offset(0);
            
        }];
        
        _cellAddress = [[InvoiceRecordDetailCell alloc] init];
        _cellAddress.title = @"详细地址";
        _cellAddress.haveLine = NO;
        [self addSubview:_cellAddress];
        [_cellAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellArea.mas_bottom).offset(0);
            
        }];
        
    }
    
    return self;
}

- (void)setInvoiceRecordDetail:(InvoiceRecordModel *)invoiceRecordDetail
{
    _invoiceRecordDetail = invoiceRecordDetail;
    
    if(invoiceRecordDetail.postStatus.integerValue==1)
    {
        _cellState.value = @"未寄出";
    }
    else if(invoiceRecordDetail.postStatus.integerValue==2)
    {
        _cellState.value = @"已寄出";
    }
    else if(invoiceRecordDetail.postStatus.integerValue==3)
    {
        _cellState.value = @"派送中";
    }
    else if(invoiceRecordDetail.postStatus.integerValue==4)
    {
        _cellState.value = @"已签收";
    }
    
    _cellPrice.value = [NSString stringWithFormat:@"￥%@", [NSNumber numberWithFloat:invoiceRecordDetail.price.floatValue/100]];
    _cellTitle.value = invoiceRecordDetail.title;
    _cellCompany.value = invoiceRecordDetail.expressCompany;
    _cellNo.value = invoiceRecordDetail.expressNum;
    _cellRealName.value = invoiceRecordDetail.realname;
    _cellPhone.value = invoiceRecordDetail.phone;
    _cellArea.value = [NSString stringWithFormat:@"%@%@%@", invoiceRecordDetail.provinceName, invoiceRecordDetail.cityName, invoiceRecordDetail.countyName];
    _cellAddress.value = invoiceRecordDetail.address;
}



@end
