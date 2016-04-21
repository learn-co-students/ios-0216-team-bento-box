//
//  ViewController.h
//  pg
//
//  Created by Daniel Adeyanju on 4/10/16.
//  Copyright © 2016 Daniel Adeyanju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BONDataStore.h"
#import "BONFirebaseClient.h"

@interface BONWhatViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *answerText;
@property (strong, nonatomic) BONDataStore *sharedDataStore;
@property (strong, nonatomic) BONFirebaseClient *sharedFirebaseClient;

@end

