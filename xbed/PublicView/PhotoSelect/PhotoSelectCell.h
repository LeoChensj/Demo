//
//  PhotoSelectCell.h
//  xbed
//
//  Created by Leo.Chen on 16/8/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PhotoSelectCellWidth (MAIN_SCREEN_WIDTH-30-20*3)/4

@class PhotoSelectCell;
typedef void (^PhotoSelectCellDeleteBlock)(PhotoSelectCell *cell);

@interface PhotoSelectCell : UIView
{
@private
    UIImageView *_imgvPhoto;
    UIImageView *_imgvDelete;
    UIButton *_btnDelete;
}

@property (nonatomic, strong)UIImage *image;
@property (nonatomic, strong)id asset;
@property (nonatomic, strong)PhotoSelectCellDeleteBlock block;

- (void)addPhotoSelectCellDeleteBlock:(PhotoSelectCellDeleteBlock)block;

@end
