//
//  AdvertView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  广告位

#import <UIKit/UIKit.h>
#import "AdvertModel.h"

@interface AdvertView : UIView
{
@private
    UIImageView *_imgvAdvert;
    UILabel *_lbTitle;
}

@property (nonatomic, strong)AdvertModel *model;

@end
