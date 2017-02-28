//
//  XbedRespModel.h
//  xclear
//
//  Created by Leo.Chen on 16/6/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface XbedModel : MTLModel <MTLJSONSerializing>

@end

@interface XbedRespModel : XbedModel

@property (nonatomic, strong)NSNumber *status;
@property (nonatomic, strong)NSNumber *retCode;
@property (nonatomic, strong)NSString *msg;
//data

@end

@interface PictureModel : XbedModel

@property (nonatomic, strong)NSNumber *cover;
@property (nonatomic, strong)NSString *filePath;

@end
