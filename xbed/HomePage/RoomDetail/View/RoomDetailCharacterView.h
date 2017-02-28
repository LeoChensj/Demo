//
//  RoomDetailCharacterView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/9.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  房间特色

#import <UIKit/UIKit.h>
#import "TextsView.h"

@interface RoomDetailCharacterView : UIView
{
@private
    UILabel *_lbTitle;
    TextsView *_textsView;
}

@property (nonatomic, strong, readonly)UIButton *btnAll;
@property (nonatomic, strong)NSString *character;
@property (nonatomic, strong)NSArray <NSString *>*characterArray;

@end
