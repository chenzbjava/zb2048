//
//  CSliderView.m
//  zb2048
//
//  Created by QITMAC000578 on 2019/4/27.
//  Copyright © 2019 QITMAC000578. All rights reserved.
//

#import "CSliderView.h"

#import "CGameView.h"

@implementation CSliderView

-(instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SliderViewWidth, SliderViewWidth);
        
        self.showLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.showLabel.textAlignment = NSTextAlignmentCenter;
        self.showLabel.font = [UIFont boldSystemFontOfSize:24];
        self.showLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.showLabel];
    }
    return self;
}

-(void)setNumber:(int)number {
    _number = number;
    _tempNumber = number;
    if (self.showLabel) {
        self.showLabel.text =  _number != 0 ? [NSString stringWithFormat:@"%i",_number] : @"";
    }
    self.showLabel.textColor = [UIColor whiteColor];
    if (_number == 2) {
        self.backgroundColor = CRGBHex(0xeee4db);
        self.showLabel.textColor = [UIColor blackColor];
    }else if (_number == 4) {
        self.backgroundColor = CRGBHex(0xede1c9);
        self.showLabel.textColor = [UIColor blackColor];
    }else if (_number == 8) {
        self.backgroundColor = CRGBHex(0xefb286);
    }else if (_number == 16) {
        self.backgroundColor = CRGBHex(0xed9670);
    }else if (_number == 32) {
        self.backgroundColor = CRGBHex(0xec7e6b);
    }else if (_number == 64) {
        self.backgroundColor = CRGBHex(0xe86350);
    }else if (_number == 128) {
        self.backgroundColor = CRGBHex(0xec7e6b);
    }else if (_number == 256) {
        self.backgroundColor = CRGBHex(0xec7e6b);
    }else if (_number == 512) {
        self.backgroundColor = CRGBHex(0xec7e6b);
    }else if (_number == 1024) {
        self.backgroundColor = CRGBHex(0xec7e6b);
    }else if (_number == 2048) {
        self.backgroundColor = CRGBHex(0xec7e6b);
    }else {
        self.backgroundColor = [UIColor clearColor];
    }
}


- (void)toAnimation {
    CGRect frame = self.frame;
    frame.origin.y = _pointX * (SliderViewWidth + SliderViewmargin) + SliderViewmargin;
    frame.origin.x = _pointY * (SliderViewWidth + SliderViewmargin) + SliderViewmargin;
    self.frame = frame;
    self.mIndex = _pointX * TableWidth + _pointY;
    self.number = _tempNumber;
    self.mHaveMove = NO;
}
@end
