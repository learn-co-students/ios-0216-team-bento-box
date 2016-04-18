//
//  BONFirebaseViewController.m
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/12/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONFirebaseViewController.h"

@interface BONFirebaseViewController ()

@end

@implementation BONFirebaseViewController

- (void)viewDidLoad {
    
    NSLog(@"Firebase View Controller View Did Load");
    
    [super viewDidLoad];
    self.sharedFireBaseClient = [BONFirebaseClient sharedFirebaseClient];
    
    [self.sharedFireBaseClient configureFirebase];
}

- (IBAction)newUserSignUpTapped:(id)sender {
    
    [self.sharedFireBaseClient createNewUserInFirebaseWithEmail:self.emailTextField.text
                                                       Password:self.passwordTextField.text];
    
    [self loginTapped:nil];
}

- (IBAction)loginTapped:(id)sender {
    
    [self.sharedFireBaseClient loginUserInFirebaseWithEmail:self.emailTextField.text
                                                   Password:self.passwordTextField.text];
}
//
//    NSString *mealDate = self.emailTextField.text;
//    
//    Firebase *usersReference = [self.sharedFireBaseClient.rootReference childByAppendingPath:@"Users"];
//    
//    Firebase *currentUserReference = [usersReference childByAppendingPath:@"01672075-b1d5-4477-b36f-fc53f6f8e5d7"];
//    
//    Firebase *mealReference = [currentUserReference childByAppendingPath:mealDate];
//    
//    [mealReference setValue:self.sharedFireBaseClient.mealProperties];
    
//    
//    
//    NSString *userEmail = self.emailTextField.text;
//    NSString *userPassword = self.passwordTextField.text;
//    
//    [self.sharedFireBaseClient.rootReference  authUser:userEmail
//                                              password:userPassword
//                                   withCompletionBlock:^(NSError *error, FAuthData *authData) {
//        if (error) {
//            NSLog(@"Login Failed: %@", error.description);
//            
//        } else {
//            NSLog(@"Logged in, UID: %@", authData.uid);
//
//            BONContainerViewController *containerVC = [BONContainerViewController new];
//            [self presentViewController:containerVC animated:YES completion:nil];
//        }
//    }];
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end