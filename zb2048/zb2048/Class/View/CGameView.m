//
//  CGameView.m
//  zb2048
//
//  Created by QITMAC000578 on 2019/4/27.
//  Copyright © 2019 QITMAC000578. All rights reserved.
//

#import "CGameView.h"

#import "CSliderView.h"

#define defaultNumber @[@(2),@(4)]

typedef enum : NSUInteger {
    DirectionZero = 0,
    DirectionLeft,
    DirectionRight,
    DirectionUp,
    DirectionDown
}MoveDirection;

@interface CGameView()

@property(nonatomic,assign)MoveDirection                        mMoveDir;
@property(nonatomic,strong)NSMutableArray<NSMutableArray *>     *mSourceArray;


@end

@implementation CGameView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    self.mSourceArray = [NSMutableArray new];
    
    self.backgroundColor = CRGBHex(0xccc0b2);
    
    for (int i = 0; i < 5; i++) {
        UIView *rowLine = [[UIView alloc] initWithFrame:CGRectMake(0, i*(SliderViewWidth+SliderViewmargin), self.frame.size.width, SliderViewmargin)];
        rowLine.backgroundColor = CRGBHex(0xbcada0);
        [self addSubview:rowLine];
        
        UIView *colLine = [[UIView alloc] initWithFrame:CGRectMake(i*(SliderViewWidth+SliderViewmargin), 0, SliderViewmargin,self.frame.size.width)];
        colLine.backgroundColor = CRGBHex(0xbcada0);
        [self addSubview:colLine];
    }
    
    
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [leftRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self addGestureRecognizer:leftRecognizer];
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [rightRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self addGestureRecognizer:rightRecognizer];
    
    UISwipeGestureRecognizer *upRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [upRecognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self addGestureRecognizer:upRecognizer];
    
    UISwipeGestureRecognizer *downRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [downRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self addGestureRecognizer:downRecognizer];
    
    for (int i = 0; i < 4; i++) {
        NSMutableArray *rowArray = [[NSMutableArray alloc] init];
        for (int j = 0; j < 4; j++) {
            CSliderView *sView = [[CSliderView alloc] init];
            sView.frame = CGRectMake(j*(SliderViewWidth + SliderViewmargin) + SliderViewmargin, i*(SliderViewWidth + SliderViewmargin) + SliderViewmargin, SliderViewWidth, SliderViewWidth);
            sView.pointX = i;
            sView.pointY = j;
            sView.mIndex = i * TableWidth + j;
            
            [self addSubview:sView];
            [rowArray addObject:sView];
        }
        [self.mSourceArray addObject:rowArray];
    }
}


- (void)startGame {
    
//    CSliderView *view1 = self.mSourceArray[0][1];
//    view1.number = 2;
//    CSliderView *view2 = self.mSourceArray[1][1];
//    view2.number = 2;
//    CSliderView *view3 = self.mSourceArray[2][1];
//    view3.number = 2;
    
    for (int i = 0;  i < 4; i ++) {
        int x = [self getRandomNumber:0 to:3];
        int y = [self getRandomNumber:0 to:3];

        CSliderView *view = self.mSourceArray[x][y];
        if (view.number == 0) {
            view.number = [defaultNumber[[self getRandomNumber:0 to:1]] intValue];
        }else {
            i--;
        }
    }
}


/**
 获取一个随机整数，范围在[from,to），包括from，包括to
 */
- (int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}


- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    MoveDirection dir = DirectionZero;
    
    if(recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"swipe down");
        dir = DirectionDown;
        [self dowm];
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"swipe up");
        dir = DirectionUp;
        [self up];
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"swipe left");
        dir = DirectionLeft;
        [self left];
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"swipe right");
        dir = DirectionRight;
        [self right];
    }
    /* 动画操作 */
    [self toMoveSliderView:dir];
}



- (void)up {
    for (int y = 0; y< TableWidth; y++) {
        for (int x = 1; x < TableHeight; x++) {
            /* 内层循环为从下往上，单列循环 */
            CSliderView *cell = self.mSourceArray[x][y];
            /* 从x的位置开始，往下循环遍历 */
            if (cell.number > 0) {
                for (int m = x ; m >= 0 ; m--){
                    int nextIndex = m - 1;
                    if (nextIndex < 0) { break; }
                    [self columnMoveSortCurX:m nextX:nextIndex withCurY:y];
                }
            }
        }
    }
}

- (void)dowm {
    /* 位置置换和坐标更换 */
    for (int y = 0; y < TableWidth; y++) {
        for (int x = TableWidth - 2; x >= 0; x--) {
            /* 内层循环为从下往上，单列循环 */
            CSliderView *cell = self.mSourceArray[x][y];
            /* 从x的位置开始，往下循环遍历 */
            if (cell.number > 0) {
                for (int m = x ; m < TableWidth ; m++){
                    int nextIndex = m + 1;
                    if (nextIndex >= TableWidth) { break; }
                    [self columnMoveSortCurX:m nextX:nextIndex withCurY:y];
                }
            }
        }
    }
}


