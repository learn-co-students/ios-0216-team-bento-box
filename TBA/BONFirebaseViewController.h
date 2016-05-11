//
//  BONFirebaseViewController.h
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/12/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BONFirebaseClient.h"
#import "BONContainerViewController.h"

@class BONFirebaseViewController;

@protocol BONFirebaseViewControllerDelegate <NSObject>

@required

- (void)didLoginUserWithFirebaseViewController:(BONFirebaseViewController *)firebaseViewController;

@end

@interface BONFirebaseViewController : UIViewController

@property (weak, nonatomic) id<BONFirebaseViewControllerDelegate> delegate;
@property (strong, nonatomic) BONFirebaseClient *firebaseClient;

@end
