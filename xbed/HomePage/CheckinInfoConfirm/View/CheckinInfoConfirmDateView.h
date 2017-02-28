//
//  CheckinInfoConfirmDateView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateSelectView.h"

@interface CheckinInfoConfirmDateView : UIView
{
@private
    DateSelectView *_dateSelectView;
    UILabel *_lbRemind;
}

@property (nonatomic, strong, readonly)UIButton *button;

@property (nonatomic, strong)NSDate *checkinDate;
@property (nonatomic, strong)NSDate *checkoutDate;

@end
