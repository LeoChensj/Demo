//
//  UpdateCheckinPersonRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  暂时不用

#import "XbedRequestModel.h"

@interface UpdateCheckinPersonRequestModel : XbedRequestModel

@property (nonatomic, strong)NSString *idNo;
@property (nonatomic, strong)NSString *idImage;
@property (nonatomic, strong)NSString *holdImage;
@property (nonatomic, strong)NSNumber *infoId;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSNumber *type;
@property (nonatomic, strong)NSNumber *userId;

@end
