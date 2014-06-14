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
#import "TTInfoViewController.h"

@interface TTMainViewController ()

@property (nonatomic, retain) TTStartMainView *startMainView;
@property (nonatomic, retain) TTTomatoView *tomatoView;
@property (nonatomic, retain) TTTomatoView *resetView;
@property (nonatomic, retain) UIButton *infoBtn;

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
    [self.view addSubview:self.infoBtn];
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
    __weak __block TTStartMainView *weakStartMainView = _startMainView;
    if (!_startMainView) {
        _startMainView = [[TTStartMainView alloc] initWithFrame:self.view.bounds];
        _startMainView.handler = ^() {
            NSLog(@"Start!");
            weakSelf.infoBtn.hidden = NO;
            [weakSelf.view insertSubview:weakSelf.tomatoView belowSubview:weakSelf.infoBtn];
            [weakStartMainView removeFromSuperview];
            weakStartMainView = nil;
        };
    }
    
    return _startMainView;
}

- (TTTomatoView *)tomatoView
{
    if (!_tomatoView) {
        _tomatoView = [[TTTomatoView alloc] initWithFrame:self.view.bounds maxMinute:2];
        
        
        __block TTTomatoView *weakTomatoView = _tomatoView;
        __weak TTMainViewController *weakSelf = self;
        
        _tomatoView.endHandler = ^() {
            NSLog(@"可以休息了！");
            weakTomatoView.titleString = @"点击开始休息";
        };
        _tomatoView.endTapHandler = ^() {
            [weakTomatoView removeFromSuperview];
            weakTomatoView = nil;
            [weakSelf.view insertSubview:weakSelf.resetView belowSubview:weakSelf.infoBtn];
        };
    }
    
    return _tomatoView;
}

- (TTTomatoView *)resetView
{
    if (!_resetView) {
        _resetView = [[TTTomatoView alloc] initWithFrame:self.view.bounds maxMinute:2];
        _resetView.circleColor = [UIColor colorWithHue:0.22 saturation:0.52 brightness:0.82 alpha:1];
        
        __block TTTomatoView *weakRestView = _resetView;
        __weak TTMainViewController *weakSelf = self;
        
        _resetView.endHandler = ^() {
            weakRestView.titleString = @"完成";
        };
        
        _resetView.endTapHandler = ^() {
            NSLog(@"完成后的操作");
            [weakRestView removeFromSuperview];
            weakRestView = nil;
            weakSelf.infoBtn.hidden = YES;
            [weakSelf.view insertSubview:weakSelf.startMainView belowSubview:weakSelf.infoBtn];
        };
    }
    
    return _resetView;
}

- (UIButton *)infoBtn
{
    if (!_infoBtn) {
        _infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_infoBtn setImage:[UIImage imageNamed:@"btn_info"] forState:UIControlStateNormal];
        _infoBtn.hidden = YES;
        _infoBtn.frame = CGRectMake(15, 0, 22, 22);
        _infoBtn.bottom = APP_SCREEN_HEIGHT - 15;
        _infoBtn.layer.cornerRadius = 11;
        [_infoBtn addTarget:self action:@selector(infoBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _infoBtn;
}

#pragma mark - Actions -

- (IBAction)infoBtnTapped:(UIButton *)sender
{
    TTInfoViewController *infoViewController = [[TTInfoViewController alloc] init];
    [self addChildViewController:infoViewController];
    [self.view addSubview:infoViewController.view];
}

@end
