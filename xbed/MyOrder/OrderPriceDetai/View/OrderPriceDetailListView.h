//
//  OrderPriceDetailListView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderPriceDetailCell.h"
#import "CheckinOrderInfoRespModel.h"

@interface OrderPriceDetailListView : UIView
{
@private
    UILabel *_lbDate;
    UILabel *_lbPrice;
    UIScrollView *_scrollView;
    
    OrderPriceDetailCell *_cellDeposit;
    OrderPriceDetailCell *_cellTotalPrice;
    OrderPriceDetailCell *_cellDiscount;
    OrderPriceDetailCell *_cellActualPrice;
}

@property (nonatomic, assign)NSInteger rentType;
@property (nonatomic, strong)CheckinOrderPayInfoModel *payInfo;
@property (nonatomic, strong)NSNumber *actualPrice;//应付金额，自己计算

- (instancetype)initWithRentType:(NSInteger)rentType;

@end
