//
//  HomeViewController.m
//
//
//
//

#import "CameraViewController.h"
#import "ViewUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import "DialogView.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface CameraViewController ()
@property (strong, nonatomic) LLSimpleCamera *camera;
@property (strong, nonatomic) UIButton *snapButton;
@property (strong, nonatomic) UIButton *switchButton;
@property (strong, nonatomic) UIButton *flashButton;
@property (strong, nonatomic) UIButton *idface;
@property (strong, nonatomic) UIButton *finishButton;

@end

@implementation CameraViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if(miaotimer1)
    {
        [miaotimer1 invalidate];
    }
    
    if(self.camera)
    {
        [self.camera stop];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    // 弹出人脸验证框
    //为成员变量Window赋值则立即显示Window
    
    WS(ws);
    _guideview = [GuiderView title1:@"身份验证" callBlock1:^(MyWindowClick1 buttonIndex) {
        
        //Window隐藏，并置为nil，释放内存 不能少
        ws.guideview.hidden = YES;
        ws.guideview = nil;
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        ws.guideview.hidden = YES;
        ws.guideview = nil;
        
    });
    
    
    
    
    
    // create camera vc
    self.camera = [[LLSimpleCamera alloc] initWithQuality:CameraQualityPhoto];
    
    // attach to the view and assign a delegate
    [self.camera attachToViewController:self withDelegate:self];
    
    // set the camera view frame to size and origin required for your app
    self.camera.view.frame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);
    
    self.camera.fixOrientationAfterCapture = NO;
    
    
    // ----- camera buttons -------- //
    
    self.snapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.snapButton.frame = CGRectMake(kScreenWidth*0.5-99.5*0.5, kScreenHeight-110
                                       ,99.5f,88.5f);
    [self.snapButton setImage:[UIImage imageNamed:@"paizhao.png"] forState:UIControlStateNormal];
    [self.snapButton setImage:[UIImage imageNamed:@"paizhaoed.png"] forState:UIControlStateSelected];
    [self.snapButton addTarget:self action:@selector(snapButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.snapButton];
    _snapButton.hidden=YES;
    
    
    
    // button to toggle flash
    self.flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.flashButton.frame = CGRectMake(0, 0, 16.0f + 20.0f, 24.0f + 20.0f);
    [self.flashButton setImage:[UIImage imageNamed:@"camera-flash-off.png"] forState:UIControlStateNormal];
    [self.flashButton setImage:[UIImage imageNamed:@"camera-flash-on.png"] forState:UIControlStateSelected];
    self.flashButton.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    [self.flashButton addTarget:self action:@selector(flashButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.flashButton.hidden=YES;
    [self.view addSubview:self.flashButton];
    
    //face+
    UIImageView *face = [[UIImageView alloc] initWithFrame:CGRectMake(-15,15,kScreenWidth+30,kScreenHeight*0.85)];
    [face setImage:[UIImage imageNamed:@"face.png"]];
    
    [self.view addSubview:face];
    
    
    
    // button to toggle flash
    self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.finishButton.frame = CGRectMake(0,0,88,88);
    [self.finishButton setImage:[UIImage imageNamed:@"camera-finish.png"] forState:UIControlStateNormal];
    [self.finishButton setImage:[UIImage imageNamed:@"camera-finished.png"] forState:UIControlStateSelected];
    //   self.finishButton.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    [self.finishButton addTarget:self action:@selector(finishButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.finishButton];
    
    

    
    // button to toggle camera positions
    self.switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.switchButton.frame = CGRectMake(kScreenWidth*0.5-67*0.5,0,67.0f,60.0f);
    [self.switchButton setImage:[UIImage imageNamed:@"ic_camera_normal.png"] forState:UIControlStateNormal];
    // self.switchButton.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    [self.switchButton addTarget:self action:@selector(switchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.switchButton];
    
    //开启时间动画
    seconds=4;
    miaotimer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerthree:) userInfo:nil repeats:YES];
    
}

