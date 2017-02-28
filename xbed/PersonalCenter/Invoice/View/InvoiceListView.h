//
//  InvoiceListView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvoiceRespModel.h"

@class InvoiceListCell;
typedef void (^InvoiceListCellBlock)(InvoiceListCell *cell, InvoiceModel *model);

@interface InvoiceListCell : UITableViewCell
{
@private
    UIImageView *_imgvIcon;
    UILabel *_lbTitle;
    UILabel *_lbPerson;
    
    UIButton *_button;
}

@property (nonatomic, strong)InvoiceModel *model;
@property (nonatomic, strong)InvoiceListCellBlock block;

- (void)addInvoiceListCellBlock:(InvoiceListCellBlock)block;

@end


@class InvoiceListView;
typedef void (^InvoiceListViewSelectIconBlock)(InvoiceListView *view, InvoiceModel *model, NSIndexPath *indexPath);
typedef void (^InvoiceListViewSelectIntoBlock)(InvoiceListView *view, InvoiceModel *model, NSIndexPath *indexPath);

@interface InvoiceListView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSArray <InvoiceModel *>*dataArray;
@property (nonatomic, strong)InvoiceListViewSelectIconBlock blockIcon;
@property (nonatomic, strong)InvoiceListViewSelectIntoBlock blockInto;

- (void)addInvoiceListViewSelectIconBlock:(InvoiceListViewSelectIconBlock)blockIcon invoiceListViewSelectIntoBlock:(InvoiceListViewSelectIntoBlock)blockInto;

@end
