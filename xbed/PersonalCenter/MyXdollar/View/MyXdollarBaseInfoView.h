//
//  MyXdollarBaseInfoView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXWaveView.h"

@interface MyXdollarBaseInfoView : UIView
{
@private
    UIImageView *_imgvCircle;
    UILabel *_lbXdollar;
    UILabel *_lbArrived;//可抵x元
    WXWaveView *_waveView;
}

@property (nonatomic, strong)NSNumber *xdollar;

@end
