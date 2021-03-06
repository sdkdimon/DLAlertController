//
// DLAlertViewController.m
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

#import "DLAlertActionController.h"

#import "DLAlertView.h"

@interface DLAlertActionController () <DLActionsCollectionViewDataSource,DLActionsCollectionViewDelegate>

@property(strong,nonatomic,readonly) NSMutableArray<DLAlertAction *> *alertActions;
@property(strong,nonatomic,readwrite) NSMutableDictionary<NSNumber *,DLAlertActionVisualStyle *> *visualStyles;
@property (strong, nonatomic, readwrite) NSLayoutConstraint *actionBottomConstraint;
@property (strong, nonatomic, readwrite) NSLayoutConstraint *actionTopConstraint;
@property(assign,nonatomic,readwrite,getter=isViewAppear) BOOL viewAppear;

@end

@implementation DLAlertActionController

- (void)setup
{
    [super setup];
    _dismissableOnActionTap = NO;
    _dismssAnimationEnabled = NO;
    _actionHeight = 40.0f;
    _interActionSpacing = 8.0f;
    _alertActions = [[NSMutableArray alloc] initWithCapacity:0];
    _visualStyles = [@{@(DLAlertActionStyleDefault) : [DLAlertActionVisualStyle defaultStyle],
                       @(DLAlertActionStyleCancel) : [DLAlertActionVisualStyle cancelStyle],
                       @(DLAlertActionStyleDestructive) : [DLAlertActionVisualStyle destructiveStyle]} mutableCopy];
    _actionItemLayout = DLAlertActionItemLayoutHorizontal;
}

- (void)setActionVisualStyle:(DLAlertActionVisualStyle *)visualStyle forActionStyle:(DLAlertActionStyle)actionStyle
{
    [_visualStyles setObject:visualStyle forKey:@(actionStyle)];
}

- (DLAlertActionVisualStyle *)actionVisualStyleForActionStyle:(DLAlertActionStyle)actionStyle
{
    return [_visualStyles objectForKey:@(actionStyle)];
}

- (void)setupAlert
{
    [super setupAlert];
    DLAlertView *alert = [self alert];
    [[alert actionContentView] setBackgroundColor:[UIColor whiteColor]];
}

- (void)setupActionView
{
    DLAlertActionCollectionViewLayout *layout = [_actionView collectionViewLayout];
    [layout setItemHeight:_actionHeight];
    [layout setInterItemSpacing:_interActionSpacing];
    [layout setItemLayout:_actionItemLayout];
    [_actionView setActionDataSource:self];
    [_actionView setActionDelegate:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupActionView];
}

- (void)loadSubviews
{
    [super loadSubviews];
    [self loadActionView];
}

- (void)loadActionView
{
    UIView *alertContentView = [[self alert] actionContentView];
    
    DLActionsCollectionView *actionView = [[DLActionsCollectionView alloc] init];
    [actionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [alertContentView addSubview:actionView];
    
    
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:actionView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:alertContentView
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0f
                                                            constant:_actionTopSpacing];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:actionView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:alertContentView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0f
                                                               constant: - _actionBottomSpacing];
    [self setActionTopConstraint:top];
    [self setActionBottomConstraint:bottom];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:actionView
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:alertContentView
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0f
                                                                constant:0.0f];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:actionView
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:alertContentView
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0f
                                                                 constant:0.0f];
    
    [alertContentView addConstraints:@[top,bottom,leading,trailing]];
    
    [self setActionView:actionView];
}

- (void)setActionHeight:(CGFloat)actionHeight
{
    _actionHeight = actionHeight;
    if([self isViewLoaded])
    {
        [[_actionView collectionViewLayout] setItemHeight:actionHeight];
    }
}

- (void)setInterActionSpacing:(CGFloat)interActionSpacing
{
    _interActionSpacing = interActionSpacing;
    if([self isViewLoaded])
    {
        [[_actionView collectionViewLayout] setInterItemSpacing:interActionSpacing];
    }
}

- (void)setActionItemLayout:(DLAlertActionItemLayout)actionItemLayout
{
    _actionItemLayout = actionItemLayout;
    if([self isViewLoaded])
    {
        [[_actionView collectionViewLayout] setItemLayout:actionItemLayout];
    }
}

