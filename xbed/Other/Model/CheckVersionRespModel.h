//
//  CheckVersionRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface CheckVersionDataModel : XbedRespModel

@property (nonatomic, strong)NSString *appPath;
@property (nonatomic, strong)NSNumber *id;
@property (nonatomic, strong)NSNumber *upgrade;//1为强制升级，0为非强制

@end

@interface CheckVersionRespModel : XbedRespModel

@property (nonatomic, strong)CheckVersionDataModel *data;

@end
