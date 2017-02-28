//
//  OrderListStateSelectCell.h
//  xbed
//
//  Created by Leo.Chen on 16/8/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListStateSelectCell : UIButton
{
@private
    UIView *_vRed;
}

@property (nonatomic, strong)NSString *title;
@property (nonatomic, assign)NSInteger states;  //0：黑色  1：蓝色
@property (nonatomic, assign)BOOL isNew;        //NO：无小红点  YES：有小红点
@property (nonatomic, assign)NSInteger index;

@end
