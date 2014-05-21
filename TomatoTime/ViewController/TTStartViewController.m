//
//  TTStartViewController.m
//  TomatoTime
//
//  Created by Sheldon on 14-5-21.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "TTStartViewController.h"
#import "TTProgressView.h"
#import "TTCircleView.h"
#import "TTTomatoViewController.h"

@interface TTStartViewController ()

@property (nonatomic, retain) TTCircleView *circleView;
@property (nonatomic, retain) UILabel *textLabel;

@end

@implementation TTStartViewController

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
    
    [self.view addSubview:self.circleView];
    [self.view addSubview:self.textLabel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getters -

- (TTCircleView *)circleView
{
    if (!_circleView) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startToTomato:)];
        _circleView = [[TTCircleView alloc] initWithFrame:CGRectMake(0, 100, 150, 150)];
        _circleView.center = CGPointMake(self.view.center.x, _circleView.center.y);
        _circleView.circleColor = [UIColor colorWithRed:0.87 green:0.32 blue:0.24 alpha:1];
        _circleView.titleString = @"开始";
        _circleView.userInteractionEnabled = YES;
        [_circleView addGestureRecognizer:tapGestureRecognizer];
    }
    
    return _circleView;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, 189, 150)];
        _textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _textLabel.numberOfLines = 0;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.center = CGPointMake(self.view.center.x, _textLabel.center.y);
        _textLabel.textColor = [UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1];
        _textLabel.font = [UIFont boldSystemFontOfSize:16];
        _textLabel.text = @"YESTERDAY,\n YOU SAID TOMORROW";
    }
    
    return _textLabel;
}

#pragma mark - Actions -

- (IBAction)startToTomato:(UITapGestureRecognizer *)sender
{
    CATransition *transition=[CATransition animation];
    transition.timingFunction = UIViewAnimationTransitionNone;
    transition.duration=0.4;
    transition.type=kCATransitionFade;
    transition.subtype=kCATransitionFade;
    
    TTTomatoViewController *startViewController = [[TTTomatoViewController alloc] init];
    [startViewController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController pushViewController:startViewController animated:NO];
}

@end
