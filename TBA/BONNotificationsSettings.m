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
@property (weak, nonatomic) IBOutlet UILabel *breakfastTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *lunchTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *dinnerTextLabel;

@end

@implementation BONNotificationsSettings

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setFontsStyle];
    [self setBackgroundAndEdits];
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

- (void)setBackgroundAndEdits {
    self.view.backgroundColor = [UIColor colorWithRed:127.0f/255.0f
                                                green:235.0f/255.0f
                                                 blue:197.0f/255.0f
                                                alpha:1.0f];
    
    UIColor *gradientMaskLayer = [UIColor colorWithRed:41.0f/255.0f
                                                 green:166.0f/255.0f
                                                  blue:122.0f/255.0f
                                                 alpha:1.0f];
    
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.frame = self.view.bounds;
    gradientMask.colors = @[(id)gradientMaskLayer.CGColor,
                            (id)[UIColor clearColor].CGColor];
    
    [self.view.layer insertSublayer:gradientMask atIndex:0];
}

- (void)setFontsStyle {

//    self.lunchNotifPicker.font = [UIFont fontWithName:@"Baskerville" size:20];
//    self.submitButton.titleLabel.font = [UIFont fontWithName:@"Baskerville" size:35];
//    self.backButton.titleLabel.font = [UIFont fontWithName:@"Baskerville" size:35];
    [self.lunchNotifPicker setValue:[UIColor colorWithRed:255.0f/255.0f
                                              green:254.0f/255.0f
                                               blue:245.0f/255.0f
                                              alpha:1.0f] forKey:@"textColor"];
    [self.dinnerNotifPicker setValue:[UIColor colorWithRed:255.0f/255.0f
                                                    green:254.0f/255.0f
                                                     blue:245.0f/255.0f
                                                    alpha:1.0f] forKey:@"textColor"];
    [self.breakfastNotifPicker setValue:[UIColor colorWithRed:255.0f/255.0f
                                                    green:254.0f/255.0f
                                                     blue:245.0f/255.0f
                                                    alpha:1.0f] forKey:@"textColor"];
    
}


@end

