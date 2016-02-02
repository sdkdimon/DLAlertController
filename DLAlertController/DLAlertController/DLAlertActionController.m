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
#import "DLActionsCollectionView.h"
#import "DLAlertTransitionController.h"
#import "DLAlertView.h"

@interface DLAlertActionController () <DLActionsCollectionViewDataSource,DLActionsCollectionViewDelegate>

@property(strong,nonatomic,readwrite) NSMutableArray<DLAlertAction *> *actions;
@property(strong,nonatomic,readwrite) NSMutableDictionary<NSNumber *,DLAlertActionVisualStyle *> *visualStyles;
@property(strong,nonatomic,readwrite) DLAlertTransitionController *transitionController;

@property(assign,nonatomic,readwrite,getter=isViewAppear) BOOL viewAppear;

@property(strong,nonatomic,readwrite) DLActionsCollectionView *actionView;

@end

@implementation DLAlertActionController

-(void)setup{
    [super setup];
    _actionHeight = 40.0f;
    _actions = [[NSMutableArray alloc] initWithCapacity:0];
    _visualStyles = [@{@(DLAlertActionStyleDefault) : [DLAlertActionVisualStyle defaultStyle],
                       @(DLAlertActionStyleCancel) : [DLAlertActionVisualStyle cancelStyle],
                       @(DLAlertActionStyleDestructive) : [DLAlertActionVisualStyle destructiveStyle]} mutableCopy];
    _transitionController = [[DLAlertTransitionController alloc] init];
    [self setTransitioningDelegate:_transitionController];
}

-(void)setActionVisualStyle:(DLAlertActionVisualStyle *)visualStyle forActionStyle:(DLAlertActionStyle)actionStyle{
    [_visualStyles setObject:visualStyle forKey:@(actionStyle)];
}

-(DLAlertActionVisualStyle *)actionVisualStyleForActionStyle:(DLAlertActionStyle)actionStyle{
    return [_visualStyles objectForKey:@(actionStyle)];
}


-(void)setupAlertView{
    DLAlertView *alert = [self alert];
    [[alert contentView] setBackgroundColor:[UIColor whiteColor]];
    [[alert actionContentView] setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupActionView{
    DLAlertActionCollectionViewLayout *layout = [_actionView collectionViewLayout];
    [layout setItemHeight:_actionHeight];
    [layout setItemLayout:[_actions count] > 2 ? DLAlertActionItemLayoutVertical : DLAlertActionItemLayoutHorizontal];
    
    [_actionView setActionDataSource:self];
    [_actionView setActionDelegate:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAlertView];
    [self setupActionView];

}


-(void)loadView{
    [super loadView];
    [self loadActionView];
}

-(void)loadActionView{
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
                                                               constant:0.0f];
    
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

-(void)setActionHeight:(CGFloat)actionHeight{
    _actionHeight = actionHeight;
    if([self isViewLoaded]){
        [[_actionView collectionViewLayout] setItemHeight:actionHeight];
    }
}

-(void)addAction:(DLAlertAction *)action{
    [_actions addObject:action];
    [action addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:nil];
    if([self isViewLoaded]){
        NSInteger itemCount = [_actions count];
        DLAlertActionItemLayout itemLayout =  itemCount > 2 ? DLAlertActionItemLayoutVertical : DLAlertActionItemLayoutHorizontal;
        [[_actionView collectionViewLayout] setItemLayout:itemLayout];
        if([self isViewAppear]){
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:(itemCount - 1) inSection:0];
            [_actionView insertItemsAtIndexPaths:@[indexPath]];
        }
    }
}


#pragma mark DLActionsCollectionViewDataSource

-(DLAlertAction *)actionCollectionView:(DLActionsCollectionView *)collectionView actionAtIndex:(NSUInteger)index{
    return _actions[index];
}

-(DLAlertActionVisualStyle *)actionCollectionView:(DLActionsCollectionView *)collectionView actionVisualStyle:(DLAlertActionStyle)style{
    return _visualStyles[@(style)];
}

-(NSInteger)nubberOfActionsInActionCollectionView:(DLActionsCollectionView *)collectionView{
    return [_actions count];
}

#pragma mark Action Observing

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
}

#pragma mark DLActionsCollectionViewDelegate

-(void)actionCollectionView:(DLActionsCollectionView *)collectionView didExecuteActionAtIndex:(NSUInteger)index{
    [self actionTap:index];
}

-(void)actionTap:(NSUInteger)actionIdx{
}

#pragma mark ViewAppearance

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setViewAppear:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self setViewAppear:NO];
}

-(void)rootViewGestureTap:(UITapGestureRecognizer *)sender{
    [self dismissAnimated:YES completion:nil];
    NSLog(@"TOUCH OUTSIDE");
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return [[touch view] isEqual:[self view]];
}

-(void)dealloc{
    for(DLAlertAction *action in _actions){
        [action removeObserver:self forKeyPath:@"enabled"];
    }
}

@end
