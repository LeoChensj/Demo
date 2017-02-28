//
//  DateSelectView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateSelectView : UIButton
{
@private
    UILabel *_lbCheckinDate;
    UILabel *_lbCheckoutDate;
}

@property (nonatomic, strong)NSDate *checkinDate;
@property (nonatomic, strong)NSDate *checkoutDate;

@end
