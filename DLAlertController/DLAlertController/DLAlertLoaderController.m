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
@property(assign,nonatomic,readonly) UIEdgeInsets alertInsets;
@end

@implementation DLAlertLoaderController

-(void)loadView{
    [super loadView];
    [self loadAlert];
    
}

-(void)loadAlert{
    UIView *contentView = [self view];
    
    DLAlertView *alertView = [[DLAlertView alloc] init];
    
    [alertView setTranslatesAutoresizingMaskIntoConstraints:NO];
   
    [contentView addSubview:alertView];
    
    [self setAlert:alertView];
    [self setupAlertLayoutConstraints];

    
}

-(void)setupAlertLayoutConstraints{

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
    
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:_alert
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                               toItem:contentView
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0f
                               constant:_alertInsets.top];
    
    
    
    NSLayoutConstraint *bottom =   [NSLayoutConstraint
                                    constraintWithItem:_alert
                                    attribute:NSLayoutAttributeBottom
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:contentView
                                    attribute:NSLayoutAttributeBottom
                                    multiplier:1.0f
                                    constant:- _alertInsets.bottom];
    
    [contentView addConstraints:@[leading,trailing,top,bottom]];
}


@end
