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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addUserTapped:(id)sender {
    
//    NSString *newUser = self.emailTextField.text;
//    
//    Firebase *test = [[Firebase alloc] init]
//    
////    Firebase *usersReference = [self.firebaseClient.rootReference childByAppendingPath:@"Users"];
//    Firebase *userReference = [usersReference childByAppendingPath:@"User Name Goes Here"];
//    [userReference setValue:@{newUser : self.firebaseClient.userID}];
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
