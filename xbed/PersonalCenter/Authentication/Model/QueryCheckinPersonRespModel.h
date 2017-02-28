//
//  QueryCheckinPersonRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface QueryCheckinPersonDataModel : XbedRespModel

@property (nonatomic, strong)NSString *QiNiu_token;
@property (nonatomic, strong)NSString *idNo;
@property (nonatomic, strong)NSString *idImage;
@property (nonatomic, strong)NSString *holdImage;
@property (nonatomic, strong)NSNumber *infoId;
@property (nonatomic, strong)NSString *name;

@end

@interface QueryCheckinPersonRespModel : XbedRespModel

@property (nonatomic, strong)QueryCheckinPersonDataModel *data;

@end
