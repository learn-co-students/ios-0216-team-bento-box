//
//  BONNotificationsSettings.m
//  pg
//
//  Created by Daniel Adeyanju on 4/11/16.
//  Copyright © 2016 Daniel Adeyanju. All rights reserved.
//

#import "BONNotificationsSettings.h"
@interface BONNotificationsSettings()
@property (weak, nonatomic) IBOutlet UIDatePicker *breakfastNotifPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *lunchNotifPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *dinnerNotifPicker;

@end

@implementation BONNotificationsSettings

-(void)viewDidLoad{
    [super viewDidLoad];
    
}

-(void)setBreakfastNotification:(NSDate *)date {
    UILocalNotification * breakfastNotif = [[UILocalNotification alloc] init];
    [breakfastNotif setAlertBody:@"It's around breakfast time, log your meal!"];
   
    NSCalendar * myCal = [NSCalendar currentCalendar];
    NSDateComponents * breakfastTime = [myCal components:NSCalendarUnitHour| NSCalendarUnitMinute fromDate:date];
    breakfastNotif.repeatInterval = NSCalendarUnitWeekday;
    NSDate * breakfastTimeFromComponents = [myCal dateFromComponents:breakfastTime];
    [breakfastNotif setFireDate: breakfastTimeFromComponents];
    
    
    
    [[UIApplication sharedApplication] scheduleLocalNotification:breakfastNotif];

    
}
- (IBAction)submit:(id)sender {
    
    NSDate * breakfastTimePicked = self.breakfastNotifPicker.date;
    
    [self setBreakfastNotification:breakfastTimePicked];
}
@end