- (void)left {
    for (int x = 0; x < TableWidth; x++) {
        for (int y = 1; y < TableWidth; y++) {
            /* 内层循环为从下往上，单列循环 */
            CSliderView *cell = self.mSourceArray[x][y];
            if (cell.number > 0) {
                for (int m = y ; m >= 0 ; m--){
                    int nextIndex = m - 1;
                    if (nextIndex < 0) { break; }
                    [self rowMoveSortCurY:m nextY:nextIndex withCurX:x];
                }
            }
        }
    }
}

- (void)right {
    for (int x = 0; x < TableWidth; x++) {
        for (int y = TableWidth - 2; y >= 0; y--) {
            /* 内层循环为从下往上，单列循环 */
            CSliderView *cell = self.mSourceArray[x][y];
            if (cell.number > 0) {
                for (int m = y ; m < TableWidth ; m++){
                    int nextIndex = m + 1;
                    if (nextIndex >= TableWidth) { break; }
                    [self rowMoveSortCurY:m nextY:nextIndex withCurX:x];
                }
            }
        }
    }
}




/**
 上下滑动
 
 */
- (void)columnMoveSortCurX:(int)curX_ nextX:(int)nextX_ withCurY:(int)curY_ {
    CSliderView *curCell = self.mSourceArray[curX_][curY_];
    CSliderView *nextCell = self.mSourceArray[nextX_][curY_];
    if (nextCell.tempNumber == 0) {
        /* 坐标也做变更 */
        curCell.pointX = nextX_;
        nextCell.pointX = curX_;
        /* 在数组中的位置变更 */
        self.mSourceArray[curX_][curY_] = nextCell;
        self.mSourceArray[nextX_][curY_] = curCell;
    }else if (nextCell.tempNumber == curCell.tempNumber) {
        nextCell.tempNumber = nextCell.tempNumber * 2;
        curCell.tempNumber = 0;
    }
}

/**
 左右移动
 */
- (void)rowMoveSortCurY:(int)curY_ nextY:(int)nextY_ withCurX:(int)curX_ {
    CSliderView *curCell = self.mSourceArray[curX_][curY_];
    CSliderView *nextCell = self.mSourceArray[curX_][nextY_];
    if (nextCell.tempNumber == 0) {
        /* 坐标也做变更 */
        curCell.pointY = nextY_;
        nextCell.pointY = curY_;
        /* 在数组中的位置变更 */
        self.mSourceArray[curX_][curY_] = nextCell;
        self.mSourceArray[curX_][nextY_] = curCell;
    }else if (nextCell.tempNumber == curCell.tempNumber) {
        nextCell.tempNumber = nextCell.tempNumber * 2;
        curCell.tempNumber = 0;
    }
}



/**
 随机生成一个新的数字
 */
- (void)randomNewNumberAndDir:(MoveDirection)direction_ {
    if (direction_ == self.mMoveDir) {
        return;
    }
    self.mMoveDir = direction_;
    
    NSMutableArray *blankSliderVArray = [NSMutableArray new];
    /* 找出空白的滑块 */
    for (int i = 0; i < TableWidth * TableHeight; i++) {
        CSliderView *sliderV = [self getSliDerViewByIndex:i];
        if (sliderV.number == 0) {
            [blankSliderVArray addObject:@(i)];
        }
    }
    /* 剩余空白滑块随机产生Random */
    int randomIndex = [blankSliderVArray[[self getRandomNumber:0 to:(int)blankSliderVArray.count-1]] intValue];
    CSliderView *sliderV = [self getSliDerViewByIndex:randomIndex];
    sliderV.number = 2;
}


/**
 循环所有的模块进行动画移动
 */
- (void)toMoveSliderView:(MoveDirection)dir_ {
    
    [UIView animateWithDuration:0.3 animations:^{
        for (int i = 0; i < self.mSourceArray.count; i++) {
            for (int j = 0; j < self.mSourceArray[i].count; j++) {
                CSliderView *curCell = self.mSourceArray[i][j];
                [curCell toAnimation];
            }
        }
    } completion:^(BOOL finished) {
        if (finished) {
            /* 随机生成一个数字 */
            [self randomNewNumberAndDir:dir_];
        }
    }];
}



- (CSliderView *)getCellModelByX:(int)x_ Y:(int)y_ {
    
    if (x_ > self.mSourceArray.count) {
        return nil;
    }
    if (y_ > self.mSourceArray[x_].count) {
        return nil;
    }
    
    CSliderView *cell = self.mSourceArray[x_][y_];
    if (cell.number > 0) {
        return cell;
    }
    return nil;
}


- (CSliderView *)getSliDerViewByIndex:(int)index_ {
    int row = index_/TableWidth;
    int cos = index_%TableWidth;
    
    if (row > self.mSourceArray.count) {
        return nil;
    }
    if (cos > self.mSourceArray[row].count) {
        return nil;
    }
    
    CSliderView *cell = self.mSourceArray[row][cos];
    return cell;
}


@end
