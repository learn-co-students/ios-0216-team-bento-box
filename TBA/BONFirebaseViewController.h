//
//  BONFirebaseViewController.h
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/12/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BONFirebaseClient.h"

@interface BONFirebaseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *mealDateTextField;

@property (strong, nonatomic) BONFirebaseClient *firebaseClient;

#pragma mark - Firebase Helper Methods

@end
