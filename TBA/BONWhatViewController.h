//
//  ViewController.h
//  pg
//
//  Created by Daniel Adeyanju on 4/10/16.
//  Copyright © 2016 Daniel Adeyanju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BONWhatViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *mealTypePicker;

@property (strong, nonatomic) NSArray *mealTypes;
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
@end

