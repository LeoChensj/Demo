//
//  EvaluatePhotoView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoSelectView.h"

@interface EvaluatePhotoView : UIView
{
@private
    UILabel *_lbTitle;
    UILabel *_lbRemind;
    PhotoSelectView *_photoSelectView;
}

@property (nonatomic, strong)XbedViewController *viewController;
@property (nonatomic, strong)NSArray <NSData *>*datas;

- (instancetype)initWithViewController:(XbedViewController *)viewController;

@end
