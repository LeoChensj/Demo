//
//  MyButton.h
//  zuyaya
//
//  Created by 0 on 13-9-3.
//  Copyright (c) 2013年 0. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyButton : UIButton
{
    NSString *_url;
}
@property(nonatomic,copy)NSString *url;
@end
