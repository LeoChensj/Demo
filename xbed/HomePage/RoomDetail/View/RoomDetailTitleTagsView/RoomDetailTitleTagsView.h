//
//  RoomDetailTitleTagsView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/4.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomDetailTagCollectionView.h"

@interface RoomDetailTitleTagsView : UIView
{
@private
    UILabel *_lbTitle;
    UILabel *_lbLongRentRemind;
    RoomDetailTagCollectionView *_tagsView;
    UIView *_line;
    
    CGFloat _heightTitle;
}

@property (nonatomic, assign)NSInteger rentType;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSArray <NSString *>*dataArray;

- (instancetype)initWithRentType:(NSInteger)rentType;

@end
