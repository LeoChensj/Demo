//
//  RoomEvaluateBaseInfoView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomEvaluateBaseInfoView : UIButton
{
@private
    UIImageView *_imgvRoom;
    UILabel *_lbTitle;
    UILabel *_lbDesc;
    UIImageView *_imgvArrow;
}

@property (nonatomic, strong)NSString *roomImage;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *roomAddress;

@end
