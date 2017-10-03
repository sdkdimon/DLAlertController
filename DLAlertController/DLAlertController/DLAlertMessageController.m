//
// DLAlertMessageController.m
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

#import "DLAlertMessageController.h"

@interface DLAlertMessageController ()

@property(strong,nonatomic,readwrite) UILabel *messageLabel;

@property(strong,nonatomic,readwrite) NSDictionary <NSNumber *, NSLayoutConstraint *> *messageLabelInsetsConstraints;

@end


@implementation DLAlertMessageController

+ (instancetype)controllerWithTitle:(NSString *)title message:(NSString *)message{
    return [[self alloc] initWithTitle:title message:message];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message{
    self = [super initWithTitle:title];
    if(self != nil){
        _message = message;
    }
    return self;
}

- (void)setup{
    [super setup];
    _messageFont  = nil;
    _messageTextColor = nil;
    _messageInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    _messageTextAlignment = NSTextAlignmentCenter;
}

- (void)loadView{
    [super loadView];
    [self loadMessageLabel];
}


- (void)loadMessageLabel{
    UIView *contentView  = [self contentView];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [contentView addSubview:messageLabel];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:messageLabel
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:contentView
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0f
                                                            constant:_messageInsets.top];
    
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:messageLabel
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:contentView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0f
                                                               constant:- _messageInsets.bottom];
    
    
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:messageLabel
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:contentView
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0f
                                                                constant:_messageInsets.left];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:messageLabel
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:contentView
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0f
                                                                 constant: - _messageInsets.right];
    

    
 
    
    
    NSArray *constraints = @[top,bottom,leading,trailing];
    
    
    
    
    [contentView addConstraints:constraints];
    
    [self setMessageLabelInsetsConstraints:[NSDictionary dictionaryWithObjects:constraints forKeys:@[@(NSLayoutAttributeTop),
                                                                                                   @(NSLayoutAttributeBottom),
                                                                                                   @(NSLayoutAttributeLeading),
                                                                                                   @(NSLayoutAttributeTrailing)]]];
    [self setMessageLabel:messageLabel];
}


- (void)setMessageInsets:(UIEdgeInsets)messageInsets{
    _messageInsets = messageInsets;
    if([self isViewLoaded]){
        [[_messageLabelInsetsConstraints objectForKey:@(NSLayoutAttributeTop)] setConstant:messageInsets.top];
        [[_messageLabelInsetsConstraints objectForKey:@(NSLayoutAttributeBottom)] setConstant: - messageInsets.bottom];
        [[_messageLabelInsetsConstraints objectForKey:@(NSLayoutAttributeLeading)] setConstant:messageInsets.left];
        [[_messageLabelInsetsConstraints objectForKey:@(NSLayoutAttributeTrailing)] setConstant: - messageInsets.right];
    }
}

- (void)setupMessageLabel{
    [_messageLabel setNumberOfLines:0];
    [_messageLabel setTextAlignment:_messageTextAlignment];
    [_messageLabel setBackgroundColor:[UIColor clearColor]];
    [_messageLabel setFont:_messageFont];
    [_messageLabel setTextColor:_messageTextColor];
    [_messageLabel setText:_message];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMessageLabel];
}


- (void)setMessageFont:(UIFont *)messageFont{
    _messageFont = messageFont;
     if([self isViewLoaded]){
         [_messageLabel setFont:messageFont];

     }
}

- (void)setMessage:(NSString *)message{
    _message = message;
    if([self isViewLoaded]){
        [_messageLabel setText:message];
    }
}

- (void)setMessageTextColor:(UIColor *)messageTextColor{
    _messageTextColor = messageTextColor;
    if([self isViewLoaded]){
        [_messageLabel setTextColor:messageTextColor];
        
    }
}

- (void)setMessageTextAlignment:(NSTextAlignment)messageTextAlignment{
    _messageTextAlignment = messageTextAlignment;
    if([self isViewAppear]){
        [_messageLabel setTextAlignment:messageTextAlignment];
    }
}

@end

