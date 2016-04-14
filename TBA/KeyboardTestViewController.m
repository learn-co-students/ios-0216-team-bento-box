//
//  KeyboardTestViewController.m
//  TBA
//
//  Created by Bao Tran on 4/13/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "KeyboardTestViewController.h"

@interface KeyboardTestViewController ()

@property (nonatomic, weak) NSLayoutConstraint *textFieldBottomConstraint;

@end

CGFloat const TEXTFIELD_BOTTOM_CONSTANT = -10;

@implementation KeyboardTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textfield.translatesAutoresizingMaskIntoConstraints = NO;
    [self.textfield removeConstraints:self.textfield.constraints];
    self.textFieldBottomConstraint = [self.textfield.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:TEXTFIELD_BOTTOM_CONSTANT];
    self.textFieldBottomConstraint.active = YES;
    [self.textfield.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [self.textfield.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    self.textfield.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userinfo = notification.userInfo;
    NSValue *keyboardFrameValue = userinfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = keyboardFrameValue.CGRectValue;
    CGFloat keyboardHeight = keyboardFrame.size.height;
    NSNumber *duration = userinfo[UIKeyboardAnimationDurationUserInfoKey];
    
    [UIView animateWithDuration:[duration floatValue] animations:^{
        self.textFieldBottomConstraint.constant = -keyboardHeight;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userinfo = notification.userInfo;
//    NSValue *keyboardFrameValue = userinfo[UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardFrame = keyboardFrameValue.CGRectValue;
//    CGFloat keyboardHeight = keyboardFrame.size.height;
    NSNumber *duration = userinfo[UIKeyboardAnimationDurationUserInfoKey];
    
    [UIView animateWithDuration:[duration floatValue] animations:^{
        self.textFieldBottomConstraint.constant = TEXTFIELD_BOTTOM_CONSTANT;
    }];
}

- (IBAction)screenTapped:(id)sender {
    [self.view endEditing:YES];
//    self.textFieldBottomConstraint.constant = -10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
