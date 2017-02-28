//
//  RoomImagesView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/4.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "BannerView.h"

#define RoomImagesViewHeight (MAIN_SCREEN_WIDTH*2/3)

@interface RoomImagesView : BannerView
{
@private
    UILabel *_lbIndex;
}

@property (nonatomic, strong, readonly)UIImage *coverImage;

@end