-(void)timerthree:(NSTimer *)theTimer {
    
    //开启自动识别－－
    if (seconds == 0)
    {
        [theTimer invalidate];
        
        
        [self delectButton];
        
        seconds = 4;
        _snapButton.hidden=NO;
        
        
    }
    else
    {
        
        UILabel* lblCountDown = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*0.5-40,kScreenHeight*0.5-60, 120, 120)];
        lblCountDown.textColor = [UIColor whiteColor];
        lblCountDown.font = [UIFont boldSystemFontOfSize:120];
        lblCountDown.backgroundColor = [UIColor clearColor];
        if(seconds==4){
            
        }else{
            lblCountDown.text =[NSString stringWithFormat:@"%d",seconds];
        }
        
        [self.view addSubview:lblCountDown];
        
        [UIView animateWithDuration:1
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             lblCountDown.alpha = 0;
                             lblCountDown.transform =CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
                         }
                         completion:^(BOOL finished) {
                             [lblCountDown removeFromSuperview];
                             //递归调用，直到计时为零
                             seconds--;
                         }];
        
        
    }
    
}




- (void)delectButton{
    
    [self.camera capture];
    
}

//setclick

- (void)finishButtonPressed:(UIButton *)button
{
    [[RootViewController getInstance] popViewControllerAnimated:YES];
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.camera start];
}

/* camera buttons */
- (void)switchButtonPressed:(UIButton *)button {
    [self.camera togglePosition];
}

- (void)flashButtonPressed:(UIButton *)button {
    
    CameraFlash flash = [self.camera toggleFlash];
    if(flash == CameraFlashOn) {
        self.flashButton.selected = YES;
    }
    else {
        self.flashButton.selected = NO;
    }
}

- (void)snapButtonPressed:(UIButton *)button {
    
    // capture the image, delegate will be executed
    [self.camera capture];
}

/* camera delegates */
- (void)cameraViewController:(LLSimpleCamera *)cameraVC didCaptureImage:(UIImage *)image {
    
    [self.camera stop];
    
    
    if(_picModels==nil)
    {
        _picModels = [NSMutableArray array];
    }
    else
    {
        [_picModels removeAllObjects];
    }
    
    KXPicModel *model = [[KXPicModel alloc] init];
    NSData *data = [PhotoAlbumUtil dataFromImage:image];
    model.data = data;
    model.code = @"0";
    [_picModels addObject:model];
    
    WS(ws);
    [LoadingView show];
    QiniuTokenRequestModel *tokenModel = [[QiniuTokenRequestModel alloc] init];
    tokenModel.isPrivate = [NSNumber numberWithBool:NO];
    tokenModel.source = @"iOS";
    QiniuTokenRequest *tokenRequest = [[QiniuTokenRequest alloc] initWithRequestModel:tokenModel];
    [tokenRequest startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
        
        QiniuTokenRespModel *tokenRespModel = [request responseModel];
        
        [LeoUploadQiniuManager uploadData:_picModels[0].data token:tokenRespModel.data isPrivate:NO paramet:nil success:^(id paramet, NSString *key, NSString *imageUrl) {
            
            NSLog(@"七牛上传图片成功");
            
            if(ws.picModels && ws.picModels.count>0)
            {
                ws.picModels[0].url = imageUrl;
                
                
                //调起接口人脸验证
                FaceVerificationRequestDataModel *dataModel = [[FaceVerificationRequestDataModel alloc] init];
                dataModel.url = ws.picModels[0].url;
                dataModel.code = ws.picModels[0].code;
                NSArray *dataArray = @[dataModel];
                
                FaceVerificationRequestModel *model = [[FaceVerificationRequestModel alloc] init];
                model.name = ws.viewModel.loginModel.name;
                model.idNo = ws.viewModel.loginModel.idNo;
                model.data = dataArray;
                FaceVerificationRequest *request = [[FaceVerificationRequest alloc] initWithRequestModel:model];
                [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                    
                    NSLog(@"人脸验证成功!");
                    
                    
                    [LoadingView close];
                    [[UIApplication sharedApplication].keyWindow makeToast:@"人脸识别成功！"];
                    
                    //更新loginModel
                    LoginModel *loginModel = [DBManager getInstance].loginModel;
                    loginModel.faceRecognition = [NSNumber numberWithBool:YES];
                    [DBManager getInstance].loginModel = loginModel;
                    
                    
                    NSMutableArray *tempVC = [NSMutableArray arrayWithArray:[RootViewController getInstance].viewControllers];
                    [tempVC removeLastObject];
                    [tempVC removeLastObject];
                    
                    [[RootViewController getInstance] setViewControllers:tempVC animated:YES];
                    
                } failure:^(__kindof LeoBaseRequest *request) {
                    
                    NSLog(@"人脸验证失败!");
                    NSLog(@"%@", [request getErrorMsg]);
                    [LoadingView close];
                    
                    FaceVerificationRespModel *respModel = [request responseModel];
                    
                    if(respModel)
                    {
                        [ws verifyFailHandelPop:NO retry:respModel.data.boolValue msg:[request getErrorMsg]];
                    }
                    else
                    {
                        [ws verifyFailHandelPop:YES retry:NO msg:[request getErrorMsg]];
                    }
                    
                }];
                
            }
            
        } failure:^{
            
            NSLog(@"七牛上传图片失败");
            
            [ws verifyFailHandelPop:NO retry:YES msg:@"上传图片失败"];
            
        }];

        
    } failure:^(__kindof LeoBaseRequest *request) {
        
        NSLog(@"获取七牛token失败");
        
        [LoadingView close];
        
        [ws verifyFailHandelPop:NO retry:YES msg:@"上传图片失败"];
        
    }];
    
    
    
    
    
    
    
    
    
    
}


