//
//  DefaultView.h
//  xbed
//
//  Created by Leo.Chen on 16/3/21.
//  Copyright © 2016年 liujialin125. All rights reserved.
//  缺省页

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, DefaultType)
{
    DefaultViewNoNetwork = 1,
    DefaultViewNoSearchRoom,
    DefaultViewNoConditonRoom,
    DefaultViewNoOrder,
    DefaultViewNoCollectionRoom,
    DefaultViewNoMessage,
    DefaultViewNoXdollar,
    DefaultViewNoCoupon,
    DefaultViewNoInvoice,
    DefaultViewNoLoginWithOrder,
    DefaultViewNoLoginWithCollectionRoom,
    DefaultViewNoActivity
};

@interface DefaultView : UIButton
{
@private
    UIImageView *_imageView;
    UILabel *_lbTitle;
}

@property (nonatomic, assign)DefaultType type;
@property (nonatomic, strong, readonly, nullable)UIButton *button;


- (nullable id)initWithType:(DefaultType)type;
//- (void)addTarget:(nullable id)target action:(nonnull SEL)action;


@end
