//
//  ComposeToolbar.h
//  demo
//
//  Created by lanou3g on 16/12/7.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ComposeToolbarCamera,
    ComposeToolbarPicture,
    ComposeToolbarAt,
    ComposeToolbarTrend,
    ComposeToolbarEmotion
}ComposeToolbarType;

@class ComposeToolbar;
@protocol ComposeToolbarDelegate <NSObject>

@optional
- (void)handleTool:(ComposeToolbar *)toolBar button:(ComposeToolbarType )index;

@end
@interface ComposeToolbar : UIView
@property (nonatomic ,assign)id<ComposeToolbarDelegate>delegate;
@property (nonatomic ,assign)BOOL showKeyBoard;
@end
