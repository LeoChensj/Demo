//
//  InvoiceRecordListView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvoiceRecordRespModel.h"
#import "MJRefresh.h"

@interface InvoiceRecordCell : UITableViewCell
{
@private
    UILabel *_lbPrice;
    UILabel *_lbTitle;
    UILabel *_lbState;
}

@property (nonatomic, strong)InvoiceRecordModel *model;

@end


@class InvoiceRecordListView;
typedef void (^InvoiceRecordListViewSelectItemBlock)(InvoiceRecordListView *view, InvoiceRecordModel *model, NSIndexPath *indexPath);
typedef void (^InvoiceRecordListViewLoadmoreBlock)(InvoiceRecordListView *view);

@interface InvoiceRecordListView : UITableView <UITableViewDataSource, UITableViewDelegate>
{
@private
    UILabel *_lbNoRecord;
}

@property (nonatomic, strong)NSArray <InvoiceRecordModel *>*dataArray;
@property (nonatomic, strong)InvoiceRecordListViewSelectItemBlock blockSelectItem;
@property (nonatomic, strong)InvoiceRecordListViewLoadmoreBlock blockLoadmore;

@property (nonatomic, strong, readonly)MJRefreshAutoStateFooter *footer;

- (void)addInvoiceRecordListViewSelectItemBlock:(InvoiceRecordListViewSelectItemBlock)blockSelectItem invoiceRecordListViewLoadmoreBlock:(InvoiceRecordListViewLoadmoreBlock)blockLoadmore;

@end
