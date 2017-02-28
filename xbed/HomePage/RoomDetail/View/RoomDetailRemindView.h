//
//  RoomDetailRemindView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextsView.h"

@interface RoomDetailRemindView : UIView
{
@private
    UILabel *_lbTitle;
    TextsView *_textsView;
}

@property (nonatomic, strong)UIColor *remindColor;
@property (nonatomic, strong)NSString *remind;//h5解析
@property (nonatomic, strong)NSArray <NSString *>*remindArray;

@end
