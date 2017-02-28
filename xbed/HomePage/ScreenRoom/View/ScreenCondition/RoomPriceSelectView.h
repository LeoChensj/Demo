//
//  RoomPriceSelectView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RangeSlider.h"

@interface RoomPriceSelectView : UIView

@property (nonatomic, strong, readonly)UILabel *lbTitle;
@property (nonatomic, strong, readonly)RangeSlider *slider;
@property (nonatomic, strong, readonly)UILabel *lbMinPrice;
@property (nonatomic, strong, readonly)UILabel *lbMaxPrice;

@property (nonatomic, assign)NSInteger rentType;

@property (nonatomic, strong)NSNumber *minPrice;//单位分
@property (nonatomic, strong)NSNumber *maxPrice;

- (instancetype)initWithRentType:(NSInteger)rentType;
- (void)reset;

@end
