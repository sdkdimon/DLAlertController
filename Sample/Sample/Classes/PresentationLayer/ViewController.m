//
// ViewController.m
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

#import "ViewController.h"

#import <DLAlertController/DLAlertController.h>
#import "AlertInputController.h"

@interface TestViewController : UIViewController

@end

@implementation TestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self loadSubviews];
}

- (void)loadSubviews
{
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismissButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:dismissButton
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0f
                                                                constant:.0f];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:dismissButton
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0f
                                                                constant:.0f];
    [self.view addConstraints:@[centerX, centerY]];
    
    
}

- (void)dismissButtonTap:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSubviews];
    [self setupTableView];
}

- (void)loadSubviews
{
    UIView *view = self.view;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView = tableView;
    
    [view addSubview:tableView];
    
    id topItem = view;
    id bottomItem = view;
    
//    if (@available(iOS 11.0, *))
//    {
//        topItem =  view.safeAreaLayoutGuide.topAnchor;
//        bottomItem = view.safeAreaLayoutGuide.bottomAnchor;
//    }
//    else
//    {
//        topItem = self.topLayoutGuide;
//        bottomItem = self.bottomLayoutGuide;
//    }
    
    
    
    NSLayoutConstraint *top =
    [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:topItem attribute:NSLayoutAttributeTop multiplier:1.0f constant:.0f];
    NSLayoutConstraint *bottom =
    [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeBottom  relatedBy:NSLayoutRelationEqual toItem:bottomItem attribute:NSLayoutAttributeBottom multiplier:1.0f constant:.0f];
    NSLayoutConstraint *leading =
    [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:.0f];
    NSLayoutConstraint *trailing =
    [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:.0f];
    
    [view addConstraints:@[top, bottom, leading, trailing]];
    
}

- (void)setupTableView
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"Input Alert";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (indexPath.row == 0)
        {
          [self showInputAlert];
        }
        else
        {
            TestViewController *tv = [[TestViewController alloc] init];
            [self presentViewController:tv animated:YES completion:NULL];
        }
        
    });
}

- (void)showInputAlert
{
    AlertInputController *alert = [[AlertInputController alloc] init];
    
    [alert setDismissableOnActionTap:YES];
    [alert setDismssAnimationEnabled:YES];
    [alert setTitle:@"Message"];
    [alert setMessage:@"Message"];

    [alert setActionHeight:44];
    [alert setAlertMinHeight:100];
    
    DLAlertAction *action = [DLAlertAction actionWithTitle:@"AAAA" style:DLAlertActionStyleCancel handler:^{
        
    }];
    
    DLAlertAction *action2 = [DLAlertAction actionWithTitle:@"BBB" style:DLAlertActionStyleCancel handler:^{
        
    }];
    
    [alert view];
    [alert addAction:action];
    [alert addAction:action2];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert removeAction:action];
        DLAlertAction *action3 = [DLAlertAction actionWithTitle:@"CCC" style:DLAlertActionStyleCancel handler:^{
            
        }];
        [alert insertAction:action3 atIndex:0];
    });
   
    //[alert presentAnimated:YES completion:nil];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
    NSLog(@"viewWillAppearAnimated %@", animated ? @"YES" : @"NO");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppearAnimated %@", animated ? @"YES" : @"NO");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappearAnimated %@", animated ? @"YES" : @"NO");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappearAnimated %@", animated ? @"YES" : @"NO");
}

@end
