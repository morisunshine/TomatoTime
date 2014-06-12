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
        _tomatoView = [[TTTomatoView alloc] initWithFrame:self.view.bounds];
    }
    
    return _tomatoView;
}

@end
