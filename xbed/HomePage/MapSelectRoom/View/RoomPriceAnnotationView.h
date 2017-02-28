//
//  RoomPriceAnnotationView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface RoomPriceAnnotationView : MAAnnotationView
{
@private
    UILabel *_lbPrice;
}

@property (nonatomic, strong)NSNumber *price;//单位分

@end
