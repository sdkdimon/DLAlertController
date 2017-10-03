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

@property(strong,nonatomic,readwrite) NSMutableArray<DLAlertAction *> *actions;
@property(strong,nonatomic,readwrite) NSMutableDictionary<NSNumber *,DLAlertActionVisualStyle *> *visualStyles;
@property (strong, nonatomic, readwrite) NSLayoutConstraint *actionBottomConstraint;
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
    _actions = [[NSMutableArray alloc] initWithCapacity:0];
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

- (void)loadView
{
    [super loadView];
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
                                                            constant:0.0f];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:actionView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:alertContentView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0f
                                                               constant:_bottomSpacing];
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

- (void)addAction:(DLAlertAction *)action
{
    [_actions addObject:action];
    [action addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:nil];
    if([self isViewLoaded])
    {
        NSInteger itemCount = [_actions count];
        DLAlertActionItemLayout itemLayout =  itemCount > 2 ? DLAlertActionItemLayoutVertical : DLAlertActionItemLayoutHorizontal;
        [[_actionView collectionViewLayout] setItemLayout:itemLayout];
        if([self isViewAppear])
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:(itemCount - 1) inSection:0];
            [UIView performWithoutAnimation:^{
                [[self actionView] insertItemsAtIndexPaths:@[indexPath]];
            }];
        }
    }
}

- (void)setBottomSpacing:(CGFloat)bottomSpacing
{
    _bottomSpacing = bottomSpacing;
    if ([self isViewLoaded]){
        [_actionBottomConstraint setConstant: - bottomSpacing];
    }
}

#pragma mark DLActionsCollectionViewDataSource

- (DLAlertAction *)actionCollectionView:(DLActionsCollectionView *)collectionView actionAtIndex:(NSUInteger)index
{
    return _actions[index];
}

- (DLAlertActionVisualStyle *)actionCollectionView:(DLActionsCollectionView *)collectionView actionVisualStyle:(DLAlertActionStyle)style
{
    return _visualStyles[@(style)];
}

- (NSInteger)numberOfActionsInActionCollectionView:(DLActionsCollectionView *)collectionView{
    return [_actions count];
}

#pragma mark Action Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([self isViewAppear])
    {
        NSUInteger actionIdx = [_actions indexOfObject:object];
        [UIView performWithoutAnimation:^{
            [[self actionView] reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:actionIdx inSection:0]]];
        }];
    }
}

#pragma mark DLActionsCollectionViewDelegate

- (void)actionCollectionView:(DLActionsCollectionView *)collectionView didExecuteActionAtIndex:(NSUInteger)index
{
    [self actionTap:index];
    DLAlertAction *action = _actions[index];
    void(^actionHandler)() = [action handler];
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
    for(DLAlertAction *action in _actions)
    {
        [action removeObserver:self forKeyPath:@"enabled"];
    }
}

@end
