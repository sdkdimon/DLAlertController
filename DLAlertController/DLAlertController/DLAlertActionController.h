//
// DLAlertViewController.h
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

#import <DLAlertController/DLAlertTitleController.h>

#import <DLAlertController/DLAlertAction.h>
#import <DLAlertController/DLAlertActionVisualStyle.h>
#import <DLAlertController/DLActionsCollectionView.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLAlertActionController : DLAlertTitleController

@property(assign,nonatomic,readwrite,getter=isDismissableOnActionTap) BOOL dismissableOnActionTap;
@property(assign,nonatomic,readwrite,getter=isDismssAnimationEnabled) BOOL dismssAnimationEnabled;
@property(assign,nonatomic,readonly,getter=isViewAppear) BOOL viewAppear;

@property(strong,nonatomic,readwrite) DLActionsCollectionView *actionView;

@property(assign,nonatomic,readwrite) CGFloat actionHeight;
@property(assign,nonatomic,readwrite) CGFloat interActionSpacing;
@property(assign,nonatomic,readwrite) CGFloat actionTopSpacing;
@property(assign,nonatomic,readwrite) CGFloat actionBottomSpacing;
@property(assign,nonatomic,readwrite) DLAlertActionItemLayout actionItemLayout;

- (void)insertAction:(DLAlertAction *)action atIndex:(NSUInteger)index;
- (void)addAction:(DLAlertAction *)action;
- (void)removeAction:(DLAlertAction *)action;
- (BOOL)containsAction:(DLAlertAction *)action;
- (void)replaceAction:(DLAlertAction *)actionToReplace withAction:(DLAlertAction *)action;
- (void)setActionVisualStyle:(DLAlertActionVisualStyle *)visualStyle forActionStyle:(DLAlertActionStyle)actionStyle;
- (DLAlertActionVisualStyle *)actionVisualStyleForActionStyle:(DLAlertActionStyle)actionStyle;
- (void)actionTap:(NSUInteger)actionIdx;

@end

NS_ASSUME_NONNULL_END



