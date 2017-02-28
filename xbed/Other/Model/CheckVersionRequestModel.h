//
//  CheckVersionRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface CheckVersionRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *channel;
@property (nonatomic, strong)NSString *macAddress;
@property (nonatomic, strong)NSString *systemName;
@property (nonatomic, strong)NSNumber *type;
@property (nonatomic, strong)NSString *versionNo;

@end
