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
    UIImage *bg = [UIImage imageNamed:@"confettibg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bg];
    [self.view setOpaque:NO];
    [[self.view layer] setOpaque:NO];
    
}

-(void)setBreakfastNotification:(NSDate *)date {
    [self deleteNotification
     :@"breakfast"];
    UILocalNotification * breakfastNotif = [[UILocalNotification alloc] init];
    [breakfastNotif setAlertBody:@"It's around breakfast time, log your meal!"];
   
    NSCalendar * myCal = [NSCalendar currentCalendar];
    NSDateComponents * breakfastTime = [myCal components:NSCalendarUnitHour| NSCalendarUnitMinute fromDate:date];
    breakfastNotif.repeatInterval = NSCalendarUnitWeekday;
    NSDate * breakfastTimeFromComponents = [myCal dateFromComponents:breakfastTime];
    [breakfastNotif setFireDate: breakfastTimeFromComponents];
    [breakfastNotif.userInfo setValue:@"breakfast" forKey:@"uid"];
    
    
    
    [[UIApplication sharedApplication] scheduleLocalNotification:breakfastNotif];

    
}


-(void)setMealType:(NSString *)  mealType Notification:(NSDate *)date {
    [self deleteNotification:mealType];
    UILocalNotification * breakfastNotif = [[UILocalNotification alloc] init];
  
   
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:mealType forKey:@"uid"];
    breakfastNotif.userInfo = userInfo;
   // NSLog(@"%@ Notifications dictionary%@", mealType, breakfastNotif.userInfo);
    NSString * alertBody = [NSString stringWithFormat: @"It's around %@ time, log your meal!", mealType];
    [breakfastNotif setAlertBody:alertBody];
    
    NSCalendar * myCal = [NSCalendar currentCalendar];
    NSDateComponents * breakfastTime = [myCal components:NSCalendarUnitHour| NSCalendarUnitMinute fromDate:date];
    breakfastNotif.repeatInterval = NSCalendarUnitWeekday;
    NSDate * breakfastTimeFromComponents = [myCal dateFromComponents:breakfastTime];
    [breakfastNotif setFireDate: breakfastTimeFromComponents];

    
    
    
    [[UIApplication sharedApplication] scheduleLocalNotification:breakfastNotif];
    
    
}


//helper method for setNotification, deletes existing notification for mealtype
-(void)deleteNotification: (NSString *) uidtodelete {
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    
    NSLog(@"%@", eventArray);
    
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = oneEvent.userInfo;
        NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"uid"]];
        if ([uid isEqualToString:uidtodelete])
        {
            //Cancelling local notification
            NSLog(@"notification found");
            [app cancelLocalNotification:oneEvent];
            break;
        }
    }
}
- (IBAction)submit:(id)sender {
    
    NSDate * breakfastTimePicked = self.breakfastNotifPicker.date;
    NSDate * lunchTimePicked = self.lunchNotifPicker.date;
    NSDate * dinnerTimePicked = self.dinnerNotifPicker.date;
    
    
    [self setMealType:@"breakfast" Notification:breakfastTimePicked];
    [self setMealType:@"lunch" Notification:lunchTimePicked];
    [self setMealType:@"dinner" Notification:dinnerTimePicked];
    
       [[NSNotificationCenter defaultCenter] postNotificationName:@"submitButtonHit" object:self];

}
- (IBAction)backButton:(id)sender {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"backButtonHit" object:self];
}
@end

