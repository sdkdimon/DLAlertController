//
// DLAlertControllerTest.m
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

#import "DLAlertControllerBase.h"
#import "UIViewController+TopViewController.h"
#import "DLAlertTransitionController.h"

@interface DLAlertControllerBase () <DLAlertTransitionControllerDelegate>

@property(strong,nonatomic,readwrite) UITapGestureRecognizer *rootViewTapGesture;
@property(strong,nonatomic,readwrite) DLAlertTransitionController *transitionController;

@property (copy, nonatomic, readwrite) void (^presentationCompletionBlock)();
@property (copy, nonatomic, readwrite) void (^dismissalCompletionBlock)();

@end

@implementation DLAlertControllerBase

#pragma mark Initialization

- (instancetype)init{
    self = [super init];
    if(self != nil){
        [self setup];
    }
    return self;
}

#pragma mark Setup

- (void)setup{
    _transitionController = [[DLAlertTransitionController alloc] init];
    [_transitionController setDelegate:self];
    [self setTransitioningDelegate:_transitionController];
    [self setModalPresentationStyle:UIModalPresentationCustom];
}

#pragma mark View load

- (void)loadView{
    UIView *view = [[UIView alloc] init];
    [view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [self setView:view];
}

- (void)setupRootViewTapGesture{
    _rootViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rootViewGestureTap:)];
    [_rootViewTapGesture setDelegate:self];
    [[self view] addGestureRecognizer:_rootViewTapGesture];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupRootViewTapGesture];
}


- (void)rootViewGestureTap:(UITapGestureRecognizer *)sender{

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return [[touch view] isEqual:[self view]];
}


- (void)alertTransitionController:(DLAlertTransitionController *)controller didEndDismissalTransition:(BOOL)finished{
    if (_dismissalCompletionBlock != NULL){
        _dismissalCompletionBlock();
        _dismissalCompletionBlock = NULL;
    }
    [self didEndDismissalTransition:finished];
    
}

- (void)alertTransitionController:(DLAlertTransitionController *)controller didEndPresentationTransition:(BOOL)finished{
    if (_presentationCompletionBlock != NULL){
        _presentationCompletionBlock();
        _presentationCompletionBlock = NULL;
    }
    [self didEndPresentationTransition:finished];
}


- (void)didEndDismissalTransition:(BOOL)finished{
    
}

- (void)didEndPresentationTransition:(BOOL)finished{
    
}

@end


@implementation DLAlertControllerBase (Presentation)

- (void)presentAnimated:(BOOL)animated completion:(void (^)())completion{
    [self setPresentationCompletionBlock:completion];
    UIViewController *topViewController = [UIViewController topViewController:nil];
    [topViewController presentViewController:self animated:animated completion:nil];
    
}

- (void)dismissAnimated:(BOOL)animated completion:(void (^)())completion{
    [self setDismissalCompletionBlock:completion];
    [[self presentingViewController] dismissViewControllerAnimated:animated completion:nil];

}

@end


