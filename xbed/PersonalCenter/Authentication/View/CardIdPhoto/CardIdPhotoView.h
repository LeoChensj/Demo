//
//  CardIdPhotoView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CardIdPhotoViewWidth    (MAIN_SCREEN_WIDTH-20)
#define CardIdPhotoViewHeight   (MAIN_SCREEN_WIDTH-20)*4.0/7

@interface CardIdPhotoView : UIButton

@property (nonatomic, strong, readonly)UIImageView *imgvAddPhoto;
@property (nonatomic, strong, readonly)UILabel *lbTitle;
@property (nonatomic, strong, readonly)UILabel *lbDesc;
@property (nonatomic, strong, readonly)UIImageView *imgvPhoto;

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *photo;
@property (nonatomic, strong)UIImage *image;

@end
