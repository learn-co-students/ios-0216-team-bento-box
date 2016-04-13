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
    [super viewDidLoad];
    self.firebaseClient = [BONFirebaseClient new];
    [self.firebaseClient configureFirebase];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)addUserTapped:(id)sender {
    
    NSString *newUser = self.emailTextField.text;
    NSString *newUserPW = self.passwordTextField.text;

    [self.firebaseClient.rootReference createUser:newUser password:newUserPW
                         withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        if (error) {
            
            NSLog(@"User not created:%@", error.description);
            
        } else {
            
            NSLog(@"Successfully created user account with uid: %@", [result objectForKey:@"uid"]);
            
     
            Firebase * currentUserRef = [[self.firebaseClient.rootReference childByAppendingPath:@"Users"] childByAppendingPath:[result objectForKey:@"uid"]];
            [currentUserRef setValue:@{@"Meals":@{@"Meal1":@"Info", @"Meal2":@"Info"}} ];
            
            Firebase * currentUserMealRef  = [[currentUserRef childByAppendingPath:@"Meals"] childByAppendingPath:[NSString stringWithFormat:@"%i", arc4random()]];
            [currentUserMealRef setValue:@{@"When":@"Now", @"How":@"Good"}];
            [self loginTapped:nil];
            
        }
    }];
    
}
- (IBAction)loginTapped:(id)sender {
    
    NSString *user = self.emailTextField.text;
    NSString *userPW = self.passwordTextField.text;
    
    [self.firebaseClient.rootReference  authUser: user password:userPW
                             withCompletionBlock:^(NSError *error, FAuthData *authData) {
        if (error) {
            NSLog(@"Login Failed: %@", error.description);
            
        } else {
            NSLog(@"Logged in, UID: %@", [authData uid]);

            BONContainerViewController *containerVC = [[BONContainerViewController alloc] init];
            [self presentViewController:containerVC animated:YES completion:nil];
            
        }
    }];
    
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