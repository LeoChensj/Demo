//
//  CardVerificationViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CardVerificationViewController.h"
#import "CardVerificationTempView.h"
#import "PhotoAlbumUtil.h"
#import "CardVerificationRemindViewController.h"

@implementation CardVerificationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"上传身份证验证";
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _scrollView = [[TouchEventScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    _remindTempView = [[CardVerificationRemindTempView alloc] init];
    [_scrollView addSubview:_remindTempView];
    [_remindTempView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(_remindTempView.myHeight);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        
    }];
    
    
    _photoView = [[CardVerificationPhotoView alloc] init];
    [_scrollView addSubview:_photoView];
    [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(_photoView.myHeight);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_remindTempView.mas_bottom).offset(0);
        
    }];
    
    _inputView = [[CardVerificationInputView alloc] init];
    [_scrollView addSubview:_inputView];
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49*2);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_photoView.mas_bottom).offset(15);
        
    }];
    
    
    _btnSave = [[BlueEnableButton alloc] init];
    _btnSave.title = @"保 存";
    [_scrollView addSubview:_btnSave];
    [_btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_inputView.mas_bottom).offset(40);
        
    }];
    
    
    _remindView = [[AuthenticationRemindLabel alloc] init];
    [_scrollView addSubview:_remindView];
    [_remindView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(_remindView.myHeight);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_btnSave.mas_bottom).offset(30);
        
    }];
    
    
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_remindView.mas_bottom).offset(20);
        
    }];
}

- (void)bindViewModel
{
    RAC(_photoView, photo1) = RACObserve(self.viewModel, checkinPersonData.holdImage);
    RAC(_inputView, checkinPerson) = RACObserve(self.viewModel, checkinPersonData);
    
    
    WS(ws);
    [RACObserve(_photoView, image1) subscribeNext:^(UIImage *x) {
        
        if(x)
        {
            ws.viewModel.imageData1 = [PhotoAlbumUtil dataFromImage:[PhotoAlbumUtil imageWithImage:x scaledToSize:CGSizeMake(500, 500)]];
        }
        
    }];
    
    RAC(self.viewModel, checkinPersonData.name) = _inputView.cellName.tfValue.rac_textSignal;
    RAC(self.viewModel, checkinPersonData.idNo) = _inputView.cellCardId.tfValue.rac_textSignal;
    
    RAC(_btnSave, enabled) = self.viewModel.signalSave;
}

- (void)handleEvent
{
    WS(ws);
    
    [[self.viewModel.commandGetCheckinInfo execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)
        {
            [ws.view makeToast:x];
        }
        
    }];
    
    
    [_remindTempView addCardVerificationRemindTempViewBlock:^{
        
        NSLog(@"查看示例模板");
        
        CardVerificationTempView *tempView = [[CardVerificationTempView alloc] init];
        [tempView show];
        
    }];
    
    
    [[_btnSave rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [[ws.viewModel.commandSave execute:nil] subscribeNext:^(NSString *x) {
            
            if(x && x.length)
            {
                [ws.view makeToast:x];
            }
            else
            {
                [[UIApplication sharedApplication].keyWindow makeToast:@"保存成功"];
                
                //更新loginModel
                LoginModel *loginModel = [DBManager getInstance].loginModel;
                loginModel.state = [NSNumber numberWithInteger:1];
                [DBManager getInstance].loginModel = loginModel;
                
                PresentVC(CardVerificationRemindViewController);
                [[RootViewController getInstance] popViewControllerAnimated:NO];
            }
            
        }];
        
    }];
}



- (CardVerificationViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[CardVerificationViewModel alloc] init];
    }
    
    return _viewModel;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