- (void)verifyFailHandelPop:(BOOL)pop retry:(BOOL)retry msg:(NSString *)msg
{
    //清空
    [self.picModels removeAllObjects];
    
    if(pop)
    {
        [[RootViewController getInstance] popViewControllerAnimated:YES];
    }
    else
    {
        if(retry)
        {
            self.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:[NSString stringWithFormat:@"对不起，人脸识别失败\n%@", msg] cancelButtonTitle:@"手工上传" otherButtonTitle:@"再试一次" cancelButtonBlock:^{
                
                CardVerificationViewController *vc = [[CardVerificationViewController alloc] init];
                
                NSMutableArray *tempVC = [NSMutableArray arrayWithArray:[RootViewController getInstance].viewControllers];
                [tempVC removeLastObject];
                [tempVC removeLastObject];
                [tempVC addObject:vc];
                
                [[RootViewController getInstance] setViewControllers:tempVC animated:YES];
                
                
            } otherButtonBlock:^{
                
                [[RootViewController getInstance] popViewControllerAnimated:YES];
                
            }];
            [self.alertView show];
        }
        else
        {
            self.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"对不起，识别次数已达到上限，请手工上传身份证信息" cancelButtonTitle:@"确定" otherButtonTitle:nil cancelButtonBlock:^{
                
                CardVerificationViewController *vc = [[CardVerificationViewController alloc] init];
                
                NSMutableArray *tempVC = [NSMutableArray arrayWithArray:[RootViewController getInstance].viewControllers];
                [tempVC removeLastObject];
                [tempVC removeLastObject];
                [tempVC addObject:vc];
                
                [[RootViewController getInstance] setViewControllers:tempVC animated:YES];
                
            } otherButtonBlock:nil];
            [self.alertView show];
        }
    }
}


//32位MD5加密方式
- (NSString *)getMd5_32Bit_String:(NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];

    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}



- (void)cameraViewController:(LLSimpleCamera *)cameraVC didChangeDevice:(AVCaptureDevice *)device {
    
    // device changed, check if flash is available
    if(cameraVC.isFlashAvailable) {
        self.flashButton.hidden = NO;
    }
    else {
        self.flashButton.hidden = YES;
    }
    
    self.flashButton.selected = NO;
}

/* other lifecycle methods */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.camera.view.frame = self.view.contentBounds;
    
    self.snapButton.center = self.view.contentCenter;
    self.snapButton.bottom = self.view.height - 15;
    
    self.flashButton.center = self.view.contentCenter;
    self.flashButton.top = 5.0f;
    
    self.switchButton.top = 5.0f;
    self.switchButton.right = self.view.width - 5.0f;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end


