//
//  LoginRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface LoginRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *source;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *password;

@end
