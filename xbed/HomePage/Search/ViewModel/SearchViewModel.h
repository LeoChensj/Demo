//
//  SearchViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/7/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "SearchRecordManager.h"
#import "RubbishHomePageViewModel.h"

@interface SearchViewModel : XbedViewModel

@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSString *inputText;
@property (nonatomic, strong)UITextRange *markedTextRange;
@property (nonatomic, strong)NSString *locateCity;
@property (nonatomic, strong)NSNumber *longitude;
@property (nonatomic, strong)NSNumber *latitude;
@property (nonatomic, strong)NSArray <NSString *>*hotCityData;
@property (nonatomic, strong)NSArray <SearchRecordModel *>*recordData;
@property (nonatomic, strong)NSArray <SearchDataModel *>*associateListData;
@property (nonatomic, strong)RubbishHomePageViewModel *homePageViewModel;


@property (nonatomic, strong, readonly)RACSignal *signalInput;//输入框确认，开始联想
@property (nonatomic, strong, readonly)RACSignal *signalLocate;
@property (nonatomic, strong, readonly)RACCommand *commandGetHotCityFromLocal;
@property (nonatomic, strong, readonly)RACCommand *commandGetHotCityFromNetwork;
@property (nonatomic, strong, readonly)RACCommand *commandAddSearchRecord;
@property (nonatomic, strong, readonly)RACCommand *commandClearSearchRecord;
@property (nonatomic, strong, readonly)RACCommand *commandGetAssociateData;

@end
