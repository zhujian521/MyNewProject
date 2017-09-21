//
//  TwoHomeViewController.m
//  demo
//
//  Created by 北京启智 on 2016/11/21.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "TwoHomeViewController.h"
#import "DroprightMenu.h"
#import "PopButtonView.h"
#import "ShoppingVC.h"
#import "StepVC.h"
#import "arcView.h"
#import <HealthKit/HealthKit.h>

@interface TwoHomeViewController ()
@property (nonatomic ,strong)UIView *rightView;
@property (nonatomic ,strong)arcView *view1;
@property (nonatomic, strong)HKHealthStore *healthStore;

@end

@implementation TwoHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavigation];
    
    self.view1  =[[arcView alloc]initWithFrame:CGRectMake(0,64, WIDTH,WIDTH)];
//    view1.arcDelegate = self;
    self.view1.backgroundColor = [UIColor whiteColor];
    self.view1.num = 0;
    [self.view addSubview:self.view1];
    [self handel];
    
    UIButton *popButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 60, HIGHT - 200, 50, 50)];
    [self.view addSubview:popButton];
    [popButton setImage:[UIImage imageNamed:@"tabbar_compose_more"] forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(handleClike:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setUpNavigation {
    // style : 这个参数是用来设置背景的，在iOS7之前效果比较明显, iOS7中没有任何效果
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发现群" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor grayColor]}];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(handleRightAction:) image:@"timeline_icon_comment" highImage:@"timeline_icon_comment"];
}
- (void)handleClike:(UIButton *)sender {
    //遮挡层
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect newFrame = [sender convertRect:sender.bounds toView:keyWindow];
    CGFloat y = CGRectGetMidY(newFrame);
    CGFloat x = CGRectGetMinX(newFrame);

    UIView * downView = [[UIView alloc]init];
    downView.frame = CGRectMake(0, 0, WIDTH, HIGHT);
    [keyWindow addSubview:downView];
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH , HIGHT )];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.3;
    [keyWindow addSubview:bgView];
    [keyWindow bringSubviewToFront:downView];
    self.downView = downView;
    self.bgView = bgView;
    
    PopButtonView *popview = [[PopButtonView alloc]initWithFrame:CGRectMake(0,  y - 110, WIDTH , 220)];
    popview.backgroundColor = [UIColor clearColor];
    [downView addSubview:popview];
    popview.tag = 1004;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleRemoveView:)];
    [downView addGestureRecognizer:tap];

}
- (void)handleRemoveView:(UITapGestureRecognizer *)sender {
    UIView *boldView = (UIView *)[self.downView viewWithTag:1002];
    if (CGRectContainsPoint(boldView.frame, [sender locationInView:self.downView])) {
        
    }else{
        [self.bgView removeFromSuperview];
        [self.downView removeFromSuperview];
        self.bgView = nil;
        self.downView = nil;
    }
}

