//
//  CardVerificationTempView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardVerificationTempView : UIButton
{
@private
    UIImageView *_imgv1;
    UIImageView *_imgv2;
    UILabel *_lb1;
    UILabel *_lb2;
    UILabel *_lbRemind;
}

- (void)show;
- (void)close;

@end
