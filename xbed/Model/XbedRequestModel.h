//
//  XbedRequestModel.h
//  xclear
//
//  Created by Leo.Chen on 16/6/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface XbedRequestModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong)NSDictionary *requestDict;

- (id)requestParam;
- (id)headerParam;

@end
