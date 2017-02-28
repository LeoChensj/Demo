//
//  CameraViewController.m
//
//
//
//
//

#import "LLSimpleCamera.h"
#import <ImageIO/CGImageProperties.h>
#import "UIImage+FixOrientation.h"

@interface LLSimpleCamera (){
     UIView *_cleanView;
}
@property (nonatomic) CameraQuality cameraQuality;
@property (strong, nonatomic) UIView *preview;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureDevice *captureDevice;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@end

@implementation LLSimpleCamera
@synthesize captureDevice = _captureDevice;

- (instancetype)initWithQuality:(CameraQuality)quality {
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        self.cameraQuality = quality;
        self.fixOrientationAfterCapture = NO;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cameraFlash = CameraFlashOff;
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.autoresizingMask = UIViewAutoresizingNone;
    
    self.preview = [[UIView alloc] initWithFrame:CGRectZero];
    self.preview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.preview];
}

// attach camera view to a vc and provide the delegate
- (void)attachToViewController:(UIViewController *)vc withDelegate:(id<LLSimpleCameraDelegate>)delegate {
    self.delegate = delegate;
    [vc.view addSubview:self.view];
    [vc addChildViewController:self];
    [self didMoveToParentViewController:vc];
}

// start viewing the camera
- (void)start {
    
    if(!_session) {
    
        self.session = [[AVCaptureSession alloc] init];
        
        NSString *sessionPreset = nil;
        
        switch (self.cameraQuality) {
            case CameraQualityHigh:
                sessionPreset = AVCaptureSessionPresetHigh;
                break;
            case CameraQualityMedium:
                sessionPreset = AVCaptureSessionPresetMedium;
                break;
            case CameraQualityLow:
                sessionPreset = AVCaptureSessionPresetLow;
                break;
            default:
                sessionPreset = AVCaptureSessionPresetPhoto;
                break;
        }
        
        self.session.sessionPreset = sessionPreset;
        
        CALayer *viewLayer = self.preview.layer;
        
        AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        
        // set size
        CGRect bounds=viewLayer.bounds;
        captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        captureVideoPreviewLayer.bounds=bounds;
        captureVideoPreviewLayer.position=CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
        [self.preview.layer addSublayer:captureVideoPreviewLayer];
        
        self.captureVideoPreviewLayer = captureVideoPreviewLayer;
        
        // try to find the front facing camera
      //  __block AVCaptureDevice *_captureDevice = nil;
        
        [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            AVCaptureDevice *d = (AVCaptureDevice *)obj;
            if([d position] == AVCaptureDevicePositionFront){
                _captureDevice = d;
                *stop = YES;
            }
        }];
        
        // fallback to the default camera if no front facing camera was found
        if(!_captureDevice)
        
        _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:&error];

        if (!input) {
            // Handle the error appropriately.
            NSLog(@"ERROR: trying to open camera: %@", error);
            return;
        }
        
        
        [self.session addInput:input];
        
        self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
        [self.stillImageOutput setOutputSettings:outputSettings];
        [self.session addOutput:self.stillImageOutput];
    }
    
    [self.session startRunning];
}

// stop session
- (void)stop {
    [self.session stopRunning];
}

- (AVCaptureConnection *)captureConnection {
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.stillImageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    return videoConnection;
}

// capture an image
-(void)capture {
    
    AVCaptureConnection *videoConnection = [self captureConnection];
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
         CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
         if (exifAttachments) {
             // Do something with the attachments.
             //NSLog(@"attachements: %@", exifAttachments);
         } else {
             //NSLog(@"no attachments");
         }
         
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *image = [[UIImage alloc] initWithData:imageData];
         
        
         if(self.fixOrientationAfterCapture) {
             image = [image fixOrientation];
         }
        //人脸识别
         
         //等比例压缩
         CGSize sizeface = CGSizeMake(320.0f,480.0f);
         UIImage *imagelive= [self imageCompressForSize:image targetSize:sizeface];
         // 这里的mData是NSData对象，后面的0.5代表生成的图片质量
         // NSData *datalive  = UIImageJPEGRepresentation(imagelive,0.5);
         
         NSDictionary  *opts = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh
                                                           forKey:CIDetectorAccuracy]; // 2
         
         
         CIContext *context;
         CIDetector *Facedetector = [CIDetector detectorOfType:CIDetectorTypeFace
                                                       context:context
                                                       options:opts];
         
         CIImage  *imagelive1=   [CIImage imageWithCGImage:imagelive.CGImage];
         
         NSArray *features = [Facedetector featuresInImage:imagelive1];
         
         BOOL isSucess = true;

         if ([features count]==0) {
             NSLog(@">>>>> 人脸监测【失败】啦 ～！！！");
             isSucess=NO;
             NSString *showString = @"请对准脸部拍照！";
             [self showView:showString];
         }
         if(isSucess){
         if(self.delegate) {
              NSLog(@">>>>> 人脸监测【成功】～！！！>>>>>> ");
              NSData *imageData  = UIImageJPEGRepresentation(imagelive,0.8);
             NSString  *filename=@"kexin.jpg";
              
             
             [self writeApplicationData:imageData  toFile:filename];

             
             if ([self.delegate respondsToSelector:@selector(cameraViewController:didCaptureImage:)]) {
                 [self.delegate cameraViewController:self didCaptureImage:imagelive];
             }
         }
         }
     
     
     
     }];
}


