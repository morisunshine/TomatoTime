//
//  TTInfoViewController.m
//  TomatoTime
//
//  Created by Sheldon on 14-6-13.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "TTInfoViewController.h"

@interface TTInfoViewController ()

@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIButton *feedBackBtn;
@property (weak, nonatomic) IBOutlet UIButton *rateBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *alphaBackgroundView;

@end

@implementation TTInfoViewController

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
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self setupView];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alphaBackgroundView.alpha = 0.5;
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alphaBackgroundView.alpha = 0;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods -

- (void)setupView
{
    self.alertView.layer.cornerRadius = 6.0;
    self.alertView.layer.masksToBounds = YES;
    self.feedBackBtn.layer.cornerRadius = 6.0;
    self.rateBtn.layer.cornerRadius = 6.0;
    
    CGRect alertRect = self.alertView.frame;
    
    CALayer *layer = [CALayer layer];
    layer.borderColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.89 alpha:1].CGColor;
    layer.borderWidth = 2;
    layer.frame = CGRectMake(-1, 310, CGRectGetWidth(alertRect) + 2, 2);
    
    [self.alertView.layer addSublayer:layer];
}

#pragma mark - Actions 

- (IBAction)cancelBtnTapped:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }
    }];
}

@end
