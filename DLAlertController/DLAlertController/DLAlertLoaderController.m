//
// DLAlertLoaderController.m
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

#import "DLAlertLoaderController.h"

#import "DLAlertView.h"

@interface DLAlertLoaderController ()
@property(strong,nonatomic,readwrite) DLAlertView *alert;
@property(strong,nonatomic,readwrite) NSDictionary <NSNumber *, NSLayoutConstraint *> *alertInsetsConstraints;

@end

@implementation DLAlertLoaderController

- (void)setup
{
    [super setup];
    _alertMinHeight = .0f;
    _alertInsets = UIEdgeInsetsZero;
}

- (void)loadSubviews
{
    [super loadSubviews];
    [self loadAlert];
}

- (void)loadAlert
{
    UIView *contentView = [self view];
    
    DLAlertView *alertView = [[DLAlertView alloc] init];
    [alertView setContentMinHeight:_alertMinHeight];
    
    [alertView setTranslatesAutoresizingMaskIntoConstraints:NO];
   
    [contentView addSubview:alertView];
    
    [self setAlert:alertView];
    [self setupAlertLayoutConstraints];
}

- (void)setupAlertLayoutConstraints
{

    UIView *contentView = [self view];

    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:_alert
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:contentView
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:_alertInsets.left];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint
                                    constraintWithItem:_alert
                                    attribute:NSLayoutAttributeTrailing
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:contentView
                                    attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0f
                                    constant:- _alertInsets.right];
    
    id safeAreaTop = nil;
    id safeAreaBottom = nil;
    NSLayoutAttribute safeAreaTopAttribute = NSLayoutAttributeNotAnAttribute;
    NSLayoutAttribute safeAreaBottomAttribute = NSLayoutAttributeNotAnAttribute;
    
    if (@available(iOS 11.0, *)) {
        safeAreaTop = contentView.safeAreaLayoutGuide;
        safeAreaTopAttribute = NSLayoutAttributeTop;
        safeAreaBottom = contentView.safeAreaLayoutGuide;
        safeAreaBottomAttribute = NSLayoutAttributeBottom;
    } else {
        // Fallback on earlier versions
        safeAreaTop = self.topLayoutGuide;
        safeAreaTopAttribute = NSLayoutAttributeBottom;
        safeAreaBottom = self.bottomLayoutGuide;
        safeAreaBottomAttribute = NSLayoutAttributeTop;
    }
    
    
    
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:_alert
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                               toItem:safeAreaTop
                               attribute:safeAreaTopAttribute
                               multiplier:1.0f
                               constant:_alertInsets.top];
    
    
    
    NSLayoutConstraint *bottom =   [NSLayoutConstraint
                                    constraintWithItem:_alert
                                    attribute:NSLayoutAttributeBottom
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:safeAreaBottom
                                    attribute:safeAreaBottomAttribute
                                    multiplier:1.0f
                                    constant:- _alertInsets.bottom];
    
    bottom.priority = UILayoutPriorityDefaultHigh;
    
    
    NSArray <NSLayoutConstraint *> *constraints = @[top,bottom,leading,trailing,];
    
    
    
    
    [self setAlertInsetsConstraints:[NSDictionary dictionaryWithObjects:constraints forKeys:@[@(NSLayoutAttributeTop),
                                                                                                   @(NSLayoutAttributeBottom),
                                                                                                   @(NSLayoutAttributeLeading),
                                                                                                   @(NSLayoutAttributeTrailing)]]];
    
    [contentView addConstraints:constraints];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupAlert];
    
}

- (void)setupAlert
{
    
}

- (void)setAlertMinHeight:(CGFloat)alertMinHeight
{
    _alertMinHeight = alertMinHeight;
    if([self isViewLoaded]){
        [_alert setContentMinHeight:alertMinHeight];
    }
}

- (void)setAlertInsets:(UIEdgeInsets)alertInsets
{
    _alertInsets = alertInsets;
    if([self isViewLoaded]){
        [[_alertInsetsConstraints objectForKey:@(NSLayoutAttributeTop)] setConstant:alertInsets.top];
        [[_alertInsetsConstraints objectForKey:@(NSLayoutAttributeBottom)] setConstant: - alertInsets.bottom];
        [[_alertInsetsConstraints objectForKey:@(NSLayoutAttributeLeading)] setConstant:alertInsets.left];
        [[_alertInsetsConstraints objectForKey:@(NSLayoutAttributeTrailing)] setConstant: - alertInsets.right];
    }
    
}

@end