- (BOOL)writeApplicationData:(NSData*)data toFile:(NSString*)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    if(!docDir) {
        NSLog(@"Documents directory not found!");
        return NO;
    }
    NSString *filePath = [docDir stringByAppendingPathComponent:fileName];
    return [data writeToFile:filePath atomically:YES];
}





//弹出视图
- (void)showView:(NSString *)string {
    
    if (_cleanView != nil) {
        
        return;
        
    }
    _cleanView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - 155)/ 2.0, 64 + KLeftWidth, 155, 40)];
    _cleanView.backgroundColor = [UIColor grayColor];
    _cleanView.alpha = .99;
    [self.view addSubview:_cleanView];
    
    UILabel *cleanLabel = [[UILabel alloc] initWithFrame:_cleanView.bounds];
    cleanLabel.text = string;
    cleanLabel.font = [UIFont systemFontOfSize:14.0];
    cleanLabel.textAlignment = NSTextAlignmentCenter;
    cleanLabel.textColor = [UIColor whiteColor];
    [_cleanView addSubview:cleanLabel];
    //移除视图
    [self performSelector:@selector(removeView) withObject:nil afterDelay:1];
    
    
}

//移除视图
- (void)removeView
{
    [_cleanView removeFromSuperview];
    _cleanView = nil;
}






//等比例压缩
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}





- (void)setCaptureDevice:(AVCaptureDevice *)captureDevice {
    _captureDevice = captureDevice;
    
    if(self.delegate) {
        if ([self.delegate respondsToSelector:@selector(cameraViewController:didChangeDevice:)]) {
            [self.delegate cameraViewController:self didChangeDevice:captureDevice];
        }
    }
}

- (BOOL)isFlashAvailable {
    AVCaptureInput* currentCameraInput = [self.session.inputs objectAtIndex:0];
    AVCaptureDeviceInput *deviceInput = (AVCaptureDeviceInput *)currentCameraInput;
    
    return deviceInput.device.isTorchAvailable;
}

-(void)setCameraFlash:(CameraFlash)cameraFlash {
    
    AVCaptureInput* currentCameraInput = [self.session.inputs objectAtIndex:0];
    AVCaptureDeviceInput *deviceInput = (AVCaptureDeviceInput *)currentCameraInput;
    
    if(!deviceInput.device.isTorchAvailable) {
        return;
    }
    
    _cameraFlash = cameraFlash;
    
    [self.session beginConfiguration];
    [deviceInput.device lockForConfiguration:nil];
    
    if(_cameraFlash == CameraFlashOn) {
        deviceInput.device.torchMode = AVCaptureTorchModeOn;
    }
    else {
        deviceInput.device.torchMode = AVCaptureTorchModeOff;
    }
    
    [deviceInput.device unlockForConfiguration];
    
    //Commit all the configuration changes at once
    [self.session commitConfiguration];
}

- (CameraPosition)togglePosition {
    if(self.cameraPosition == CameraPositionBack) {
        self.cameraPosition = CameraPositionFront;
    }
    else {
        self.cameraPosition = CameraPositionBack;
    }
    
    return self.cameraPosition;
}

- (CameraFlash)toggleFlash {
    if(self.cameraFlash == CameraFlashOn) {
        self.cameraFlash = CameraFlashOff;
    }
    else {
        self.cameraFlash = CameraFlashOn;
    }
    
    return self.cameraFlash;
}

- (void)setCameraPosition:(CameraPosition)cameraPosition
{
    if(_cameraPosition == cameraPosition) {
        return;
    }
    
    //Indicate that some changes will be made to the session
    [self.session beginConfiguration];
    
    //Remove existing input
    AVCaptureInput* currentCameraInput = [self.session.inputs objectAtIndex:0];
    [self.session removeInput:currentCameraInput];
    
    //Get new input
    AVCaptureDevice *newCamera = nil;
    if(((AVCaptureDeviceInput*)currentCameraInput).device.position == AVCaptureDevicePositionBack) {
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
    }
    else {
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
    }
    
    if(!newCamera) {
        return;
    }
    
    _cameraPosition = cameraPosition;
    
    // add input to session
    AVCaptureDeviceInput *newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:newCamera error:nil];
    [self.session addInput:newVideoInput];
    
    // commit changes
    [self.session commitConfiguration];
    
    self.captureDevice = newCamera;
}


// Find a camera with the specified AVCaptureDevicePosition, returning nil if one is not found
- (AVCaptureDevice *) cameraWithPosition:(AVCaptureDevicePosition) position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) return device;
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    NSLog(@"layout cameraVC : %d", self.interfaceOrientation);
    
    self.preview.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    CGRect bounds=self.preview.bounds;
    self.captureVideoPreviewLayer.bounds=bounds;
    self.captureVideoPreviewLayer.position=CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    
    AVCaptureVideoOrientation videoOrientation = AVCaptureVideoOrientationPortrait;
    
    /*
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
            videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIInterfaceOrientationLandscapeRight:
            videoOrientation = AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            videoOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        default:
            videoOrientation = AVCaptureVideoOrientationPortrait;
            break;
    }
    */
    
    self.captureVideoPreviewLayer.connection.videoOrientation = videoOrientation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


