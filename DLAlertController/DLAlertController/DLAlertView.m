//
// DLAlertView.m
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

#import "DLAlertView.h"
#import "DLActionsCollectionView.h"
#import "DLAlertLabel.h"
#import "DLAlertActionVisualStyle.h"

@interface DLAlertView ()
@property(strong,nonatomic,readwrite) NSMutableDictionary *separatorStyles;
@end


@implementation DLAlertView

+(instancetype)alertWithContentView:(UIView *)contentView{
    return [[self alloc] initWithContentView:contentView];
}

-(instancetype)initWithContentView:(UIView *)contentView{
    self = [super initWithFrame:CGRectZero];
    if(self != nil){
        _contentView = contentView;
        [self createUI];
    }
    return self;
}

-(void)createUI{
   _actionsCollectionView = [[DLActionsCollectionView alloc] init];
   _titleLabel = [[DLAlertLabel alloc] init];
   
}


-(void)prepareLayout{
    [self layoutUI];
}

-(void)layoutUI{
    [self layoutTitleLabel];
    [self layoutActionView];
    [self layoutContentView];
    
}

-(void)layoutTitleLabel{
    [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_titleLabel];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
    [self addConstraints:@[top,leading,trailing,centerX]];
}

-(void)layoutActionView{
    [_actionsCollectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_actionsCollectionView];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_actionsCollectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:_titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_actionsCollectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:_actionsCollectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:_actionsCollectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
    
    [self addConstraints:@[top,bottom,leading,trailing]];
}

-(void)layoutContentView{
    if(_contentView != nil){
        [_contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_contentView];
        
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_actionsCollectionView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
        NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
        
        [self addConstraints:@[top,bottom,leading,trailing]];
        
    }
}

@end
