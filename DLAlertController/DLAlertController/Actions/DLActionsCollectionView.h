//
// DLActionsCollectionView.h
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

#import <UIKit/UIKit.h>
#import <DLAlertController/DLAlertAction.h>
#import <DLAlertController/DLAlertActionCollectionViewLayout.h>
#import <DLAlertController/DLAlertActionVisualStyle.h>

@class DLActionsCollectionView;

NS_ASSUME_NONNULL_BEGIN

@protocol DLActionsCollectionViewDelegate <NSObject>

- (void)actionCollectionView:(DLActionsCollectionView *)collectionView didExecuteActionAtIndex:(NSUInteger)index;

@end

@protocol DLActionsCollectionViewDataSource <NSObject>

- (NSInteger)numberOfActionsInActionCollectionView:(DLActionsCollectionView *)collectionView;
- (DLAlertAction *)actionCollectionView:(DLActionsCollectionView *)collectionView actionAtIndex:(NSUInteger)index;
- (DLAlertActionVisualStyle *)actionCollectionView:(DLActionsCollectionView *)collectionView actionVisualStyle:(DLAlertActionStyle)style;

@end

@interface DLActionsCollectionView : UICollectionView

@property(weak,nonatomic,readwrite) id <DLActionsCollectionViewDataSource> actionDataSource;
@property(weak,nonatomic,readwrite) id <DLActionsCollectionViewDelegate> actionDelegate;
@property(strong,nonatomic,readwrite) DLAlertActionCollectionViewLayout *collectionViewLayout;

@end

NS_ASSUME_NONNULL_END
