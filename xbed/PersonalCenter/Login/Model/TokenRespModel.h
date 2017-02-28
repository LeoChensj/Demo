//
//  TokenRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"
#import "LoginRespModel.h"

@interface TokenRespModel : XbedRespModel

@property (nonatomic, strong)LoginModel *data;

@end
