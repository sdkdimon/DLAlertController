//
// AlertInputController.m
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

#import "AlertInputController.h"

#import "DLAlertView.h"

@interface AlertInputController()

@property(strong,nonatomic,readwrite) UITextField *textField;
@property(strong,nonatomic,readwrite) NSLayoutConstraint *textFieldHeightConstraint;
@property(strong,nonatomic,readwrite) UILabel *messageLabel;
@property(strong,nonatomic,readwrite) NSNotificationCenter *notificationCenter;

@end

@implementation AlertInputController

- (void)setup
{
    [super setup];
    _contentControlsInsets = UIEdgeInsetsMake(25, 10, 25, 10);
    _textFieldInsets = UIEdgeInsetsMake(25, 10, 25, 10);
    _notificationCenter = [NSNotificationCenter defaultCenter];
}

- (void)loadSubviews
{
    [super loadSubviews];
    [self loadMessageLabel];
    [self loadTextField];
}


- (void)loadMessageLabel
{
    UIView *contentView = [self contentView];
    
    UILabel *messageLabel = [[UILabel alloc] init];
    [messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [contentView addSubview:messageLabel];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:messageLabel
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:contentView
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0f
                                                            constant:_contentControlsInsets.top];

    
    
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:messageLabel
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:contentView
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0f
                                                                constant:_contentControlsInsets.left];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:messageLabel
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:contentView
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0f
                                                                 constant: - _contentControlsInsets.right];
    
    
    NSArray *constraints = @[top,leading,trailing];
    
    [self setMessageLabel:messageLabel];
    
    [contentView addConstraints:constraints];

}

- (void)loadTextField
{
    UIView *contentView = [self contentView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [contentView addSubview:textField];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:textField
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0f
                                                               constant:36.0f];
    [textField addConstraint:height];
    [self setTextFieldHeightConstraint:height];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:textField
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:_messageLabel
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0f
                                                            constant:_textFieldInsets.top];
    
    
    
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:textField
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:contentView
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0f
                                                                constant:_textFieldInsets.left];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:textField
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:contentView
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0f
                                                                 constant:-_textFieldInsets.right];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:textField
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:contentView
                                                              attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0f
                                                                 constant:-_textFieldInsets.bottom];
    
    

    
    NSArray *constraints = @[top,leading,trailing,bottom];
    
    [contentView addConstraints:constraints];
    
    
    UIView *borderView = [[UIView alloc] initWithFrame:CGRectZero];
    [borderView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [contentView addSubview:borderView];
    [borderView setBackgroundColor:[UIColor lightGrayColor]];
    
     NSLayoutConstraint *borderViewHeight = [NSLayoutConstraint constraintWithItem:borderView
                                                                         attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:1.0f];
    [borderView addConstraint:borderViewHeight];
    
    NSLayoutConstraint *borderViewTop = [NSLayoutConstraint constraintWithItem:borderView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:textField
                                                           attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
 
    NSLayoutConstraint *borderViewLeading = [NSLayoutConstraint constraintWithItem:borderView
                                                                     attribute:NSLayoutAttributeLeading
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:textField
                                                                     attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *borderViewTrailing = [NSLayoutConstraint constraintWithItem:borderView
                                                                     attribute:NSLayoutAttributeTrailing
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:textField
                                                                     attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
    
    NSArray *borderViewConstraints = @[borderViewTop,borderViewLeading,borderViewTrailing];
    
    [contentView addConstraints:borderViewConstraints];
    [self setTextField:textField];
}

- (void)setupMessageLabel
{
    [_messageLabel setNumberOfLines:0];
    [_messageLabel setTextAlignment:NSTextAlignmentCenter];
    [_messageLabel setText:_message];
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    if([self isViewLoaded]){
        [_messageLabel setText:message];
    }
}

- (void)setupTextField
{
    
}

- (void)rootViewGestureTap:(UITapGestureRecognizer *)sender
{
    [super rootViewGestureTap:sender];
    [[self view] endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupMessageLabel];
    [self setupTextField];
    if ([self viewDidLoadBlodk] != NULL){
        [self viewDidLoadBlodk](self);
    }
}

- (void)actionTap:(NSUInteger)actionIdx
{
     [[self view] endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self unregisterKeyboardNotifications];
   
    
}
- (void)unregisterKeyboardNotifications
{
    [_notificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [_notificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)registerKeyboardNotifications
{
    [_notificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [_notificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardWillHide:(NSNotification *)notification
{
    [self animateKeyboardAppearanceWithUserInfo:[notification userInfo]];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    [self animateKeyboardAppearanceWithUserInfo:[notification userInfo]];
}

- (void)animateKeyboardAppearanceWithUserInfo:(NSDictionary *)userInfo
{
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationOptions animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGRect kbFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:duration delay:0 options:(animationCurve | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        UIView *view = [self view];
        CGRect frame = [view frame];
        frame.size.height = [UIScreen mainScreen].bounds.size.height;
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        
        CGFloat deltaForAlert = (self.alert.frame.origin.y + frame.origin.y) - statusBarHeight;
        CGFloat delta = frame.origin.y + frame.size.height - (kbFrame.origin.y - (statusBarHeight - 20));
        frame.origin.y -= MIN(delta,deltaForAlert);
        [view setFrame:frame];
    }                completion:NULL];
}


@end
