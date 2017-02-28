//
//  DBManager.h
//  xclear
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeoFileManager.h"
#import "DataModel.h"
#import "LoginRespModel.h"
#import "HomeMainRespModel.h"
#import "UIDataRespModel.h"

@interface DBManager : NSObject

@property (nonatomic, strong)NSString *version;
@property (nonatomic, strong)NSString *uuid;

@property (nonatomic, assign)BOOL isLogin;
@property (nonatomic, strong)NSString *token;
@property (nonatomic, strong)LoginModel *loginModel;
@property (nonatomic, strong)NSArray <NSString *>*xdollarRules;
@property (nonatomic, strong)HomeMainDataModel *homePageData;//首页数据
@property (nonatomic, strong)UIDataDataModel *appUITextData;//UI、文案数据


+ (DBManager *)getInstance;

+ (BOOL)isNewVersion;

@end
