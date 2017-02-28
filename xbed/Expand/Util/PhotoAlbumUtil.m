//
//  PhotoAlbumUtil.m
//  xbed
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "PhotoAlbumUtil.h"
#import "MF_Base64Additions.h"

@implementation PhotoAlbumUtil

+ (PhotoAlbumUtil *)getInstance
{
    static PhotoAlbumUtil *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
        
    });
    
    return instance;
}

- (void)selectTakePhotoOrAlbum
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:_title
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照", @"从相册选择", nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)addPhotoAlbumUtilBlock:(PhotoAlbumUtilBlock)block
{
    _selectCompleteBlock = block;
}




#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex=%ld", buttonIndex);
    
    switch (buttonIndex)
    {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self selectFromAlbum];
            break;
            
        default:
            break;
    }
}


#pragma mark - UIImagePickerControllerDelegate
//选择了图片或者拍照了
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"])
    {
        UIImage *image;
        if(_allowsEditing)
        {
            image = [info valueForKey:UIImagePickerControllerEditedImage];
        }
        else
        {
            image = [info valueForKey:UIImagePickerControllerOriginalImage];
        }
        
        if(_delegate && [_delegate respondsToSelector:@selector(takePhotoOrSelectPhotoFromAlbumComplete:)])//判断是否实现代理协议
        {
            [_delegate takePhotoOrSelectPhotoFromAlbumComplete:image];
        }
        
        if(_selectCompleteBlock)
        {
            _selectCompleteBlock(image);
        }
        
        if(picker.sourceType==UIImagePickerControllerSourceTypeCamera)
        {
            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);//保存到相册
        }
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Helper
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
+ (NSString *)base64FromImage:(UIImage *)image
{
    NSString *base64 = nil;
    
    if(image)
    {
        NSData *dataImage = nil;
        if (UIImagePNGRepresentation(image) == nil)
            dataImage = UIImageJPEGRepresentation(image, 1);
        else
            dataImage = UIImagePNGRepresentation(image);
        
        base64 = [dataImage base64String];
    }
    
    return base64;
}
+ (NSData *)dataFromImage:(UIImage *)image
{
    NSData *dataImage = nil;
    if(UIImagePNGRepresentation(image)==nil)
    {
        dataImage = UIImageJPEGRepresentation(image, 1);
    }
    else
    {
        dataImage = UIImagePNGRepresentation(image);
    }
    
    return dataImage;
}




- (void)takePhoto
{
    NSLog(@"拍照");
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = _allowsEditing;
        picker.delegate = self;
        [[RootViewController getInstance] presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)selectFromAlbum
{
    NSLog(@"从相册选择");
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = _allowsEditing;
    picker.delegate = self;
    [[RootViewController getInstance] presentViewController:picker animated:YES completion:nil];
}



@end
