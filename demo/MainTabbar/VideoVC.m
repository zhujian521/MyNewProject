//
//  VideoVC.m
//  demo
//
//  Created by wertyu on 17/5/23.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import "VideoVC.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import "FMVideoPlayController.h"
#import "PlaceTextView.h"
#import "MBProgressHUD.h"
@interface VideoVC ()<UIScrollViewDelegate>
@property (nonatomic, strong)PlaceTextView *placeText;

@end

@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = NO;
    [self setUpNavigation];
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HIGHT)];
    scroll.contentSize = CGSizeMake(WIDTH, HIGHT + 10);
    scroll.delegate = self;
    [self.view addSubview:scroll];
    self.placeText = [[PlaceTextView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 80)];
    [scroll addSubview:self.placeText];
    self.placeText.placeholder = @"说点什么";

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 80, WIDTH, 220)];
    image.layer.masksToBounds = YES;
    image.contentMode = UIViewContentModeScaleAspectFill;
    image.userInteractionEnabled = YES;
    [scroll addSubview:image];
    image.image = [self getImage:self.url];
    
    UIButton *playBtn = [[UIButton alloc]init];
    [image addSubview:playBtn];
    playBtn.sd_layout.centerXEqualToView(image).centerYEqualToView(image).widthIs(50).heightIs(50);
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ZFPlayer" ofType:@"bundle"];
    NSString *strC = [[NSBundle bundleWithPath:path] pathForResource:@"ZFPlayer_play_btn@2x" ofType:@"png" inDirectory:nil];
    [playBtn setImage:[UIImage imageWithContentsOfFile:strC] forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(HandlePlay) forControlEvents:UIControlEventTouchUpInside];

    
}
- (void)HandlePlay {
    FMVideoPlayController *playVC = [[FMVideoPlayController alloc] init];
    playVC.videoUrl =  self.url;
    [self.navigationController pushViewController:playVC animated:YES];

}
- (UIImage *)getImage:(NSURL *)videoURL{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
}
- (void)setUpNavigation {
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
    self.navigationItem.leftBarButtonItem = leftBar;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    dic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [leftBar setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendMessage)];
    self.navigationItem.rightBarButtonItem = rightBar;
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    dic1[NSForegroundColorAttributeName] = [UIColor grayColor];
    [rightBar setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    
}
- (void)cancle {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)sendMessage {
    [self.view endEditing:YES];
    if (self.placeText.text.length == 0) {
        SHOW_ALERT22(@"请输入内容");
        return;
    }
    NSData *data = [NSData dataWithContentsOfURL:self.url];
    NSLog(@"===%ldkb",data.length/1024);

    NSURL *sourceURL = self.url;
    NSLog(@"压缩之前%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:sourceURL]]);
    NSLog(@"压缩之前%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[sourceURL path]]]);
    NSURL *newVideoUrl ; //一般.mp4
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
    [formater setDateFormat:@"yyyy-MM-dd-HHmmss"];
    newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
    [self convertVideoQuailtyWithInputURL:sourceURL outputURL:newVideoUrl completeHandler:nil];
    
}
- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    //  NSLog(resultPath);
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:
                 NSLog(@"压缩后%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:outputURL]]);
                 NSLog(@"压缩后%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[outputURL path]]]);
                 
                 //UISaveVideoAtPathToSavedPhotosAlbum([outputURL path], self, nil, NULL);//这个是保存到手机相册
                 
                 [self alertUploadVideo:outputURL];
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
         
     }];
    
}

- (CGFloat) getFileSize:(NSString *)path
{
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}//此方法可以获取文件的大小，返回的是单位是KB。
- (CGFloat) getVideoLength:(NSURL *)URL
{
    
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}//此方法可以获取视频文件的时长。
- (void)alertUploadVideo:(NSURL *)outPutUrl {
    dispatch_sync(dispatch_get_main_queue(), ^(){
        NSString *url = [NSString stringWithFormat:@"http://120.77.211.200/image/upload"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"bb2c2f6d-44bb-4c33-9cbc-03c4fda37a38" forKey:@"TokenID"];
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.label.text = @"上传中";
        NSLog(@"++++++++++++++");
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSData *data = [NSData dataWithContentsOfURL:outPutUrl];
            NSLog(@"===%ldkb",data.length/1024);
            [formData appendPartWithFileData:data name:@"pictureFile" fileName:@".mp4" mimeType:@"video/mp4"];
            //             [formData appendPartWithFileURL:outPutUrl name:@"pictureFile" fileName:@".mp4" mimeType:@"application/octet-stream" error:nil];
            
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"++++++++++++++");
            [HUD setHidden:YES];
            NSString *message = [responseObject objectForKey:@"message"];
            NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
            if (status == 1) {
                [[NSFileManager defaultManager] removeItemAtPath:[outPutUrl path] error:nil];//取消之后就删除
                SHOW_ALERT22(message);
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [HUD setHidden:YES];
            
        }];

    });

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
