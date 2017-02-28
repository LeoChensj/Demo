//
//  SubmitIdcardRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface SubmitIdcardRequestModel : XbedRequestModel

@property (nonatomic, strong)NSString *idNo;
@property (nonatomic, strong)NSString *idImage;
@property (nonatomic, strong)NSString *holdImage;
@property (nonatomic, strong)NSNumber *infoId;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSNumber *type;

@end
