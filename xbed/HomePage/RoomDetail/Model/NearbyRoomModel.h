//
//  NearbyRoomModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearbyRoomModel : NSObject

@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)NSString *image;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *roomType;
@property (nonatomic, strong)NSNumber *person;
@property (nonatomic, strong)NSNumber *score;
@property (nonatomic, strong)NSNumber *distance;
@property (nonatomic, strong)NSNumber *price;

@end
