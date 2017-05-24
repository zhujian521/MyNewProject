//
//  EmotionListView.m
//  demo
//
//  Created by lanou3g on 16/12/9.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "EmotionListView.h"
#import "EmotionContentView.h"
#define pagesize 20

@interface EmotionListView ()<UIScrollViewDelegate>
@property (nonatomic ,strong)UIScrollView *scrollview;
@property (nonatomic ,strong)UIPageControl *pageControl;
@end
@implementation EmotionListView

- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
        UIPageControl *pagecontrol = [[UIPageControl alloc]init];
        pagecontrol.backgroundColor = [UIColor whiteColor];
        [pagecontrol setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
        [pagecontrol setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
        [self addSubview:pagecontrol];
        self.pageControl = pagecontrol;
        
        
        UIScrollView *scrollview = [[UIScrollView alloc]init];
        scrollview.backgroundColor = [UIColor whiteColor];
        scrollview.delegate = self;
        scrollview.pagingEnabled = YES;
        scrollview.showsHorizontalScrollIndicator = NO;
        scrollview.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollview];
        self.scrollview = scrollview;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.pageControl.width = WIDTH;
    self.pageControl.height = 30;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
   
    
    self.scrollview.x = self.scrollview.y = 0;
    self.scrollview.width = WIDTH;
    self.scrollview.height = self.pageControl.y;
    
    self.pageControl.numberOfPages = (self.motionArr.count + pagesize - 1) / pagesize;
    self.scrollview.contentSize = CGSizeMake(WIDTH * self.pageControl.numberOfPages, self.scrollview.height);
  for (int i = 0; i < self.pageControl.numberOfPages; i ++) {
        EmotionContentView *contentView = [[EmotionContentView alloc]init];
       
        contentView.width = self.scrollview.width;
        contentView.height = self.scrollview.height;
        contentView.x = i * self.scrollview.width;
        contentView.y = 0;
      
      NSRange range;
      range.location = i * pagesize;
      NSUInteger left = self.motionArr.count - range.location;
      if (left >= pagesize) {
          range.length = pagesize;
      } else {
          range.length = left;
      }
       contentView.pageArr = [self.motionArr subarrayWithRange:range];
         [self.scrollview addSubview:contentView];
    }
   

    
}
- (void)setMotionArr:(NSArray *)motionArr {
    _motionArr = motionArr;
}
#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
}

@end
