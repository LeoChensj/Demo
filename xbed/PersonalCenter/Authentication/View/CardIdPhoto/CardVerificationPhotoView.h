//
//  CardVerificationPhotoView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardIdPhotoView.h"

@interface CardVerificationPhotoView : UIView
{
@private
    CardIdPhotoView *_photoView1;
    CardIdPhotoView *_photoView2;
}

@property (nonatomic, strong)NSString *photo1;//set 服务端给的图片链接
//@property (nonatomic, strong)NSString *photo2;

@property (nonatomic, strong)UIImage *image1;//get 用于上传
//@property (nonatomic, strong)UIImage *image2;

@property (nonatomic, assign, readonly)CGFloat myHeight;

@end
