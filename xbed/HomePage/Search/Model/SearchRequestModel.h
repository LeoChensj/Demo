//
//  SearchRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface SearchRequestModel : XbedRequestModel

@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSString *keyword;
@property (nonatomic, strong)NSString *tagTypeName;

@end
