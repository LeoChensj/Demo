//
//  NetworkOpenDoorNoticeView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkOpenDoorNoticeView : UIView
{
@private
    UILabel *_lbTitle;
    UILabel *_lbContent;
}

@property (nonatomic, assign, readonly)CGFloat myHeight;

@end
