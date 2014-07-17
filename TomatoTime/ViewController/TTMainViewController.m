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
#import "TTCircleView.h"
#import "TTInfoViewController.h"

static NSString *kFinishCount = @"finishCount";
static NSString *kLastDay = @"lastDay";
static NSString *kLastMonth = @"lastMonth";

@interface TTMainViewController ()

@property (nonatomic, retain) TTStartMainView *startMainView;
@property (nonatomic, retain) TTTomatoView *tomatoView;
@property (nonatomic, retain) TTTomatoView *resetView;
@property (nonatomic, retain) UIButton *infoBtn;
@property (nonatomic, retain) UIButton *countBtn;
@property (nonatomic, assign) NSInteger finishCount;

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
    [self.view addSubview:self.countBtn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getters -

- (NSInteger)finishCount
{
    NSCalendar *gregorianCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSDateComponents *dateComps = [gregorianCal components:(NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    
    NSInteger lastFinishDay = [[USER_DEFAULTS objectForKey:kLastDay] integerValue];
    NSInteger lastFinishMonth = [[USER_DEFAULTS objectForKey:kLastMonth] integerValue];
    
    NSInteger finishCount = 0;
    
    if (lastFinishMonth == 0 && lastFinishDay == 0) {
        [USER_DEFAULTS setObject:@(0) forKey:kFinishCount];
    } else {
        if (lastFinishDay < dateComps.day && lastFinishMonth < dateComps.month) {
            [USER_DEFAULTS setObject:@(0) forKey:kFinishCount];
        } else {
            [[USER_DEFAULTS objectForKey:kFinishCount] integerValue];
        }
    }
    
    return finishCount;
}

- (TTStartMainView *)startMainView
{
    __weak TTMainViewController *weakSelf = self;
    __weak __block TTStartMainView *weakStartMainView = _startMainView;
    if (!_startMainView) {
        _startMainView = [[TTStartMainView alloc] initWithFrame:self.view.bounds];
        _startMainView.handler = ^() {
            NSLog(@"Start!");
            [weakSelf.view insertSubview:weakSelf.tomatoView belowSubview:weakSelf.infoBtn];
            [weakStartMainView removeFromSuperview];
            _startMainView = nil;
        };
    }
    
    return _startMainView;
}

- (TTTomatoView *)tomatoView
{
    if (!_tomatoView) {
        _tomatoView = [[TTTomatoView alloc] initWithFrame:self.view.bounds maxMinute:kTomatoMinute];
        _tomatoView.circleColor = [UIColor colorWithRed:0.87 green:0.31 blue:0.23 alpha:1];
        
        __block TTTomatoView *weakTomatoView = _tomatoView;
        __weak TTMainViewController *weakSelf = self;
        
        _tomatoView.giveUpHandler = ^() {
            [weakSelf giveUpTomato];
        };
        
        _tomatoView.endHandler = ^() {
            NSLog(@"可以休息了！");
            weakTomatoView.titleString = @"点击开始休息";
        };
        _tomatoView.endTapHandler = ^() {
            [weakTomatoView removeFromSuperview];
            _tomatoView = nil;
            [weakSelf.view insertSubview:weakSelf.resetView belowSubview:weakSelf.infoBtn];
        };
    }
    
    return _tomatoView;
}

- (TTTomatoView *)resetView
{
    if (!_resetView) {
        _resetView = [[TTTomatoView alloc] initWithFrame:self.view.bounds maxMinute:kRestMinute];
        _resetView.circleColor = [UIColor colorWithHue:0.22 saturation:0.52 brightness:0.82 alpha:1];
        
        __block TTTomatoView *weakRestView = _resetView;
        __weak TTMainViewController *weakSelf = self;
        
        
        _resetView.giveUpHandler = ^() {
            [weakSelf giveUpTomato];
        };
        
        _resetView.endHandler = ^() {
            weakRestView.titleString = @"完成";
        };
        
        _resetView.endTapHandler = ^() {
            
            CGRect toRect = weakSelf.countBtn.frame;
            CGRect fromRect = weakRestView.circleView.frame;
            
            POPSpringAnimation *zoomOutAnimation = [POPSpringAnimation animation];
            zoomOutAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
            zoomOutAnimation.fromValue = [NSValue valueWithCGRect:fromRect];
            zoomOutAnimation.toValue = [NSValue valueWithCGRect:toRect];
            zoomOutAnimation.springBounciness = 10.0;
            zoomOutAnimation.springSpeed = 10.0;
            zoomOutAnimation.completionBlock = ^(POPAnimation *animation, BOOL finish) {
                if (finish) {
                    NSLog(@"完成后的操作");
                    [weakRestView removeFromSuperview];
                    _resetView = nil;
                    [weakSelf.view insertSubview:weakSelf.startMainView belowSubview:weakSelf.infoBtn];
                    
                    self.finishCount ++;
                    NSString *finishCount = [NSString stringWithFormat:@"%ld", self.finishCount];
                    [_countBtn setTitle:finishCount forState:UIControlStateNormal];
                }
            };
            
            [weakSelf.resetView.circleView pop_addAnimation:zoomOutAnimation forKey:@"ZoomOut"];
        };
    }
    
    return _resetView;
}

- (UIButton *)infoBtn
{
    if (!_infoBtn) {
        _infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_infoBtn setImage:[UIImage imageNamed:@"btn_info"] forState:UIControlStateNormal];
        _infoBtn.frame = CGRectMake(15, 0, 32, 32);
        _infoBtn.bottom = APP_SCREEN_HEIGHT - 15;
        [_infoBtn addTarget:self action:@selector(infoBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _infoBtn;
}


- (UIButton *)countBtn
{
    if (!_countBtn) {
        _countBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _countBtn.layer.cornerRadius = 11;
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _countBtn.backgroundColor = [UIColor colorWithRed:0.87 green:0.31 blue:0.23 alpha:1];
        _countBtn.frame = CGRectMake(15, 0, 22, 22);
        _countBtn.bottom = APP_SCREEN_HEIGHT - 20;
        _countBtn.right = APP_SCREEN_WIDTH - 15;
        NSString *finishCount = [NSString stringWithFormat:@"%ld", self.finishCount];
        [_countBtn setTitle:finishCount forState:UIControlStateNormal];
    }
    
    return _countBtn;
}

#pragma mark - Setters -

- (void)setFinishCount:(NSInteger)finishCount
{
    NSCalendar *gregorianCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *dateComps = [gregorianCal components:(NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    
    [USER_DEFAULTS setObject:@(dateComps.day) forKey:kLastDay];
    [USER_DEFAULTS setObject:@(dateComps.month) forKey:kLastMonth];
    
    [[NSUserDefaults standardUserDefaults] setObject:@(finishCount) forKey:kFinishCount];
}

#pragma mark - Actions -

- (IBAction)infoBtnTapped:(UIButton *)sender
{
    TTInfoViewController *infoViewController = [[TTInfoViewController alloc] init];
    [self addChildViewController:infoViewController];
    [self.view addSubview:infoViewController.view];
}

#pragma mark - Privat Methods -

- (void)giveUpTomato
{
    if (self.tomatoView) {
        [self.tomatoView removeFromSuperview];
        self.tomatoView = nil;
    }
    
    if (self.resetView) {
        [self.resetView removeFromSuperview];
        self.resetView = nil;
    }
    
    [self.view insertSubview:self.startMainView belowSubview:self.infoBtn];
    self.infoBtn.hidden = YES;
    self.countBtn.hidden = YES;
}

@end
