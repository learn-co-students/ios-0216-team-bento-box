//
//  BONHistoryTableViewController.h
//  
//
//  Created by Daniel Adeyanju on 4/19/16.
//
//

#import <UIKit/UIKit.h>
#import "BONFirebaseClient.h"

@interface BONHistoryTableViewController : UITableViewController

@property (strong, nonatomic) BONDataStore *sharedDataStore;
@property (strong, nonatomic) BONFirebaseClient *sharedFirebaseClient;

@end
