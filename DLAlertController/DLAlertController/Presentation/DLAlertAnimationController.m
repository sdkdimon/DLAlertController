//
// DLAlertAnimationController.m
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

#import "DLAlertAnimationController.h"

static CGFloat const INITIAL_SCALE = 1.2f;
static CGFloat const SPRING_DAMPING = 45.71f;
static CGFloat const SPRING_VELOCITY = 0;

@implementation DLAlertAnimationController

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return .404f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = [fromViewController view];
    UIView *toView = [toViewController view];
    
    
    if([self isPresentation]){
        [[transitionContext containerView] addSubview:toView];
    }
    
    UIViewController *animatingViewController = [self isPresentation] ? toViewController : fromViewController;
    UIView *animatingView = [animatingViewController view];
    [animatingView setFrame:[transitionContext finalFrameForViewController:animatingViewController]];
   
    if([self isPresentation]){
        [animatingView setTransform:CGAffineTransformMakeScale(INITIAL_SCALE, INITIAL_SCALE)];
        [animatingView setAlpha:0];
        
        [self animate:^{
            [animatingView setTransform:CGAffineTransformMakeScale(1, 1)];
            [animatingView setAlpha:1];
        } inContext:transitionContext withCompletion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];
        
        
    } else{
        [self animate:^{
            [animatingView setAlpha:0];
        } inContext:transitionContext withCompletion:^(BOOL finished) {
            [fromView removeFromSuperview];
            [transitionContext completeTransition:finished];
        }];
    }
}


- (void)animate:(void(^)())animations inContext:(id <UIViewControllerContextTransitioning>)context withCompletion:(void(^)(BOOL finished))completion{
    [UIView animateWithDuration:[self transitionDuration:context] delay:0 usingSpringWithDamping:SPRING_DAMPING initialSpringVelocity:SPRING_VELOCITY options:0 animations:animations completion:completion];
}


@end
