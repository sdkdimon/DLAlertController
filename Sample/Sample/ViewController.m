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
#import "DLAlertMessageController.h"




@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlertController:(UIButton *)sender {
    DLAlertMessageController *alert = [[DLAlertMessageController alloc] init];
    [alert setDismissableOnActionTap:YES];
    [alert setDismssAnimationEnabled:YES];
    [alert setTitle:@"Message"];
    
    [alert setMessage:@"Message"];
    //[alert setTitle:@"Title"];
    [alert setActionHeight:44];
    

    
    //[alert setTitleInsets:UIEdgeInsetsMake(20, 10, 20, 10)];
   // [alert setTitleTextColor:[UIColor purpleColor]];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [alert setTitleTextColor:[UIColor purpleColor]];
//        [alert setTitleInsets:UIEdgeInsetsMake(20, 10, 20, 10)];
//        [alert setActionHeight:360];
//    });
    
    
    
    
    [alert addAction:[DLAlertAction actionWithTitle:@"Cancel" style:DLAlertActionStyleCancel handler:^{
        NSLog(@"%@ tapped ",@"Cancel");
    }]];
    
    DLAlertAction *action = [DLAlertAction actionWithTitle:@"Ok" style:DLAlertActionStyleDefault handler:^{
        NSLog(@"%@ tapped ",@"Ok");
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [action setEnabled:NO];
    });
    
    
    [alert addAction:action];
//
//    [alert addAction:[DLAlertAction actionWithTitle:@"Delete" style:DLAlertActionStyleDestructive handler:^{
//        NSLog(@"%@ tapped ",@"Delete");
//    }]];
    
//    [alert setTitle:@"Hello this is alert"];
    
    [alert presentAnimated:YES completion:nil];
}
@end
