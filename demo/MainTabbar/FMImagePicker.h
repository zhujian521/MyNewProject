//
//  FMImagePicker.h
//  demo
//
//  Created by wertyu on 17/5/23.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FMImagePicker : UIImagePickerController
@property (nonatomic ,copy)void (^videoBlock)(NSURL *videoUrl);
@end
