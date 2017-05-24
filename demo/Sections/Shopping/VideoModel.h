//
//  VideoModel.h
//  demo
//
//  Created by wertyu on 17/5/18.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
/** 标题 */
@property (nonatomic, copy  ) NSString *title;
/** 描述 */
@property (nonatomic, copy  ) NSString *video_description;
/** 视频地址 */
@property (nonatomic, copy  ) NSString *playUrl;
/** 封面图 */
@property (nonatomic, copy  ) NSString *coverForFeed;

@end
