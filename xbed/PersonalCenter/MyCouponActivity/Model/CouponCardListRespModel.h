//
//  CouponCardListRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"
#import "CalculatePriceRespModel.h"

@interface CouponCardListDataModel : XbedRespModel

@property (nonatomic, strong)NSArray <CouponCardModel *>*normals;
@property (nonatomic, strong)NSArray <CouponCardModel *>*disableds;

@end

@interface CouponCardListRespModel : XbedRespModel

@property (nonatomic, strong)CouponCardListDataModel *data;

@end
