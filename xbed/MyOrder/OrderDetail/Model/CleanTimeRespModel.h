//
//  CleanTimeRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"
#import "CheckinCleanRespModel.h"

@interface CleanTimeRespModel : XbedRespModel

@property (nonatomic, strong)CheckinCleanTimeModel *data;

@end
