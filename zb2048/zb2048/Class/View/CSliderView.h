//
//  CSliderView.h
//  zb2048
//
//  Created by QITMAC000578 on 2019/4/27.
//  Copyright © 2019 QITMAC000578. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CSliderView : UIView

@property(nonatomic,assign)int          mIndex;

@property(nonatomic,assign)int          pointX;
@property(nonatomic,assign)int          pointY;

@property(nonatomic,assign)int          number;
@property(nonatomic,assign)int          tempNumber;/* 临时数据*/

@property(nonatomic,strong)UILabel      *showLabel;


- (void)toAnimation;

@end
