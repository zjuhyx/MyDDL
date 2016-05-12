//
//  UndoneTableViewController.h
//  MyDDL
//
//  Created by 柯瀚仰 on 11/25/15.
//  Copyright © 2015 柯瀚仰. All rights reserved.
//

#import "DeadlineController.h"
#import <AVFoundation/AVFoundation.h>

@interface UndoneViewController : DeadlineController<AVCaptureMetadataOutputObjectsDelegate>{
    //图片2进制路径
    NSString* filePath;
}

@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

