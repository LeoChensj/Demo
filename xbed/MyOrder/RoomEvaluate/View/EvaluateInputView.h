//
//  EvaluateInputView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluateInputView : UIView

@property (nonatomic, strong, readonly)UILabel *lbRemind;
@property (nonatomic, strong, readonly)FSTextView *textView;

@property (nonatomic, strong)NSString *content;

@end
