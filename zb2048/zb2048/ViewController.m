//
//  ViewController.m
//  zb2048
//
//  Created by QITMAC000578 on 2019/4/27.
//  Copyright © 2019 QITMAC000578. All rights reserved.
//

#import "ViewController.h"

#import "CGameView.h"

@interface ViewController ()<CGameViewDelegate>


@property(nonatomic,strong)UILabel          *mScoreLabel;//得分

@property(nonatomic,strong)CGameView        *mGameView;//游戏区域

@property(nonatomic,strong)UIButton         *startGameBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    self.mGameView = [[CGameView alloc] initWithFrame:CGRectMake((__ScreenWidth - 4*SliderViewWidth - SliderViewmargin *5)/2, (__ScreenHeight - 4*SliderViewWidth -SliderViewmargin *5)/2, 4*SliderViewWidth + SliderViewmargin *5, 4*SliderViewWidth + SliderViewmargin *5)];
    self.view.backgroundColor = CRGBHex(0xffffff);
    self.mGameView.mDelegate = self;
    [self.view addSubview:self.mGameView];
    
    self.mScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.mGameView.frame.origin.x, self.mGameView.frame.origin.y - 60, 180, 30)];
    self.mScoreLabel.backgroundColor = [UIColor grayColor];
    self.mScoreLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:self.mScoreLabel];
    
    self.startGameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startGameBtn.frame = CGRectMake((__ScreenWidth - 150)/2, __ScreenHeight - 100, 150, 60);
    self.startGameBtn.layer.cornerRadius = 4;
    self.startGameBtn.layer.masksToBounds = YES;
    [self.startGameBtn setTitle:@"重新开始" forState:(UIControlStateNormal)];
    [self.startGameBtn addTarget:self action:@selector(startGame) forControlEvents:(UIControlEventTouchUpInside)];
    [self.startGameBtn setBackgroundColor:CRGBHex(0x0ebc01)];
    [self.view addSubview:self.startGameBtn];
    
    
    [self.mGameView startGame];
}


- (void)startGame {
    [self.mGameView overAgain];
}


-(void)ToCalculateScoer:(NSInteger)score_ {
    self.mScoreLabel.text = [NSString stringWithFormat:@"  score: %li",score_];
}

@end
