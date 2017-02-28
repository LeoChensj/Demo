//
//  RoomDetailNoticeView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/9.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextsView.h"

@interface RoomDetailNoticeView : UIView
{
@private
    UILabel *_lbTitle;
    TextsView *_textsView;
}

@property (nonatomic, strong, readonly)UIButton *btnAll;
@property (nonatomic, strong)NSString *notice;
@property (nonatomic, strong)NSArray <NSString *>*noticeArray;

@end
