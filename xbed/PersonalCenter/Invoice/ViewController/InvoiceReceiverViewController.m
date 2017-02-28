//
//  InvoiceReceiverViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/9/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceReceiverViewController.h"
#import "AreaPickerView.h"

@implementation InvoiceReceiverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
    
    if(self.viewModel.type==2)
    {
        self.headView.title = @"编辑收件人";
        self.headView.txtRight = @"删除";
        [[self.headView.btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            NSLog(@"删除发票");
            
            [[ws.viewModel.commandDelInvoice execute:nil] subscribeNext:^(NSString *x) {
                
                if(x && x.length)
                {
                    [ws.view makeToast:x];
                }
                else
                {
                    [ws.view makeToast:@"删除成功"];
                    
                    [ws back];
                }
                
            }];
            
            
        }];
    }
    else if(self.viewModel.type==1)
    {
        self.headView.title = @"添加发票信息";
    }
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
    
    _cellTitle = [[InputTableCell alloc] init];
    _cellTitle.title = @"发票抬头";
    _cellTitle.haveLine = YES;
    [_scrollView addSubview:_cellTitle];
    [_cellTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(15);
        
    }];
    
    _cellRealName = [[InputTableCell alloc] init];
    _cellRealName.title = @"收件人";
    _cellRealName.haveLine = YES;
    [_scrollView addSubview:_cellRealName];
    [_cellRealName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_cellTitle.mas_bottom).offset(0);
        
    }];
    
    _cellRealName = [[InputTableCell alloc] init];
    _cellRealName.title = @"收件人";
    _cellRealName.haveLine = YES;
    [_scrollView addSubview:_cellRealName];
    [_cellRealName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_cellTitle.mas_bottom).offset(0);
        
    }];
    
    _cellPhone = [[InputTableCell alloc] init];
    _cellPhone.title = @"联系电话";
    _cellPhone.haveLine = NO;
    _cellPhone.keyboardType = UIKeyboardTypePhonePad;
    [_scrollView addSubview:_cellPhone];
    [_cellPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_cellRealName.mas_bottom).offset(0);
        
    }];
    
    _cellArea = [[NormalTableCell2 alloc] init];
    _cellArea.title = @"选择地区";
    _cellArea.titleColor = Main_Text_Color;
    _cellArea.valueColor = Main_Text_Color;
    _cellArea.haveLine = YES;
    _cellArea.haveArrow = YES;
    [_scrollView addSubview:_cellArea];
    [_cellArea mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_cellPhone.mas_bottom).offset(10);
        
    }];
    
    _cellAddress = [[InputTableCell alloc] init];
    _cellAddress.title = @"详细地址";
    _cellAddress.haveLine = NO;
    [_scrollView addSubview:_cellAddress];
    [_cellAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_cellArea.mas_bottom).offset(0);
        
    }];
    
    
    
    _btnSave = [[BlueEnableButton alloc] init];
    _btnSave.title = @"保存";
    [_scrollView addSubview:_btnSave];
    [_btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_cellAddress.mas_bottom).offset(40);
        
    }];
    
    if(self.viewModel.type==1)
    {
        _cellPhone.value = self.viewModel.invoiceModel.phone;
    }
    else if(self.viewModel.type==2)
    {
        _cellTitle.value = self.viewModel.invoiceModel.title;
        _cellRealName.value = self.viewModel.invoiceModel.realname;
        _cellPhone.value = self.viewModel.invoiceModel.phone;
        _cellAddress.value = self.viewModel.invoiceModel.address;
    }
}

- (void)bindViewModel
{
    RAC(self.viewModel, invoiceModel.title) = _cellTitle.tfValue.rac_textSignal;
    RAC(self.viewModel, invoiceModel.realname) = _cellRealName.tfValue.rac_textSignal;
    RAC(self.viewModel, invoiceModel.phone) = _cellPhone.tfValue.rac_textSignal;
    RAC(self.viewModel, invoiceModel.address) = _cellAddress.tfValue.rac_textSignal;
    
    RAC(_btnSave, enabled) = self.viewModel.signalInvoice;
}

- (void)handleEvent
{
    WS(ws);
    
    [self.viewModel.signalArea subscribeNext:^(NSNumber *x) {
        
        if(x.boolValue)
        {
            ws.cellArea.value = [NSString stringWithFormat:@"%@－%@－%@", ws.viewModel.invoiceModel.provinceName, ws.viewModel.invoiceModel.cityName, ws.viewModel.invoiceModel.countyName];
        }
        
    }];
    
    
    [[_cellArea rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws.view endEditing:YES];
        
        AreaPickerView *areaPickerView = [[AreaPickerView alloc] initWithProvinceId:ws.viewModel.invoiceModel.province cityId:ws.viewModel.invoiceModel.city countyId:ws.viewModel.invoiceModel.county];
        [ws.view addSubview:areaPickerView];
        [areaPickerView addAreaPickerCompleteListener:^(LocalProvinceModel *province, LocalCityModel *city, LocalCountyModel *county) {
            
            ws.viewModel.invoiceModel.province = province.id;
            ws.viewModel.invoiceModel.provinceName = province.name;
            
            ws.viewModel.invoiceModel.city = city.id;
            ws.viewModel.invoiceModel.cityName = city.name;
            
            ws.viewModel.invoiceModel.county = county.id;
            ws.viewModel.invoiceModel.countyName = county.name;
            
        }];
        
    }];
    
    
    
    [[_btnSave rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        if(ws.viewModel.type==1)//添加发票
        {
            [[ws.viewModel.commandAddInvoice execute:nil] subscribeNext:^(NSString *x) {
                
                if(x && x.length)
                {
                    [ws.view makeToast:x];
                }
                else
                {
                    [ws.view makeToast:@"添加成功"];
                    
                    [ws back];
                }
                
            }];
        }
        else if(ws.viewModel.type==2)//修改发票
        {
            [[ws.viewModel.commandUpdateInvoice execute:nil] subscribeNext:^(NSString *x) {
                
                if(x && x.length)
                {
                    [ws.view makeToast:x];
                }
                else
                {
                    [ws.view makeToast:@"修改成功"];
                    
                    [ws back];
                }
                
            }];
        }
        
    }];
}




- (InvoiceReceiverViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[InvoiceReceiverViewModel alloc] init];
    }
    
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
