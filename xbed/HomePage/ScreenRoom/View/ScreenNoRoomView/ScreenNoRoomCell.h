//
//  ScreenNoRoomCell.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenRoomRespModel.h"

@interface ScreenNoRoomCell : UICollectionViewCell
{
@private
    UILabel *_lbTitle;
    UIImageView *_imgvDel;
}

@property (nonatomic, strong)ScreenRoomTagModel *model;

@end
