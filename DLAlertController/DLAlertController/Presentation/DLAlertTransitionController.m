//
// DLAlertTransitionController.m
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

#import "DLAlertTransitionController.h"

#import "DLAlertAnimationController.h"
#import "DLAlertPresentationController.h"

@interface DLAlertTransitionController () <DLAlertAnimationControllerDelegate>

@end

@implementation DLAlertTransitionController

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source
{
    DLAlertAnimationController *animationController = [[DLAlertAnimationController alloc] init];
    [animationController setPresentation:YES];
    [animationController setDelegate:self];
    return animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    DLAlertAnimationController *animationController = [[DLAlertAnimationController alloc] init];
    [animationController setPresentation:NO];
    [animationController setDelegate:self];
    return animationController;
}

- (void)animationConroller:(DLAlertAnimationController *)controller didEndAnimation:(BOOL)finished
{
    
}

- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                     presentingViewController:(UIViewController *)presenting
                                                         sourceViewController:(UIViewController *)source
{
    
    return [[DLAlertPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
