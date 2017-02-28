//
//  ShareView.h
//  xbed
//
//  Created by Leo.Chen on 16/10/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewCell : UIButton
{
@private
    UIImageView *_imgvIcon;
    UILabel *_lbTitle;
}

@property (nonatomic, strong)UIImage *icon;
@property (nonatomic, strong)NSString *title;

@end


@interface ShareView : UIView
{
@private
    UIView *_vContent;
}

@property (nonatomic, strong)id viewController;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *descr;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)UIImage *image;

@end
