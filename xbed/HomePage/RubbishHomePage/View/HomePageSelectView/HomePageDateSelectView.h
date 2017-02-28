//
//  HomePageDateSelectView.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "TouchView.h"

@interface HomePageDateSelectView : TouchView

@property (nonatomic, strong, readonly)UILabel *lbCheckin;
@property (nonatomic, strong, readonly)UILabel *lbCheckout;
@property (nonatomic, strong, readonly)UILabel *lbCheckinRemind;
@property (nonatomic, strong, readonly)UILabel *lbCheckoutRemind;
@property (nonatomic, strong, readonly)UILabel *lbNight;

@property (nonatomic, strong)NSDate *today;
@property (nonatomic, strong)NSDate *checkinDate;
@property (nonatomic, strong)NSDate *checkoutDate;

@end
