//
//  ServiceCell.h
//  xbed
//
//  Created by Leo.Chen on 16/8/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  配套设施及服务

#import <UIKit/UIKit.h>

@interface ServiceCell : UICollectionViewCell
{
@private
    UIImageView *_imgvIcon;
    UILabel *_lbTitle;
}

@property (nonatomic, strong)NSString *title;

@end
