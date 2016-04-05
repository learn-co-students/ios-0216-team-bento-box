//
//  BONMeal.h
//  TBA
//
//  Created by Bao Tran on 3/29/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BONMeal : NSObject

@property (strong, nonatomic) NSString *whatWasEaten;
@property (strong, nonatomic) NSString *whereWasItEaten;
@property (strong, nonatomic) NSString *whenWasItEaten;
@property (strong, nonatomic) NSString *howUserFelt;

-(instancetype)init;

+(instancetype)sharedDataStore;

@end
