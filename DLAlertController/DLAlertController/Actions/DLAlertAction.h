//
// DLAlertViewAction.h
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

#import <Foundation/Foundation.h>

#import <DLAlertController/DLAlertActionStyle.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title style:(DLAlertActionStyle)style handler:(void(^)(void))handler;
- (instancetype)initWithTitle:(NSString *)title style:(DLAlertActionStyle)style handler:(void(^)(void))handler;

@property(copy,nonatomic,readwrite) NSString *title;
@property(assign,nonatomic,readonly) DLAlertActionStyle style;
@property(copy,nonatomic,readonly) void(^handler)(void);
@property(assign,nonatomic,readwrite,getter=isEnabled) BOOL enabled;

@end

NS_ASSUME_NONNULL_END
