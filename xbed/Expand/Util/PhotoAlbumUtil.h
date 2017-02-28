//
//  PhotoAlbumUtil.h
//  xbed
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void (^PhotoAlbumUtilBlock)(UIImage * _Nullable image);

@protocol PhotoAlbumUtilDelegate <NSObject>

@optional
- (void)takePhotoOrSelectPhotoFromAlbumComplete:(nullable UIImage *)image;

@end



@interface PhotoAlbumUtil : NSObject <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, assign)BOOL allowsEditing;
@property (nullable, nonatomic, strong)NSString *title;
@property (nullable, nonatomic, assign)id<PhotoAlbumUtilDelegate> delegate;
@property (nullable, nonatomic, strong)PhotoAlbumUtilBlock selectCompleteBlock;


+ (nonnull PhotoAlbumUtil *)getInstance;
+ (nullable UIImage *)imageWithImage:(nullable UIImage *)image scaledToSize:(CGSize)newSize;//压缩图片
+ (nullable NSString *)base64FromImage:(nullable UIImage *)image;//image转为base64
+ (nullable NSData *)dataFromImage:(nullable UIImage *)image;

- (void)selectTakePhotoOrAlbum;
- (void)addPhotoAlbumUtilBlock:(nullable PhotoAlbumUtilBlock)block;

@end
