//
//  BONFirebaseViewController.m
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/12/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONFirebaseViewController.h"

@interface BONFirebaseViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UIButton *addUserButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end



@implementation BONFirebaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAddUserButton];
    [self loadLoginButton];
    [self loadPasswordTextField];
    [self loadEmailTextField];
    [self loadUserNameTextField];
    
    self.firebaseClient = [BONFirebaseClient new];
    [self.firebaseClient configureFirebase];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (IBAction)addUserTapped:(id)sender {
    
    [self.firebaseClient createNewUserInFirebaseWithEmail:self.emailTextField.text
                                                 Password:self.passwordTextField.text
                                       FromViewController:self];
}
- (IBAction)loginTapped:(id)sender {
    
    NSLog(@"Log in button tapped");
    
    [self.firebaseClient loginUserInFirebaseWithEmail:self.emailTextField.text
                                             Password:self.passwordTextField.text
                                   FromViewController:self];
    
    NSLog(@"User id: %@", self.firebaseClient.rootReference.authData.uid);
}

#pragma mark - UIButtons and UITextfields constraints

-(void)loadAddUserButton {
    self.addUserButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.addUserButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-250].active = YES;
    [self.addUserButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:.25].active = YES;
    [self.addUserButton.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:.05].active = YES;
    [self.addUserButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    [self.addUserButton.layer setBorderWidth:1];
    [self.addUserButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
}

-(void)loadLoginButton {
    self.loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.loginButton.bottomAnchor constraintEqualToAnchor:self.addUserButton.topAnchor constant:-25].active = YES;
    [self.loginButton.widthAnchor constraintEqualToAnchor:self.addUserButton.widthAnchor ].active = YES;
    [self.loginButton.heightAnchor constraintEqualToAnchor:self.addUserButton.heightAnchor ].active = YES;
    [self.loginButton.centerXAnchor constraintEqualToAnchor:self.addUserButton.centerXAnchor ].active = YES;
    
    [self.loginButton.layer setBorderWidth:1];
    [self.loginButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
}

-(void)loadPasswordTextField {
    self.passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.passwordTextField.bottomAnchor constraintEqualToAnchor:self.loginButton.topAnchor constant:-25].active = YES;
    [self.passwordTextField.widthAnchor constraintEqualToAnchor:self.addUserButton.widthAnchor multiplier:2].active = YES;
    [self.passwordTextField.heightAnchor constraintEqualToAnchor:self.loginButton.heightAnchor].active = YES;
    [self.passwordTextField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    [self.passwordTextField.layer setBorderWidth:1];
    [self.passwordTextField.layer setBorderColor:[[UIColor blackColor] CGColor]];
}

-(void)loadEmailTextField {
    self.emailTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.emailTextField.bottomAnchor constraintEqualToAnchor:self.passwordTextField.topAnchor constant:-25].active = YES;
    [self.emailTextField.widthAnchor constraintEqualToAnchor:self.passwordTextField.widthAnchor].active = YES;
    [self.emailTextField.heightAnchor constraintEqualToAnchor:self.loginButton.heightAnchor].active = YES;
    [self.emailTextField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    [self.emailTextField.layer setBorderWidth:1];
    [self.emailTextField.layer setBorderColor:[[UIColor blackColor] CGColor]];
}

-(void)loadUserNameTextField {
    self.userName.translatesAutoresizingMaskIntoConstraints = NO;
    [self.userName.bottomAnchor constraintEqualToAnchor:self.emailTextField.topAnchor constant:-25].active = YES;
    [self.userName.widthAnchor constraintEqualToAnchor:self.emailTextField.widthAnchor].active = YES;
    [self.userName.heightAnchor constraintEqualToAnchor:self.loginButton.heightAnchor].active = YES;
    [self.userName.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    [self.userName.layer setBorderWidth:1];
    [self.userName.layer setBorderColor:[[UIColor blackColor] CGColor]];
}

#pragma mark - Tap gestures

-(void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}

//-(void)keyboardWillShow:(NSNotification *)notification {
//    NSDictionary *userinfo = notification.userInfo;
//    
//    NSNumber *duration = userinfo[UIKeyboardAnimationDurationUserInfoKey];
//    NSValue *keyboardFrameValue = userinfo[UIKeyboardFrameEndUserInfoKey];
//    
//    CGRect keyboardFrame = keyboardFrameValue.CGRectValue;
//    CGFloat keyboardHeight = keyboardFrame.size.height;
//    
//    [UIView animateWithDuration:[duration floatValue] animations:^{
////        self.loginButtonConstraint.constant = -keyboardHeight;
//    }];
//}

-(void)keyboardWillHide:(NSNotification *)notification {
// need to add default constraints
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