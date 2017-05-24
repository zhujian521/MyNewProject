//
//  ShopViewController.m
//  demo
//
//  Created by 北京启智 on 2016/11/21.
//  Copyright © 2016年 北京启智. All rights reserved.
//

#import "ShopViewController.h"
#import "SearchBar.h"
#import "VideoModel.h"
#import "VideoTableViewCell.h"
#import "ZFPlayer.h"
#import "ZFPlayerControlView.h"
@interface ShopViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)SearchBar *tempSearchBar;
@property (nonatomic ,strong)NSMutableArray *dataSource;
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic, strong) ZFPlayerView        *playerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;

@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    SearchBar *searchBar = [SearchBar searchBar];
//    searchBar.delegate = self;
//    searchBar.width = WIDTH - 100;
//    searchBar.height = 30;
//    self.navigationItem.titleView = searchBar;
//    self.tempSearchBar = searchBar;
    [self.view addSubview:self.tableView];
    [self requestDate];
}
// 页面消失时候
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.playerView resetPlayer];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.tableView registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"cell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
    }
    return _tableView;
}
- (void)requestDate {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"videoData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *videoList = [rootDict objectForKey:@"videoList"];
    for (NSDictionary *dataDic in videoList) {
        VideoModel *model = [VideoModel mj_objectWithKeyValues:dataDic];
        NSLog(@"%@",model.title);
        [self.dataSource addObject:model];
    }

    
}
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    VideoModel *model = _dataSource[indexPath.row];
    cell.model = model;
    cell.playBtn.tag = indexPath.row;
    [cell.playBtn addTarget:self action:@selector(handlePlay:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}
- (void)handlePlay:(UIButton *)sender {
   VideoTableViewCell *cell = (VideoTableViewCell *)[[[[sender superview] superview] superview] superview];
   NSIndexPath *dexPath = [self.tableView indexPathForCell:cell];
    VideoModel *model = _dataSource[dexPath.row];
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
    playerModel.title            = model.title;
    playerModel.videoURL         = [NSURL URLWithString:model.playUrl];
    playerModel.placeholderImageURLString = model.coverForFeed;
    playerModel.scrollView       = self.tableView;
    playerModel.indexPath        = dexPath;
//    // 赋值分辨率字典
//    playerModel.resolutionDic    = dic;
//    // player的父视图tag
    playerModel.fatherViewTag    = cell.picView.tag;
    
    // 设置播放控制层和model
    [self.playerView playerControlView:nil playerModel:playerModel];
    // 下载功能
    self.playerView.hasDownload = NO;
    // 自动播放
    [self.playerView autoPlayTheVideo];

}
- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
//        _playerView.delegate = self;
        // 当cell播放视频由全屏变为小屏时候，不回到中间位置
        _playerView.cellPlayerOnCenter = NO;
        
        // 当cell划出屏幕的时候停止播放
        _playerView.stopPlayWhileCellNotVisable = YES;
        //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
        // _playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
        // 静音
        // _playerView.mute = YES;
    }
    return _playerView;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [[ZFPlayerControlView alloc] init];
    }
    return _controlView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.tempSearchBar resignFirstResponder];
}
@end
