//
//  RoomEvaluateContentView.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  已评价content展示

#import <UIKit/UIKit.h>

@interface RoomEvaluateContentView : UIView
{
@private
    UILabel *_lbContent;
}

@property (nonatomic, strong)NSString *content;

@end
