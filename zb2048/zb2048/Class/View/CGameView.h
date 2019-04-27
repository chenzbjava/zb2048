//
//  CGameView.h
//  zb2048
//
//  Created by QITMAC000578 on 2019/4/27.
//  Copyright © 2019 QITMAC000578. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TableWidth      4
#define TableHeight     4

#define SliderViewWidth      70
#define SliderViewmargin     5

@interface CGameView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (void)startGame;

@end

