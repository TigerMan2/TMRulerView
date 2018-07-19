//
//  YJRulerView.m
//  YJRuerView
//
//  Created by edward lannister on 2018/7/13.
//  Copyright © 2018年 edward lannister. All rights reserved.
//

#import "YJScrollRulerView.h"
#import "YJTriangleView.h"
#import "YJRulerView.h"

@interface YJScrollRulerView ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UIScrollViewDelegate
>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) YJTriangleView *triangle;

//基础设置值
@property(nonatomic, assign)float           realValue;
@property (nonatomic, strong) NSString      *unit;//单位
@property(nonatomic, assign)float           stepNum;//分多少个区
@property(nonatomic, assign)float           minValue;//游标的最小值
@property(nonatomic, assign)float           maxValue;//游标的最大值
@property(nonatomic, assign)float           step;//间隔值，每两条相隔多少值
@property(nonatomic, assign)NSInteger       betweenNum;

@end

@implementation YJScrollRulerView

- (instancetype)initWithFrame:(CGRect)frame minValue:(float)minValue maxValue:(float)maxValue step:(float)step unit:(NSString *)unit num:(NSInteger)betweenNum {
    self = [super initWithFrame:frame];
    if (self) {
        self.minValue   = minValue;
        self.maxValue   = maxValue;
        self.step       = step;
        self.stepNum    = (self.maxValue - self.minValue) / _step / betweenNum;
        self.unit       = unit;
        self.betweenNum = betweenNum;
        RVCShareIns.step = step;
        RVCShareIns.betweenNum = betweenNum;
        self.triangleColor = RVCShareIns.triangleColor;
        self.backgroundColor = RVCShareIns.rulerBgColor;
        [self addSubview:self.collectionView];
        [self addSubview:self.triangle];
    }
    return self;
}

- (YJTriangleView *)triangle{
    if (!_triangle) {
        _triangle = [[YJTriangleView alloc]initWithFrame:CGRectMake(self.bounds.size.width / 2 - RVCShareIns.trangle_W / 2, 0, RVCShareIns.trangle_W, RVCShareIns.trangle_W)];
        _triangle.triangleColor = self.triangleColor;
        _triangle.backgroundColor = [UIColor clearColor];
    }
    return _triangle;
}

#pragma mark ------UICollectionView------
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor orangeColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.contentSize = CGSizeMake(_stepNum * _step + [UIScreen mainScreen].bounds.size.width / 2 - 26.f, self.bounds.size.height);
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"customCell"];
    }
    return _collectionView;
}

#pragma mark ------Target Or Method------
- (void)setRealValue:(CGFloat)value animated:(BOOL)animated {
    [self.collectionView setContentOffset:CGPointMake((int)value * RVCShareIns.rulerGap, 0) animated:animated];
}
- (void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.collectionView.backgroundColor = _bgColor;
}

- (void)setTriangleColor:(UIColor *)triangleColor{
    _triangleColor = triangleColor;
    self.triangle.triangleColor = _triangleColor;
}
//设置真实值
- (void)setRealValue:(float)realValue {
    [self setRealValue:realValue animated:NO];
}
//设置默认值
- (void)setDefaultValue:(float)defaultValue animated:(BOOL)animated {
    _realValue      = defaultValue;
    [_collectionView setContentOffset:CGPointMake(((defaultValue-_minValue)/(float)_step) * RVCShareIns.rulerGap, 0) animated:animated];
    
}


#pragma mark ------UICollectionViewDelegate------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2 + _stepNum;//真实区间 + 左右占位
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCell" forIndexPath:indexPath];
    YJRulerView *rulerView = [cell.contentView viewWithTag:1002];
    [rulerView removeFromSuperview];
    rulerView = nil;
    CGRect frame = CGRectMake(0, 0, RVCShareIns.rulerGap * _betweenNum, RVCShareIns.rulerView_H);
    if (indexPath.item == 0 || indexPath.item == _stepNum + 1) {
        if (indexPath.item == 0) {
            ///3x屏幕起始点会有0.1误差这里处理
            frame = CGRectMake(0, 0, self.frame.size.width / 2 + 0.1, RVCShareIns.rulerView_H);
        }else{
            frame = CGRectMake(0, 0, self.frame.size.width / 2, RVCShareIns.rulerView_H);
        }
    }
    if (!rulerView){
        rulerView  = [[YJRulerView alloc]initWithFrame:frame];
        rulerView.tag               = 1002;
        rulerView.backgroundColor = [UIColor clearColor];
        rulerView.betweenNumber     = _betweenNum;
        rulerView.step              = _step;
        [cell.contentView addSubview:rulerView];
    }
    
    if (indexPath.item == 0) {
        rulerView.isPlaceholderCell_Min = YES;
        rulerView.isPlaceholderCell_Max = NO;
        rulerView.minValue = (NSInteger)(self.minValue - _step * _betweenNum);
        rulerView.maxValue = self.minValue;
    } else if (indexPath.item == _stepNum + 1) {
        rulerView.isPlaceholderCell_Min = NO;
        rulerView.isPlaceholderCell_Max = YES;
        rulerView.minValue = self.maxValue;
        rulerView.maxValue = self.maxValue + _step * _betweenNum;
    } else {
        rulerView.isPlaceholderCell_Min = NO;
        rulerView.isPlaceholderCell_Max = NO;
        rulerView.minValue = _step * (indexPath.item - 1) * _betweenNum + _minValue;
        rulerView.maxValue = _step * indexPath.item * _betweenNum;
    }
    
    [rulerView setNeedsDisplay];
    return cell;
}

- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0 || indexPath.item == _step + 1) {
        return CGSizeMake(self.frame.size.width / 2, RVCShareIns.rulerView_H);
    }
    return CGSizeMake(_betweenNum * RVCShareIns.rulerGap , RVCShareIns.rulerView_H);
 
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}

#pragma mark ------UIScrollViewDelegate------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int value = scrollView.contentOffset.x / 10;
    CGFloat totalValue = value * 10;
    
    if (totalValue > _maxValue) {
        totalValue = _maxValue;
    }
    
    if (totalValue < _minValue) {
        totalValue = _minValue;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(sbScrollRulerView:valueChange:)]) {
        [self.delegate sbScrollRulerView:self valueChange:totalValue];
    }
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{//拖拽时没有滑动动画
    if (!decelerate){
        [self setRealValue:round(scrollView.contentOffset.x/(RVCShareIns.rulerGap)) animated:YES];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self setRealValue:round(scrollView.contentOffset.x/(RVCShareIns.rulerGap)) animated:YES];
}

@end
