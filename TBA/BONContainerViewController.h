//
//  BONContainerViewController.h
//  TBA
//
//  Created by christopher fleisher on 4/6/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BONContainerViewController : UIViewController
@property (nonatomic,strong)UIViewController *fromViewController;
-(void)submitButtonHit:(id)sender;
-(void)cycleFromViewController:(UIViewController *)oldVC toViewController:(UIViewController *)newVC;
-(void)displayContentController:(UIViewController *)contentController;

@end


