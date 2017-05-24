//
//  StatuesPhotoView.m
//  demo
//
//  Created by lanou3g on 16/12/12.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "StatuesPhotoView.h"
#import "SDPhotoBrowser.h"
#define PhotoMaxCol(count) ((count == 4)?2:3)

@interface StatuesPhotoView ()<SDPhotoBrowserDelegate>
@property (nonatomic ,strong)UIImageView *tempView;
@property (nonatomic ,strong)NSMutableArray *tempViewArr;
@end
@implementation StatuesPhotoView

- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setPhotoArr:(NSArray *)photoArr {
    _photoArr = photoArr;
    while (self.subviews.count < photoArr.count) {
        UIImageView *photoView = [[UIImageView alloc]init];
        photoView.contentMode = UIViewContentModeScaleAspectFill;
        photoView.layer.masksToBounds = YES;
        photoView.userInteractionEnabled = YES;
        [self addSubview:photoView];
        
    }
    self.tempViewArr = [NSMutableArray array];
    for (int i = 0; i < self.subviews.count; i ++) {
        UIImageView *tempView = self.subviews[i];
        if (i < photoArr.count) {
            tempView.hidden = NO;
            NSDictionary *tempDic =photoArr[i];
            tempView.tag = i;
             [tempView sd_setImageWithURL:[NSURL URLWithString:tempDic[@"thumbnail_pic"]] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapClikePicture:)];
            [tempView addGestureRecognizer:tap];
            [self.tempViewArr addObject:tempView];
        } else {
            tempView.hidden = YES;
        }
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    int max = PhotoMaxCol(self.photoArr.count);
    for (int i = 0; i < self.photoArr.count; i ++) {
         UIImageView *tempView = self.subviews[i];
      tempView.height = tempView.width = pictureWidth;
        int clo = i % max ;
        int row = i / max ;
        tempView.x = clo * (pictureWidth + pictureMargin) + 20;
        tempView.y = row * (pictureWidth + pictureMargin);
        
    }
}
- (void)handleTapClikePicture:(UITapGestureRecognizer *)sender {
    UIImageView *image = (UIImageView *)sender.view;
    NSLog(@"=====%ld",image.tag);
    self.tempView = image;
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = image.tag;
    photoBrowser.imageCount = _photoArr.count;
    photoBrowser.sourceImagesContainerView = self;
    [photoBrowser show];

}
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
  
    UIImageView *image = self.tempViewArr[index];
    return image.image;
    
}
@end
