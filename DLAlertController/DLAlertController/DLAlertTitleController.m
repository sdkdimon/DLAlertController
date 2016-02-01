//
// DLAlertTitleController.m
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


#import "DLAlertTitleController.h"
#import "DLAlertView.h"
#import "DLAlertLabel.h"


@interface DLAlertTitleController ()
@property(strong,nonatomic,readwrite) UILabel *titleLabel;
@property(strong,nonatomic,readwrite) UIView *contentView;

@property(strong,nonatomic,readwrite) NSDictionary <NSNumber *, NSLayoutConstraint *> *titleLabelInsetsConstraints;

@end


@implementation DLAlertTitleController
@synthesize title = _title;

+(instancetype)controllerWithTitle:(NSString *)title{
    return [[self alloc] initWithTitle:title];
}

-(instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if(self != nil){
        _title = title;
    }
    return self;
}

-(void)setup{
    [super setup];
     CGFloat titleInset = 5.0f;
     _titleInsets = UIEdgeInsetsMake(titleInset, titleInset, titleInset, titleInset);
}


-(void)loadView{
    [super loadView];
    [self loadContentView];
    [self loadTitleLabel];
    
    
}

-(void)loadTitleLabel{
    UIView *alertContentView = [[self alert] contentView];
    
    UILabel *titleLabel = [[DLAlertLabel alloc] initWithFrame:CGRectZero];
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [alertContentView addSubview:titleLabel];
    
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:titleLabel
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:alertContentView
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0f
                                                            constant:_titleInsets.top];
    
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:titleLabel
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationLessThanOrEqual
                                                              toItem:_contentView
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0f
                                                            constant:- _titleInsets.bottom];


    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:titleLabel
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:alertContentView
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0f
                                                                constant:_titleInsets.left];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:titleLabel
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:alertContentView
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0f
                                                                 constant: - _titleInsets.right];
    
    
    NSArray *constraints = @[top,bottom,leading,trailing];
    
    
    
    
    [alertContentView addConstraints:constraints];
    
    [self setTitleLabelInsetsConstraints:[NSDictionary dictionaryWithObjects:constraints forKeys:@[@(NSLayoutAttributeTop),
                                                                                                   @(NSLayoutAttributeBottom),
                                                                                                   @(NSLayoutAttributeLeading),
                                                                                                   @(NSLayoutAttributeTrailing)]]];
    [self setTitleLabel:titleLabel];
}

-(void)loadContentView{
    UIView *alertContentView = [[self alert] contentView];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [alertContentView addSubview:contentView];
    
    
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:contentView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:alertContentView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0f
                                                               constant:0.0f];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:contentView
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:alertContentView
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0f
                                                                constant:0.0f];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:contentView
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:alertContentView
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0f
                                                                 constant:0.0f];
    
    [alertContentView addConstraints:@[bottom,leading,trailing]];
    
    [self setContentView:contentView];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupTilteLabel];
}


-(UILabel *)loadContentViewLabel{
    UIView *contentView = [self contentView];
    
    UILabel *contentViewLabel = [[DLAlertLabel alloc] initWithFrame:CGRectZero];
    [contentViewLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [contentView addSubview:contentViewLabel];
    
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:contentViewLabel
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:contentView
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0f
                                                            constant:0.0f];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:contentViewLabel
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:contentView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0f
                                                               constant:0.0f];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:contentViewLabel
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:contentView
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0f
                                                                constant:0.0f];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:contentViewLabel
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:contentView
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0f
                                                                 constant:0.0f];
    
    [contentView addConstraints:@[top,bottom,leading,trailing]];
    
    return contentViewLabel;

}



-(void)setupTilteLabel{
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    [_titleLabel setText:_title];
    [_titleLabel setFont:_titleFont];
    [_titleLabel setTextColor:_titleTextColor];
}


#pragma mark TitleLabel configuration setters

-(void)setTitle:(NSString *)title{
    _title = title;
    if([self isViewLoaded]){
        [_titleLabel setText:title];
    }
}

-(void)setTitleTextColor:(UIColor *)titleTextColor{
    _titleTextColor = titleTextColor;
    if([self isViewLoaded]){
        [_titleLabel setTextColor:titleTextColor];
    }
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    if([self isViewLoaded]){
        [_titleLabel setFont:titleFont];
    }
}

-(void)setTitleInsets:(UIEdgeInsets)titleInsets{
    _titleInsets = titleInsets;
    if([self isViewLoaded]){
        [[_titleLabelInsetsConstraints objectForKey:@(NSLayoutAttributeTop)] setConstant:titleInsets.top];
        [[_titleLabelInsetsConstraints objectForKey:@(NSLayoutAttributeBottom)] setConstant: - titleInsets.bottom];
        [[_titleLabelInsetsConstraints objectForKey:@(NSLayoutAttributeLeading)] setConstant:titleInsets.left];
        [[_titleLabelInsetsConstraints objectForKey:@(NSLayoutAttributeTrailing)] setConstant: - titleInsets.right];
    }
}



@end


















































