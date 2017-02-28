//
//  InvoiceOrderSelectView.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  发票 订单选择列表

#import <UIKit/UIKit.h>
#import "LeoRadioButton.h"
#import "InvoiceOrderRespModel.h"
#import "MJRefresh.h"

@class InvoiceOrderSelectHeaderView;
typedef void(^InvoiceOrderSelectHeaderViewSelectBlock)(InvoiceOrderSelectHeaderView *view, BOOL state);

@interface InvoiceOrderSelectHeaderView : UITableViewHeaderFooterView
{
@private
    UIView *_vWhite;
    LeoRadioButton *_btnSelect;
    UILabel *_lbTitle;
}

@property (nonatomic, strong)NSString *title;
@property (nonatomic, assign)BOOL state;//NO：未选中  YES：选中
@property (nonatomic, strong)InvoiceOrderSelectHeaderViewSelectBlock block;

- (void)addInvoiceOrderSelectHeaderViewSelectBlock:(InvoiceOrderSelectHeaderViewSelectBlock)block;

@end



@interface InvoiceOrderSelectCell : UITableViewCell
{
@private
    LeoRadioButton *_btnSelect;
    UILabel *_lbTitle;
    UIImageView *_imgvRoom;
    UILabel *_lbDate;
    UILabel *_lbDesc;
    UILabel *_lbPrice;
}

@property (nonatomic, strong)CheckinOrderListModel *model;

@end





typedef void (^InvoiceOrderSelectViewLoadmoreBlock)(MJRefreshAutoStateFooter *footerView);

@interface InvoiceOrderSelectView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSArray <OrderListContnetModel *>*dataArray;
@property (nonatomic, strong)InvoiceOrderSelectViewLoadmoreBlock loadmoreBlock;
@property (nonatomic, strong)NSMutableArray <OrderListContnetModel *>*selectOrder;
@property (nonatomic, strong)NSNumber *invoicePrice;

@property (nonatomic, strong, readonly)MJRefreshAutoStateFooter *footer;


- (void)addInvoiceOrderSelectViewLoadmoreBlock:(InvoiceOrderSelectViewLoadmoreBlock)loadmoreBlock;

@end
