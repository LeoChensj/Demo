//
//  DataModel.h
//  xclean
//
//  Created by Leo.Chen on 16/6/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "XbedRespModel.h"

@interface DataModel : XbedModel

@end



@interface UserInfo : DataModel

@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *password;

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password;

@end