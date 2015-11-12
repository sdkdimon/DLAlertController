//
// DLAlertPresentationController.m
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

#import "DLAlertPresentationController.h"

@interface DLAlertPresentationController ()

@property(strong,nonatomic,readwrite) UIView *dimmingView;

@end


@implementation DLAlertPresentationController

-(instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if(self != nil){
        _dimmingView = [[UIView alloc] init];
        [_dimmingView setBackgroundColor:[UIColor colorWithWhite:0 alpha:.4f]];
    }
    
    return self;
}

-(void)presentationTransitionWillBegin{
    [super presentationTransitionWillBegin];
    [[[self presentingViewController] view] setTintAdjustmentMode:UIViewTintAdjustmentModeDimmed];
    [[self dimmingView] setAlpha:0];
    [[self containerView] addSubview:[self dimmingView]];
    id <UIViewControllerTransitionCoordinator> coordinator =  [[self presentingViewController] transitionCoordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [[self dimmingView] setAlpha:1];
    } completion:nil];
}

-(void)dismissalTransitionWillBegin{
    [super dismissalTransitionWillBegin];
    [[[self presentingViewController] view] setTintAdjustmentMode:UIViewTintAdjustmentModeAutomatic];
    id <UIViewControllerTransitionCoordinator> coordinator =  [[self presentingViewController] transitionCoordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [[self dimmingView] setAlpha:0];
    } completion:nil];
}

-(void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    UIView *containerView = [self containerView];
    [[self dimmingView] setFrame:[containerView frame]];
}

@end
