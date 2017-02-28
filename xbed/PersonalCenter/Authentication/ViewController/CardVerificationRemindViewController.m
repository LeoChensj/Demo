//
//  CardVerificationRemindViewController.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CardVerificationRemindViewController.h"


@implementation CardVerificationRemindViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"上传身份证验证";
    self.headView.imgLeft = @"ic_turn_off";
    self.headView.sizeLeft = CGSizeMake(19, 19);
    [self.view addSubview:self.headView];
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws dismissViewControllerAnimated:YES completion:nil];
        
    }];
}

- (void)setupView
{
    UIImageView *imgvIcon = [[UIImageView alloc] init];
    imgvIcon.image = [UIImage imageNamed:@"img_upload_success"];
    [self.view addSubview:imgvIcon];
    [imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(177);
        make.height.mas_equalTo(178);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(64+98*XSCALE);
        
    }];
    
    UILabel *lbRemind = [[UILabel alloc] init];
    lbRemind.text = @"上传身份证成功，请等待客服验证";
    lbRemind.textColor = Main_Text_Color;
    lbRemind.textAlignment = NSTextAlignmentCenter;
    lbRemind.font = Font(12);
    [self.view addSubview:lbRemind];
    [lbRemind mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(215);
        make.height.mas_equalTo(12);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(imgvIcon.mas_bottom).offset(25);
        
    }];
    
    UIButton *btnPhone = [[UIButton alloc] init];
    btnPhone.backgroundColor = Background_Color;
    btnPhone.layer.cornerRadius = 3;
    btnPhone.layer.borderColor = Blue_Color.CGColor;
    btnPhone.layer.borderWidth = 1;
    [btnPhone setTitle:@"拨打客服电话" forState:UIControlStateNormal];
    [btnPhone setTitleColor:Blue_Color forState:UIControlStateNormal];
    btnPhone.titleLabel.font = Font(12);
    [self.view addSubview:btnPhone];
    [btnPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(34);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(lbRemind.mas_bottom).offset(40);
        
    }];
    
    [[btnPhone rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        CallPhone([DBManager getInstance].appUITextData.serviceTelephone);
        
    }];
    
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
