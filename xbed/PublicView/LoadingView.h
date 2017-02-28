//
//  LoadingView.h
//  xbed
//
//  Created by Leo.Chen on 15/12/18.
//  Copyright © 2015年 liujialin125. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

@property (nonatomic, strong)UIImageView *imageView;

+ (LoadingView *)getInstance;

+ (void)show;
+ (void)close;

@end
