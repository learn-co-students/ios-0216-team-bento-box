//
//  BONLoginViewController.m
//  TBA
//
//  Created by christopher fleisher on 4/6/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONLoginViewController.h"

@interface BONLoginViewController ()
@property (nonatomic,strong)UIButton *loginButton;

@end

@implementation BONLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildLoginButton];
    
}

-(void)buildLoginButton{
    UIButton *loginButton = [[UIButton alloc] init];
    loginButton.backgroundColor = [UIColor redColor];
    [loginButton setTitle:@"I'm HANGRY" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [loginButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:200].active = YES;
    [loginButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [loginButton.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.05].active = YES;
    self.loginButton = loginButton;
}

-(void)loginButtonTouched:(UIButton *)loginButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:self];
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
