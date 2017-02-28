//
//  RoomDetailTagCell.h
//  xbed
//
//  Created by Leo.Chen on 16/8/4.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  房间特色标签cell

#import <UIKit/UIKit.h>

@interface RoomDetailTagCell : UICollectionViewCell
{
@private
    UILabel *_lbTitle;
}

@property (nonatomic, strong)NSString *title;

@end
