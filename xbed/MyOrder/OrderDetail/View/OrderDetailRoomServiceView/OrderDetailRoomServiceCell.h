//
//  OrderDetailRoomServiceCell.h
//  xbed
//
//  Created by Leo.Chen on 16/9/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "TouchView.h"

@interface OrderDetailRoomServiceCell : TouchView
{
@private
    UIImageView *_imgvIcon;
    UILabel *_lbTitle;
    UILabel *_lbDesc;
}

@property (nonatomic, strong)UIImage *imageIcon;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *desc;

@property (nonatomic, assign, readonly)CGFloat myHeight;

@end
