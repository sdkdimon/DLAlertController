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

@interface DLAlertControllerBase ()

@property (strong, nonatomic, readwrite) UITapGestureRecognizer *rootViewTapGesture;
@property (copy, nonatomic, readwrite) void (^presentationCompletionBlock)(void);
@property (copy, nonatomic, readwrite) void (^dismissalCompletionBlock)(void);
@property (strong, nonatomic, readwrite) DLAlertTransitionController *transitionController;

@end

@implementation DLAlertControllerBase

#pragma mark Initialization

- (instancetype)init
{
    self = [super init];
    if(self != nil){
        [self setup];
    }
    return self;
}

#pragma mark Setup

- (void)setup
{
    _transitionController = [[DLAlertTransitionController alloc] init];
    _rootViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rootViewGestureTap:)];
    _rootViewTapGesture.delegate = self;
    self.transitioningDelegate = _transitionController;
    self.modalPresentationStyle = UIModalPresentationCustom;
}

#pragma mark View load

- (void)loadView
{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor colorWithWhite:0 alpha:.4f]];
    [view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [self setView:view];
}

- (void)loadSubviews
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSubviews];
    [self.view addGestureRecognizer:self.rootViewTapGesture];
}

- (void)rootViewGestureTap:(UITapGestureRecognizer *)sender
{

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return [[touch view] isEqual:[self view]];
}

@end

@implementation DLAlertControllerBase (Presentation)

- (void)presentAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    UIViewController *topViewController = [UIViewController topViewController:nil];
    [topViewController presentViewController:self animated:animated completion:completion];
}

- (void)dismissAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [self.presentingViewController dismissViewControllerAnimated:animated completion:completion];
}


@end
