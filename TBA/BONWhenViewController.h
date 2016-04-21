//
//  ViewController.h
//  pg
//
//  Created by Daniel Adeyanju on 4/10/16.
//  Copyright © 2016 Daniel Adeyanju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BONFirebaseClient.h"
#import "BONDataStore.h"

@interface BONWhenViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *mealTypePicker;

@property (strong, nonatomic) BONFirebaseClient *sharedFirebaseClient;
@property (strong, nonatomic) BONDataStore *sharedDataStore;

@property (strong, nonatomic) NSArray *mealTypes;
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
@end

