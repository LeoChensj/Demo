//
//  PhotoSelectView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "PhotoSelectView.h"

@implementation PhotoSelectView

- (instancetype)initWithViewController:(XbedViewController *)viewController
{
    if(self = [super init])
    {
        self.viewController = viewController;
        
        self.backgroundColor = [UIColor whiteColor];
        
        _cells = [NSMutableArray array];
        
        _btnAddPhoto = [[UIImageView alloc] init];
        _btnAddPhoto.userInteractionEnabled = YES;
        _btnAddPhoto.image = [UIImage imageNamed:@"ic_comment_add_picture"];
        [self addSubview:_btnAddPhoto];
        [_btnAddPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(PhotoSelectCellWidth);
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
            
        }];
        UITapGestureRecognizer *tapAddPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAddPhotoFunc)];
        [_btnAddPhoto addGestureRecognizer:tapAddPhoto];
    }
    
    return self;
}

- (void)tapAddPhotoFunc
{
    WS(ws);
    
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:4 delegate:nil];
    imagePickerVC.allowPickingVideo = NO;
    imagePickerVC.allowPickingOriginalPhoto = NO;
    imagePickerVC.selectedAssets = _selectedAssets;
    [self.viewController presentViewController:imagePickerVC animated:YES completion:nil];
    
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
        
        ws.selectedAssets = [NSMutableArray arrayWithArray:assets];
        ws.images = photos;
        
    }];
}


- (void)setImages:(NSArray<UIImage *> *)images
{
    _images = images;
    
    [_cells removeAllObjects];
    
    WS(ws);
    
    for (UIView *view in self.subviews)
    {
        if([view isMemberOfClass:[PhotoSelectCell class]])
        {
            [view removeFromSuperview];
        }
    }
    
    for(NSInteger i=0;i<images.count;i++)
    {
        PhotoSelectCell *cell = [[PhotoSelectCell alloc] init];
        cell.image = images[i];
        cell.asset = self.selectedAssets[i];
        [self addSubview:cell];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(PhotoSelectCellWidth);
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(15+(PhotoSelectCellWidth+20)*i);
            
        }];
        [_cells addObject:cell];
        
        
        [cell addPhotoSelectCellDeleteBlock:^(PhotoSelectCell *cell) {
            
            [_cells removeObject:cell];
            [ws.selectedAssets removeAllObjects];
            
            NSMutableArray <UIImage *>*imageArr = [NSMutableArray array];
            
            for(NSInteger i=0;i<_cells.count;i++)
            {
                [imageArr addObject:_cells[i].image];
                [ws.selectedAssets addObject:_cells[i].asset];
            }
            
            ws.images = imageArr;
            
        }];
    }
    
    if(images.count==0)
    {
        _btnAddPhoto.hidden = NO;
        
        [_btnAddPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(PhotoSelectCellWidth);
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
            
        }];
    }
    else if(images.count<4)
    {
        _btnAddPhoto.hidden = NO;
        
        [_btnAddPhoto mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(PhotoSelectCellWidth);
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(_cells.lastObject.mas_right).offset(20);
            
        }];
    }
    else
    {
        _btnAddPhoto.hidden = YES;
    }
    
}





@end
