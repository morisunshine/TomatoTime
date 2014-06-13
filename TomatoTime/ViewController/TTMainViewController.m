//
//  TTStartViewController.m
//  TomatoTime
//
//  Created by Sheldon on 14-5-21.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "TTMainViewController.h"
#import "TTStartMainView.h"
#import "TTTomatoView.h"

@interface TTMainViewController ()

@property (nonatomic, retain) TTStartMainView *startMainView;
@property (nonatomic, retain) TTTomatoView *tomatoView;
@property (nonatomic, retain) TTTomatoView *resetView;

@end

@implementation TTMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.startMainView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getters -

- (TTStartMainView *)startMainView
{
    __weak TTMainViewController *weakSelf = self;
    __weak TTStartMainView *weakStartMainView = _startMainView;
    if (!_startMainView) {
        _startMainView = [[TTStartMainView alloc] initWithFrame:self.view.bounds];
        _startMainView.handler = ^() {
            NSLog(@"Start!");
            [weakSelf.view addSubview:weakSelf.tomatoView];
            [weakStartMainView removeFromSuperview];
        };
    }
    
    return _startMainView;
}

- (TTTomatoView *)tomatoView
{
    if (!_tomatoView) {
        _tomatoView = [[TTTomatoView alloc] initWithFrame:self.view.bounds maxMinute:2];
        
        __weak TTTomatoView *weakTomatoView = _tomatoView;
        __weak TTMainViewController *weakSelf = self;
        
        _tomatoView.endHandler = ^() {
            NSLog(@"可以休息了！");
            weakTomatoView.titleString = @"点击开始休息";
        };
        _tomatoView.endTapHandler = ^() {
            [weakTomatoView removeFromSuperview];
            [weakSelf.view addSubview:weakSelf.resetView];
        };
    }
    
    return _tomatoView;
}

- (TTTomatoView *)resetView
{
    if (!_resetView) {
        _resetView = [[TTTomatoView alloc] initWithFrame:self.view.bounds maxMinute:2];
        _resetView.circleColor = [UIColor colorWithHue:0.22 saturation:0.52 brightness:0.82 alpha:1];
        
        __weak TTTomatoView *weakRestView = _resetView;
        __weak TTMainViewController *weakSelf = self;
        
        _resetView.endHandler = ^() {
            weakRestView.titleString = @"完成";
        };
        
        _resetView.endTapHandler = ^() {
            NSLog(@"完成后的操作");
            [weakRestView removeFromSuperview];
            [weakSelf.view addSubview:weakSelf.startMainView];
        };
    }
    
    return _resetView;
}

@end
