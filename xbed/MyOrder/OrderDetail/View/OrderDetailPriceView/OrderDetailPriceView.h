//
//  OrderDetailPriceView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  订单金额

#import <UIKit/UIKit.h>
#import "OrderDetailPriceCell.h"
#import "CheckinOrderInfoRespModel.h"

@interface OrderDetailPriceView : UIView
{
@private
    OrderDetailPriceCell *_cellDeposit;
    OrderDetailPriceCell *_cellTotalPrice;
    OrderDetailPriceCell *_cellDiscount;
    OrderDetailPriceCell *_cellActualPrice;
}

@property (nonatomic, assign)NSInteger rentType;//0:短租  1:长租

@property (nonatomic, strong)NSNumber *orderType;
@property (nonatomic, strong)CheckinOrderPayInfoModel *payInfo;
@property (nonatomic, strong)NSNumber *actualPrice;

@property (nonatomic, assign, readonly)CGFloat myHeight;


@end
