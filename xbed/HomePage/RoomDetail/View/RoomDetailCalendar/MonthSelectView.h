//
//  MonthSelectView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthSelectView : UIView
{
@private
    UIImageView *_imgvLeft;
    UIImageView *_imgvRight;
    UILabel *_lbTitle;
}

@property (nonatomic, strong)NSDate *today;
@property (nonatomic, strong)NSDate *currentDate;//当前选中月份第一天的date
@property (nonatomic, strong)UIButton *btnLeft;
@property (nonatomic, strong)UIButton *btnRight;

- (void)addMonth;
- (void)subMonth;

@end
