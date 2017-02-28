//
//  DataModel.m
//  xclean
//
//  Created by Leo.Chen on 16/6/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "DataModel.h"


@implementation DataModel

@end





@implementation UserInfo

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password
{
    if(self = [super init])
    {
        _phone = phone;
        _password = password;
    }
    
    return self;
}

@end
