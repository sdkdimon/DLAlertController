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

#import "DLAlertController.h"
#import "DLAlertView.h"
#import "DLAlertTransitionController.h"






@interface DLAlertController () <DLActionsCollectionViewDataSource,DLActionsCollectionViewDelegate>
@property(weak,nonatomic,readonly) DLAlertView *alertView;

@property(strong,nonatomic,readwrite) NSMutableArray<DLAlertAction *> *actions;
@property(strong,nonatomic,readwrite) NSMutableDictionary<NSNumber *,DLAlertActionVisualStyle *> *visualStyles;
@property(strong,nonatomic,readwrite) DLAlertTransitionController *transitionController;

@end

@implementation DLAlertController
@synthesize title = _title;

-(instancetype)init{
    self = [super init];
    if(self != nil){
        _actions = [[NSMutableArray alloc] initWithCapacity:0];
        _visualStyles = [@{@(DLAlertActionStyleDefault) : [DLAlertActionVisualStyle defaultStyle],
                           @(DLAlertActionStyleCancel) : [DLAlertActionVisualStyle cancelStyle],
                           @(DLAlertActionStyleDestructive) : [DLAlertActionVisualStyle destructiveStyle]} mutableCopy];
        _transitionController = [[DLAlertTransitionController alloc] init];
        [self setModalPresentationStyle:UIModalPresentationCustom];
        [self setTransitioningDelegate:_transitionController];
    }
    return self;
}

-(void)setActionVisualStyle:(DLAlertActionVisualStyle *)visualStyle forActionStyle:(DLAlertActionStyle)actionStyle{
    [_visualStyles setObject:visualStyle forKey:@(actionStyle)];
}

-(DLAlertActionVisualStyle *)actionVisualStyleForActionStyle:(DLAlertActionStyle)actionStyle{
    return [_visualStyles objectForKey:@(actionStyle)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor clearColor]];
    [[self alertView] setBackgroundColor:[UIColor whiteColor]];
   
}

-(void)loadView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    DLAlertView *alertView = [DLAlertView alertWithContentView:[self alertContentView]];
    [[alertView titleLabel] setText:_title];
    DLActionsCollectionView *actionView = [alertView actionsCollectionView];
    [actionView setActionDelegate:self];
    [actionView setActionDataSource:self];
    [[actionView collectionViewLayout] setItemLayout:[_actions count] > 2 ? DLAlertActionItemLayoutVertical : DLAlertActionItemLayoutHorizontal];
    [alertView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view addSubview:alertView];
    
    NSLayoutConstraint *alertHeightConstraint = [NSLayoutConstraint constraintWithItem:alertView
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1.0f
                                                                               constant:40];
    [alertView addConstraint:alertHeightConstraint];

    NSLayoutConstraint *alertLeadingConstraint = [NSLayoutConstraint constraintWithItem:alertView
                                                                              attribute:NSLayoutAttributeLeading
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:view
                                                                              attribute:NSLayoutAttributeLeading
                                                                             multiplier:1.0f
                                                                               constant:0.0f];
    
     NSLayoutConstraint *alertTrailingConstraint = [NSLayoutConstraint constraintWithItem:alertView
                                                                                attribute:NSLayoutAttributeTrailing
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:view
                                                                                attribute:NSLayoutAttributeTrailing
                                                                               multiplier:1.0f
                                                                                 constant:0.0f];
    
     NSLayoutConstraint *alertBottomConstraint = [NSLayoutConstraint constraintWithItem:alertView
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:view attribute:NSLayoutAttributeBottom
                                                                             multiplier:1.0f
                                                                               constant:0.0f];
    
    [view addConstraints:@[alertLeadingConstraint,alertTrailingConstraint,alertBottomConstraint]];
    
    
    [self setView:view];
    _alertView = alertView;
    [alertView prepareLayout];
}


-(void)addAction:(DLAlertAction *)action{
    [_actions addObject:action];
    [action addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:nil];
    if(_alertView != nil){
        NSInteger itemCount = [_actions count];
        DLActionsCollectionView *actionView = [_alertView actionsCollectionView];
        DLAlertActionItemLayout itemLayout =  itemCount > 2 ? DLAlertActionItemLayoutVertical : DLAlertActionItemLayoutHorizontal;
        [[actionView collectionViewLayout] setItemLayout:itemLayout];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemCount - 2 inSection:0];
        [actionView insertItemsAtIndexPaths:@[indexPath]];
    }
}

-(void)setTitle:(NSString *)title{
    _title = title;
    if(_alertView != nil){
        [[_alertView titleLabel] setText:title];
    }
}


-(UIView *)alertContentView{
    return nil;
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
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)dealloc{
    for(DLAlertAction *action in _actions){
        [action removeObserver:self forKeyPath:@"enabled"];
    }
}

@end
