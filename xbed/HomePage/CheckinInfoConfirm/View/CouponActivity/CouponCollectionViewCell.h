//
//  CouponCollectionViewCell.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeoRadioButton.h"
#import "CalculatePriceRespModel.h"

@interface CouponCollectionViewCell : UICollectionViewCell
{
@private
    UIView *_vTitle;
    UILabel *_lbTitle;
    UILabel *_lbCondition;
    UILabel *_lbDesc;
}

@property (nonatomic, strong, readonly)LeoRadioButton *btnRadio;

@property (nonatomic, strong)CouponCardModel *couponModel;
@property (nonatomic, assign)BOOL allowsSelection;
@property (nonatomic, assign)BOOL enable;//是否可用

@end