- (void)composeMsg {
    ShoppingVC *shopVC = [[ShoppingVC alloc]init];
    [self.navigationController pushViewController:shopVC animated:YES];
}
- (void)handleRightAction:(UIButton *)sender {
    
//    DroprightMenu *menu = [DroprightMenu menu];
//    self.rightView = [[UIView alloc]init];
//    self.rightView.width = 150;
//    self.rightView.height = 100;
//    self.rightView.x = 10;
//    self.rightView.y = 15;
//    [self setUpRightButton];
//    menu.content =  self.rightView;
//    [menu showFrom:sender];
//    menu.rightBlock = ^(UIButton *sender) {
//        StepVC *vc = [[StepVC alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    };

}
- (void)setUpRightButton {
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightView addSubview:btn1];
    btn1.sd_layout.rightSpaceToView(self.rightView,5).topSpaceToView(self.rightView,5).rightSpaceToView(self.rightView,5).heightIs((self.rightView.height-10) / 2);
    
    [btn1 setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateHighlighted];
    [btn1 setTitle:@"发起聊天" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    btn1.tag = 1000;
    
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightView addSubview:btn2];
    btn2.sd_layout.rightSpaceToView(self.rightView,5).topSpaceToView(btn1,0).rightSpaceToView(self.rightView,5).heightIs((self.rightView.height-10) / 2);
    btn2.tag = 1001;
    [btn2 setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateHighlighted];
    [btn2 setTitle:@"私密聊天" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
  
    
}
- (void)handel {
    //查看healthKit在设备上是否可用，iPad上不支持HealthKit
    if (![HKHealthStore isHealthDataAvailable]) {
        SHOW_ALERT22(@"该设备不支持HealthKit");
        return;
    }
    
    //创建healthStore对象
    self.healthStore = [[HKHealthStore alloc]init];
    
    HKObjectType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];    //设置了步数
    
    HKObjectType *type2 = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning]; // 步行+跑步距离
    
    HKObjectType *type3 = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];     // 已爬楼层
    
    HKObjectType *tyep4 = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned]; // 活动能量
    
    HKObjectType *type5 = [HKObjectType activitySummaryType];// 健身记录
    
    
    NSSet *healthSet = [NSSet setWithObjects:stepType,type2,type3,tyep4,type5,nil];
    
    //从健康应用中获取权限
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:healthSet completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            //获取步数后我们调用获取步数的方法
            [self readStepCount];
        }
        else
        {
            SHOW_ALERT22(@"获取步数权限失败");
        }
    }];
}
#pragma mark 读取步数 查询数据
- (void)readStepCount
{
    //查询采样信息
    HKSampleType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    //NSSortDescriptor来告诉healthStore怎么样将结果排序
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *dateCom = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:[NSDate date]];
    
    NSDate *startDate, *endDate;
    endDate = [calendar dateFromComponents:dateCom];
    [dateCom setHour:0];
    [dateCom setMinute:0];
    [dateCom setSecond:0];
    startDate = [calendar dateFromComponents:dateCom];
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    
    
    
    __weak typeof (&*_healthStore)weakHealthStore = _healthStore;
    HKSampleQuery *q1 = [[HKSampleQuery alloc] initWithSampleType:sampleType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        
        double sum = 0;
        
        double sumTime = 0;
        
        NSLog(@"步数结果=%@", results);
        
        for (HKQuantitySample *res in results)
            
        {
            
            
            
            sum += [res.quantity doubleValueForUnit:[HKUnit countUnit]];
            
            
            
            NSTimeZone *zone = [NSTimeZone systemTimeZone];
            
            NSInteger interval = [zone secondsFromGMTForDate:res.endDate];
            
            
            
            NSDate *startDate = [res.startDate dateByAddingTimeInterval:interval];
            
            NSDate *endDate   = [res.endDate dateByAddingTimeInterval:interval];
            
            
            
            sumTime += [endDate timeIntervalSinceDate:startDate];
            int h = sumTime / 3600;
            
            int m = ((long)sumTime % 3600)/60;
            
            NSLog(@"运动时长：%@小时%@分", @(h), @(m));

            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                //查询是在多线程中进行的，如果要对UI进行刷新，要回到主线程中
                self.view1.num =  (int )sum;
                [self.view1 change];
                self.view1.timeLabel.text = [NSString stringWithFormat:@"运动时长：%@小时%@分",@(h),@(m)];

                
            }];
            
        }
        
        
        NSLog(@"运动步数：%@步", @(sum));
        
        if(error) NSLog(@"1error==%@", error);
        [weakHealthStore stopQuery:query];
        NSLog(@"\n\n");
        
    }];
    
    
    
    HKSampleType *timeSampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    HKSampleQuery *q2 = [[HKSampleQuery alloc] initWithSampleType:timeSampleType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        
        double time = 0;
        
        for (HKQuantitySample *res in results)
            
        {
            
            time += [res.quantity doubleValueForUnit:[HKUnit meterUnit]];
            
        }
        
        NSLog(@"运动距离===%@米", @((long)time));
        
        if(error) NSLog(@"2error==%@", error);
        
        [weakHealthStore stopQuery:query];
        
    }];
    
    
    
    HKSampleType *type3 = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    
    HKSampleQuery *q3 = [[HKSampleQuery alloc] initWithSampleType:type3 predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        
        double num = 0;
        
        for (HKQuantitySample *res in results)
            
        {
            
            num += [res.quantity doubleValueForUnit:[HKUnit countUnit]];
            
        }
        
        NSLog(@"楼层===%@层", @(num));
        
        if(error) NSLog(@"3error==%@", error);
        
        [weakHealthStore stopQuery:query];
        
    }];
    
    
    
    HKSampleType *type4 = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    
    HKSampleQuery *q4 = [[HKSampleQuery alloc] initWithSampleType:type4 predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        
        double num = 0;
        
        for (HKQuantitySample *res in results)
            
        {
            
            num += [res.quantity doubleValueForUnit:[HKUnit kilocalorieUnit]];
            
        }
        
        NSLog(@"卡路里===%@大卡", @((long)num));
        
        if(error) NSLog(@"4error==%@", error);
        
        [weakHealthStore stopQuery:query];
        
        NSLog(@"\n\n");
        
    }];
    
    
    
    NSDateComponents *dateCom5B = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    
    [dateCom5B setDay:(dateCom5B.day - 10)];
    
    dateCom5B.calendar = calendar;
    
    NSDateComponents *dateCom5E = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    
    dateCom5E.calendar = calendar;
    
    NSPredicate *predicate5 = [HKActivitySummaryQuery predicateForActivitySummaryWithDateComponents:dateCom5B];
    
    //    NSPredicate *predicate5 = [HKActivitySummaryQuery predicateForActivitySummariesBetweenStartDateComponents:dateCom5B endDateComponents:dateCom5E];
    
    HKActivitySummaryQuery *q5 = [[HKActivitySummaryQuery alloc] initWithPredicate:predicate5 resultsHandler:^(HKActivitySummaryQuery * _Nonnull query, NSArray<HKActivitySummary *> * _Nullable activitySummaries, NSError * _Nullable error) {
        
        double energyNum       = 0;
        
        double exerciseNum     = 0;
        
        double standNum        = 0;
        
        double energyGoalNum   = 0;
        
        double exerciseGoalNum = 0;
        
        double standGoalNum    = 0;
        
        for (HKActivitySummary *summary in activitySummaries)
            
        {
            
            energyNum       += [summary.activeEnergyBurned doubleValueForUnit:[HKUnit kilocalorieUnit]];
            
            exerciseNum     += [summary.appleExerciseTime doubleValueForUnit:[HKUnit secondUnit]];
            
            standNum        += [summary.appleStandHours doubleValueForUnit:[HKUnit countUnit]];
            
            energyGoalNum   += [summary.activeEnergyBurnedGoal doubleValueForUnit:[HKUnit kilocalorieUnit]];
            
            exerciseGoalNum += [summary.appleExerciseTimeGoal doubleValueForUnit:[HKUnit secondUnit]];
            
            standGoalNum    += [summary.appleStandHoursGoal doubleValueForUnit:[HKUnit countUnit]];
            
        }
        
        NSLog(@"\n\n");
        
        NSLog(@"健身记录：energyNum=%@",       @(energyNum));
        
        NSLog(@"健身记录：exerciseNum=%@",     @(exerciseNum));
        
        NSLog(@"健身记录：standNum=%@",        @(standNum));
        
        NSLog(@"健身记录：energyGoalNum=%@",   @(energyGoalNum));
        
        NSLog(@"健身记录：exerciseGoalNum=%@", @(exerciseGoalNum));
        
        NSLog(@"健身记录：standGoalNum=%@",    @(standGoalNum));
        
        if(error) NSLog(@"5error==%@", error);
        
        [weakHealthStore stopQuery:query];
        
        NSLog(@"\n\n");
        
    }];
    
    
    
    //执行查询
    
    [_healthStore executeQuery:q1];
    
    [_healthStore executeQuery:q2];
    
    [_healthStore executeQuery:q3];
    
    [_healthStore executeQuery:q4];
    
    [_healthStore executeQuery:q5];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
