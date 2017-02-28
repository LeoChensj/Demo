//
//  FeedbackInputView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackInputView : UIView

@property (nonatomic, strong, readonly)UILabel *lbRemind;
@property (nonatomic, strong, readonly)FSTextView *textView;

@property (nonatomic, strong)NSString *content;

@end
