//
//  ViewController.m
//  zb2048
//
//  Created by QITMAC000578 on 2019/4/27.
//  Copyright © 2019 QITMAC000578. All rights reserved.
//

#import "ViewController.h"

#import "CGameView.h"

@interface ViewController ()


@property(nonatomic,strong)CGameView        *mGameView;//游戏区域

@property(nonatomic,strong)UIButton         *startGameBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mGameView = [[CGameView alloc] initWithFrame:CGRectMake((__ScreenWidth - 4*SliderViewWidth - SliderViewmargin *5)/2, (__ScreenHeight - 4*SliderViewWidth -SliderViewmargin *5)/2, 4*SliderViewWidth + SliderViewmargin *5, 4*SliderViewWidth + SliderViewmargin *5)];
    self.mGameView.userInteractionEnabled = NO;
    self.view.backgroundColor = CRGBHex(0xffffff);
    [self.view addSubview:self.mGameView];
    
    self.startGameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startGameBtn.frame = CGRectMake((__ScreenWidth - 150)/2, __ScreenHeight - 100, 150, 60);
    self.startGameBtn.layer.cornerRadius = 4;
    self.startGameBtn.layer.masksToBounds = YES;
    [self.startGameBtn setTitle:@"开始游戏" forState:(UIControlStateNormal)];
    [self.startGameBtn addTarget:self action:@selector(startGame) forControlEvents:(UIControlEventTouchUpInside)];
    [self.startGameBtn setBackgroundColor:CRGBHex(0x0ebc01)];
    [self.view addSubview:self.startGameBtn];
    
}


- (void)startGame {
    self.mGameView.userInteractionEnabled = YES;
    [self.mGameView startGame];
}


@end
