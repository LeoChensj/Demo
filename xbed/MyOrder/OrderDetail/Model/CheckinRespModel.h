//
//  CheckinRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface CheckinDataModel : XbedRespModel

@property (nonatomic, strong)NSString *openPwd;
@property (nonatomic, strong)NSNumber *verify;

@end

@interface CheckinRespModel : XbedRespModel

@property (nonatomic, strong)CheckinDataModel *data;

@end
