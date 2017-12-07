//
//  DPVerificationAlertController.h
//  DiPocket
//
//  Created by dimon on 01/02/16.
//  Copyright © 2016 @m5.+3rd4m. All rights reserved.
//

#import <DLAlertController/DLAlertActionController.h>

//AbstractClass
@interface DPAlertInputController : DLAlertActionController

@property(assign,nonatomic,readwrite) UIEdgeInsets contentControlsInsets;
@property(assign,nonatomic,readwrite) UIEdgeInsets textFieldInsets;

@property(strong,nonatomic,readonly) UITextField *textField;
@property(strong,nonatomic,readonly) UILabel *messageLabel;
@property(strong,nonatomic,readwrite) NSString *message;

@property (copy, nonatomic, readwrite) void (^viewDidLoadBlodk)(DPAlertInputController *);

//Override to do additional controls setup;
- (void)setupMessageLabel;
- (void)setupTextField;



@end
