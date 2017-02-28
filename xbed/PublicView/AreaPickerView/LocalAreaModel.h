//
//  localAreaModel.h
//  xbed
//
//  Created by Leo.Chen on 16/4/22.
//  Copyright © 2016年 liujialin125. All rights reserved.
//  从本地json文件获取

#import "XbedRespModel.h"

@interface LocalCountyModel : XbedModel

@property (nonatomic, strong)NSNumber *id;
@property (nonatomic, strong)NSString *name;
//@property (nonatomic, strong)NSArray *childList;

@end

@interface LocalCityModel : XbedModel

@property (nonatomic, strong)NSNumber *id;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSArray <LocalCountyModel *>*childList;

@end

@interface LocalProvinceModel : XbedModel

@property (nonatomic, strong)NSNumber *id;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSArray <LocalCityModel *>*childList;

@end

@interface LocalAreaModel : XbedModel

@property (nonatomic, strong)NSArray <LocalProvinceModel *>*area;

@end



