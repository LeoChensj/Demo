//
//  AroundRoomModel.h
//  xbed
//
//  Created by Leo.Chen on 16/7/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AroundRoomModel : NSObject

@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, strong)NSNumber *latitude;
@property (nonatomic, strong)NSNumber *longitude;
@property (nonatomic, strong)NSString *image;
@property (nonatomic, strong)NSString *title;

@end
