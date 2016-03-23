//
// DLActionsCollectionView.m
// Copyright (c) 2015 Dmitry Lizin (sdkdimon@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "DLActionsCollectionView.h"
#import "DLAlertActionCell.h"

static NSString *const ACTION_CELL_REUSE_ID = @"ActionCell";

@interface DLActionsCollectionView () <UICollectionViewDataSource,UICollectionViewDelegate>
@property(strong,nonatomic,readonly) NSLayoutConstraint *heightConstraint;
@end

@implementation DLActionsCollectionView
@dynamic collectionViewLayout;

- (instancetype)init{
    self = [super initWithFrame:CGRectZero collectionViewLayout:[[DLAlertActionCollectionViewLayout alloc] init]];
    if(self != nil){
        [self setDataSource:self];
        [self setDelegate:self];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setDelaysContentTouches:YES];
        [self setScrollEnabled:NO];
        [self registerClass:[DLAlertActionCell class] forCellWithReuseIdentifier:ACTION_CELL_REUSE_ID];
        _heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:0];
        [self addConstraint:_heightConstraint];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints{
    CGSize contentSize = [self contentSize];
    [_heightConstraint setConstant:contentSize.height];
    [super updateConstraints];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _actionDataSource != nil ? [_actionDataSource numberOfActionsInActionCollectionView:self] : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DLAlertActionCell *actionCell = [collectionView dequeueReusableCellWithReuseIdentifier:ACTION_CELL_REUSE_ID forIndexPath:indexPath];
    NSInteger cellIdx = [indexPath item];
    DLAlertAction *action = [_actionDataSource actionCollectionView:self actionAtIndex:cellIdx];
    DLAlertActionVisualStyle *actionStyle = [_actionDataSource actionCollectionView:self actionVisualStyle:[action style]];
    UILabel *titleLabel = [actionCell titleLabel];
    [titleLabel setFont:[actionStyle font]];
    [titleLabel setText:[action title]];
    [self updateCell:actionCell visualStyle:actionStyle forActionState:[action isEnabled] ? DLAlertActionStateNormal : DLAlertActionStateDisabled];
   
    return actionCell;
}

- (void)updateCellAtIndexPath:(NSIndexPath *)indexPath forActionState:(DLAlertActionState)state{
    DLAlertActionCell *cell = (DLAlertActionCell *)[self cellForItemAtIndexPath:indexPath];
     DLAlertAction *action = [_actionDataSource actionCollectionView:self actionAtIndex:[indexPath item]];
    [self updateCell:cell visualStyle:[_actionDataSource actionCollectionView:self actionVisualStyle:[action style]] forActionState:state];
}

- (void)updateCell:(DLAlertActionCell *)cell visualStyle:(DLAlertActionVisualStyle *)style forActionState:(DLAlertActionState)state{
    UIColor *bgColor = [style backgroundColorForActionState:state];
    UIColor *txtColor = [style textColorForActionState:state];
    UIView *cellContentView = [cell contentView];
    [cellContentView setBackgroundColor:bgColor];
    [[cell titleLabel] setTextColor:txtColor];
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
   [self animateCellAtIndexpath:indexPath forActionState:DLAlertActionStateHighlighted];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self animateCellAtIndexpath:indexPath forActionState:DLAlertActionStateNormal];
    });
    
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    DLAlertAction *action = [_actionDataSource actionCollectionView:self actionAtIndex:[indexPath item]];
    return [action isEnabled];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    NSInteger index = [indexPath item];
    if(_actionDelegate != nil && [_actionDelegate respondsToSelector:@selector(actionCollectionView:didExecuteActionAtIndex:)]){
        [_actionDelegate actionCollectionView:self didExecuteActionAtIndex:index];
    }
    }

#pragma mark ActionCell Highlight Animation

- (void)animateCellAtIndexpath:(NSIndexPath *)indexPath forActionState:(DLAlertActionState)state{
    DLAlertActionCell *actionCell = (DLAlertActionCell *)[self cellForItemAtIndexPath:indexPath];
    DLAlertAction *action = [_actionDataSource actionCollectionView:self actionAtIndex:[indexPath item]];
    DLAlertActionVisualStyle *actionStyle = [_actionDataSource actionCollectionView:self actionVisualStyle:[action style]];
    
    CFTimeInterval animationDuration = .25f;
    
    UILabel *label = [actionCell titleLabel];
    UIView *contentView = [actionCell contentView];
    
    [[label layer] addAnimation:[self transitionAnimationWithDuration:animationDuration] forKey:nil];
    [[contentView layer] addAnimation:[self transitionAnimationWithDuration:animationDuration] forKey:nil];
    
    [label setTextColor:[actionStyle textColorForActionState:state]];
    [contentView setBackgroundColor:[actionStyle backgroundColorForActionState:state]];
}

- (CATransition *)transitionAnimationWithDuration:(CFTimeInterval)duration{
    CATransition *animation = [CATransition animation];
    [animation setRemovedOnCompletion:YES];
    [animation setDuration:duration];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setType:kCATransitionFade];
    [animation setAutoreverses:NO];
    return animation;
}

@end
