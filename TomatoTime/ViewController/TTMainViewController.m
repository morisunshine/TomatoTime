//
//  TTStartViewController.m
//  TomatoTime
//
//  Created by Sheldon on 14-5-21.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "TTMainViewController.h"
#import "TTStartMainView.h"

@interface TTMainViewController ()

@property (nonatomic, retain) TTStartMainView *startMainView;

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
    if (!_startMainView) {
        _startMainView = [[TTStartMainView alloc] initWithFrame:self.view.bounds];
        _startMainView.handler = ^() {
            NSLog(@"Start!");
        };
    }
    
    return _startMainView;
}

@end
