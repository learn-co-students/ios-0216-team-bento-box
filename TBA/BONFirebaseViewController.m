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
    // Do any additional setup after loading the view.
    self.firebaseClient = [BONFirebaseClient new];
    [self.firebaseClient configureFirebase];
    
    if (self.firebaseClient.rootReference.authData)
    {
        NSLog(@"user is logged in! uid:%@", self.firebaseClient.rootReference.authData.uid);
        // user is logged in
    } else {
        // user is not logged in
        NSLog(@"user is not logged in");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addUserTapped:(id)sender {
    
    NSString *newUser = self.emailTextField.text;
    NSString *newUserPW = self.passwordTextField.text;
    
//    Firebase *test = [[Firebase alloc] init];
//    
//    Firebase *usersReference = [self.firebaseClient.rootReference childByAppendingPath:@"Users"];
//    
//    
//    NSInteger  rand = arc4random();
//    NSString *randString = [NSString stringWithFormat:@"%li", rand];
//    Firebase *userReference = [usersReference childByAppendingPath:randString ];
//    [userReference setValue:@{@"email":newUser, @"password": @"lol"}];
//    
////    Firebase *baoReference = [userReference childByAppendingPath:@"bao"];
////    [baoReference setValue:@"lol"];
//    
//    //add a meal
//
//    Firebase *mealReference = [userReference childByAppendingPath:@"Meals"];
//    [mealReference setValue: @{@"Mea1": @"Blah"} ];
    

    [self.firebaseClient.rootReference createUser:newUser password:newUserPW
withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
    if (error) {
        NSLog(@"Error msg: %@", error.description);
    } else {
        NSString *uid = [result objectForKey:@"uid"];
        NSLog(@"Successfully created user account with uid: %@", uid);
    }
}];
    
    
}
- (IBAction)loginTapped:(id)sender {
    
    NSString *newUser = self.emailTextField.text;
    NSString *newUserPW = self.passwordTextField.text;
    
    [self.firebaseClient.rootReference  authUser: newUser password:newUserPW
withCompletionBlock:^(NSError *error, FAuthData *authData) {
    if (error) {
        NSLog(@"Error msg: %@", error.description);
    } else {
        NSLog(@"Logged in! Heres the UID: %@", [authData uid]);
        
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
