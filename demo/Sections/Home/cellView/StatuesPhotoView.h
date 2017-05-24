//
//  StatuesPhotoView.h
//  demo
//
//  Created by lanou3g on 16/12/12.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusesModel.h"
@interface StatuesPhotoView : UIView
@property (nonatomic ,strong)StatusesModel *model;
@property (nonatomic ,strong)NSArray *photoArr;
@end
