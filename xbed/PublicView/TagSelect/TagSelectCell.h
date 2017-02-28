//
//  TagSelectCell.h
//  xbed
//
//  Created by Leo.Chen on 16/8/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagModel.h"

@interface TagSelectCell : UICollectionViewCell
{
@private
    UILabel *_lbTitle;
}

@property (nonatomic, strong)TagModel *model;
@property (nonatomic, assign)NSInteger states;

@end
