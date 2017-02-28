//
//  QiniuTokenRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface QiniuTokenRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *isPrivate;
@property (nonatomic, strong)NSString *source;

@end
