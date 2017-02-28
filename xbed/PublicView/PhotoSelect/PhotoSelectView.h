//
//  PhotoSelectView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoSelectCell.h"
#import "TZImagePickerController.h"

@interface PhotoSelectView : UIView
{
@private
    NSMutableArray <PhotoSelectCell *>*_cells;
    UIImageView *_btnAddPhoto;
}

@property (nonatomic, strong)XbedViewController *viewController;
@property (nonatomic, strong)NSMutableArray *selectedAssets;
@property (nonatomic, strong)NSArray <UIImage *>*images;


- (instancetype)initWithViewController:(XbedViewController *)viewController;

@end
