//
//  CancleCheckinRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface CancleCheckinDataModel : XbedRespModel

@property (nonatomic, strong)NSNumber *type;

@end

@interface CancleCheckinRespModel : XbedRespModel

@property (nonatomic, strong)CancleCheckinDataModel *data;

@end
