//
//  StepVC.m
//  demo
//
//  Created by wertyu on 17/5/23.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import "StepVC.h"
#import <HealthKit/HealthKit.h>
@interface StepVC ()
@property (nonatomic, strong)  UILabel *stepCountUnitLabel;
@property (nonatomic, strong)  UILabel *stepCountValueLabel;
@property (nonatomic, strong)HKHealthStore *healthStore;
@end

@implementation StepVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"计步器";
    self.stepCountUnitLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 60, 25)];
    [self.view addSubview:self.stepCountUnitLabel];
    
    self.stepCountValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 60, 25)];
    [self.view addSubview:self.stepCountValueLabel];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 200, 60, 30)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(handel) forControlEvents:UIControlEventTouchUpInside];

    
}
- (void)handel {
    //查看healthKit在设备上是否可用，iPad上不支持HealthKit
    if (![HKHealthStore isHealthDataAvailable]) {
        self.stepCountUnitLabel.text = @"该设备不支持HealthKit";
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
            self.stepCountUnitLabel.text = @"获取步数权限失败";
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
//    //获取当前时间
//    NSDate *now = [NSDate date];
//    NSCalendar *calender = [NSCalendar currentCalendar];
//    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    NSDateComponents *dateComponent = [calender components:unitFlags fromDate:now];
//    int hour = (int)[dateComponent hour];
//    int minute = (int)[dateComponent minute];
//    int second = (int)[dateComponent second];
//    NSDate *nowDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second) ];
//    //时间结果与想象中不同是因为它显示的是0区
//    NSLog(@"今天%@",nowDay);
//    NSDate *nextDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second)  + 86400];
//    NSLog(@"明天%@",nextDay);
//    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nowDay endDate:nextDay options:(HKQueryOptionNone)];
//    
//    /*查询的基类是HKQuery，这是一个抽象类，能够实现每一种查询目标，这里我们需要查询的步数是一个HKSample类所以对应的查询类是HKSampleQuery。下面的limit参数传1表示查询最近一条数据，查询多条数据只要设置limit的参数值就可以了*/
//    
//    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc]initWithSampleType:sampleType predicate:predicate limit:0 sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
//        //设置一个int型变量来作为步数统计
//        int allStepCount = 0;
//        for (int i = 0; i < results.count; i ++) {
//            //把结果转换为字符串类型
//            HKQuantitySample *result = results[i];
//            HKQuantity *quantity = result.quantity;
//            NSMutableString *stepCount = (NSMutableString *)quantity;
//            NSString *stepStr =[ NSString stringWithFormat:@"%@",stepCount];
//            //获取51 count此类字符串前面的数字
//            NSString *str = [stepStr componentsSeparatedByString:@" "][0];
//            int stepNum = [str intValue];
//            NSLog(@"%d",stepNum);
//            //把一天中所有时间段中的步数加到一起
//            allStepCount = allStepCount + stepNum;
//        }
//        
//        //查询要放在多线程中进行，如果要对UI进行刷新，要回到主线程
//        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//            self.stepCountUnitLabel.text = [NSString stringWithFormat:@"%d",allStepCount];
//        }];
//    }];
//    //执行查询
//    [self.healthStore executeQuery:sampleQuery];
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
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                //查询是在多线程中进行的，如果要对UI进行刷新，要回到主线程中
                
                self.title = [NSString stringWithFormat:@"运动步数：%@", @(sum).stringValue];
                
            }];
            
        }
        
        int h = sumTime / 3600;
        
        int m = ((long)sumTime % 3600)/60;
        
        NSLog(@"运动时长：%@小时%@分", @(h), @(m));
        
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
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
