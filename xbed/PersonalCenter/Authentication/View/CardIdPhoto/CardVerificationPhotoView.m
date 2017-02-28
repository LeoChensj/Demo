//
//  CardVerificationPhotoView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CardVerificationPhotoView.h"

@implementation CardVerificationPhotoView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _photoView1 = [[CardIdPhotoView alloc] init];
        _photoView1.title = @"身份证正面照";
        [self addSubview:_photoView1];
        [_photoView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(CardIdPhotoViewWidth);
            make.height.mas_equalTo(CardIdPhotoViewHeight);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            
        }];
        
//        _photoView2 = [[CardIdPhotoView alloc] init];
//        _photoView2.title = @"手持身份证正面照";
//        [self addSubview:_photoView2];
//        [_photoView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.width.mas_equalTo(CardIdPhotoViewWidth);
//            make.height.mas_equalTo(CardIdPhotoViewHeight);
//            make.left.mas_equalTo(10);
//            make.top.mas_equalTo(_photoView1.mas_bottom).offset(10);
//            
//        }];

        //_myHeight = CardIdPhotoViewHeight*2+30;
        _myHeight = CardIdPhotoViewHeight+20;
        
        RAC(self, image1) = RACObserve(_photoView1, image);
        //RAC(self, image2) = RACObserve(_photoView2, image);
    }
    
    return self;
}





- (void)setPhoto1:(NSString *)photo1
{
    _photo1 = photo1;
    
    _photoView1.photo = photo1;
}
//- (void)setPhoto2:(NSString *)photo2
//{
//    _photo2 = photo2;
//    
//    _photoView2.photo = photo2;
//}



@end
