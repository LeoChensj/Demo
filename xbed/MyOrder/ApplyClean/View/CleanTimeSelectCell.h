//
//  CleanTimeSelectCell.h
//  xbed
//
//  Created by Leo.Chen on 16/9/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CleanTimeSelectCellBlock)(NSInteger states);

@interface CleanTimeSelectCell : UIButton

@property (nonatomic, strong)NSString *title;
@property (nonatomic, assign)NSInteger states;//0：不可点击  1：可点击，未选中  2：可点击，已选中

@property (nonatomic, strong)CleanTimeSelectCellBlock block;


- (void)addCleanTimeSelectCellBlock:(CleanTimeSelectCellBlock)block;

@end
