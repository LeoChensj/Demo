//
//  HomeMainRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface HomeMainModel : XbedModel

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *picPath;
@property (nonatomic, strong)NSString *remark;
@property (nonatomic, strong)NSString *url;

@end

@interface HomeMainDataModel : XbedModel

@property (nonatomic, strong)NSArray <HomeMainModel *>*advert1Array;
@property (nonatomic, strong)NSArray <HomeMainModel *>*advert2Array;
@property (nonatomic, strong)NSArray <HomeMainModel *>*advert3Array;
@property (nonatomic, strong)NSArray <HomeMainModel *>*advert4Array;
@property (nonatomic, strong)NSArray <NSString *>*cities;
@property (nonatomic, strong)NSArray <NSString *>*longRentCities;
@property (nonatomic, strong)NSDate *currTime;

@end

@interface HomeMainRespModel : XbedRespModel

@property (nonatomic, strong)HomeMainDataModel *data;

@end