- (void)insertAction:(DLAlertAction *)action atIndex:(NSUInteger)index
{
    [_alertActions insertObject:action atIndex:index];
    [action addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:nil];
    [action addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    if([self isViewLoaded])
    {
        NSInteger itemCount = [_alertActions count];
        DLAlertActionItemLayout itemLayout =  itemCount > 2 ? DLAlertActionItemLayoutVertical : DLAlertActionItemLayoutHorizontal;
        [[_actionView collectionViewLayout] setItemLayout:itemLayout];
        if([self isViewAppear])
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            [UIView performWithoutAnimation:^{
                [self.actionView insertItemsAtIndexPaths:@[indexPath]];
            }];
        }
    }
    
}

- (void)addAction:(DLAlertAction *)action
{
    [self insertAction:action atIndex:self.alertActions.count];
}

- (void)removeAction:(DLAlertAction *)action
{
    if ([self containsAction:action])
    {
        NSUInteger inexOfAction = [self.alertActions indexOfObject:action];
        [self.alertActions removeObjectAtIndex:inexOfAction];
        [action removeObserver:self forKeyPath:@"enabled"];
        [action removeObserver:self forKeyPath:@"title"];
        if([self isViewLoaded])
        {
           NSInteger itemCount = [_alertActions count];
           DLAlertActionItemLayout itemLayout =  itemCount > 2 ? DLAlertActionItemLayoutVertical : DLAlertActionItemLayoutHorizontal;
           [[_actionView collectionViewLayout] setItemLayout:itemLayout];
           if([self isViewAppear])
           {
               [UIView performWithoutAnimation:^{
                   [self.actionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:inexOfAction inSection:0]]];
               }];
           }
        }
    }
}

- (BOOL)containsAction:(DLAlertAction *)action
{
    return [self.alertActions containsObject:action];
}

- (void)replaceAction:(DLAlertAction *)actionToReplace withAction:(DLAlertAction *)action
{
    if ([self containsAction:actionToReplace])
    {
        NSUInteger insertionIndex = [self.alertActions indexOfObject:actionToReplace];
        [self removeAction:actionToReplace];
        [self insertAction:action atIndex:insertionIndex];
    }
}

- (void)setActionBottomSpacing:(CGFloat)actionBottomSpacing
{
    _actionBottomSpacing = actionBottomSpacing;
    if ([self isViewLoaded]){
        [_actionBottomConstraint setConstant: - actionBottomSpacing];
    }
}

- (void)setActionTopSpacing:(CGFloat)actionTopSpacing
{
    _actionTopSpacing = actionTopSpacing;
    if ([self isViewLoaded]){
        [_actionTopConstraint setConstant:actionTopSpacing];
    }
}

#pragma mark DLActionsCollectionViewDataSource

- (DLAlertAction *)actionCollectionView:(DLActionsCollectionView *)collectionView actionAtIndex:(NSUInteger)index
{
    return _alertActions[index];
}

- (DLAlertActionVisualStyle *)actionCollectionView:(DLActionsCollectionView *)collectionView actionVisualStyle:(DLAlertActionStyle)style
{
    return _visualStyles[@(style)];
}

- (NSInteger)numberOfActionsInActionCollectionView:(DLActionsCollectionView *)collectionView{
    return [_alertActions count];
}

#pragma mark Action Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([self isViewAppear])
    {
        NSUInteger actionIdx = [_alertActions indexOfObject:object];
        [UIView performWithoutAnimation:^{
            [[self actionView] reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:actionIdx inSection:0]]];
        }];
    }
}

#pragma mark DLActionsCollectionViewDelegate

- (void)actionCollectionView:(DLActionsCollectionView *)collectionView didExecuteActionAtIndex:(NSUInteger)index
{
    [self actionTap:index];
    DLAlertAction *action = _alertActions[index];
    void(^actionHandler)(void) = [action handler];
    if(_dismissableOnActionTap)
    {
        [self dismissAnimated:_dismssAnimationEnabled completion:actionHandler];
        return;
    }
    if(actionHandler != NULL)
    {
        actionHandler();
    }
}

- (void)actionTap:(NSUInteger)actionIdx
{
    
}

#pragma mark ViewAppearance

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setViewAppear:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self setViewAppear:NO];
}

- (void)dealloc
{
    for(DLAlertAction *action in _alertActions)
    {
        [action removeObserver:self forKeyPath:@"enabled"];
        [action removeObserver:self forKeyPath:@"title"];
    }
}

@end
