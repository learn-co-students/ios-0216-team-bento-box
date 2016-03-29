//
//  BONMeal.m
//  TBA
//
//  Created by Bao Tran on 3/29/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONMeal.h"

@implementation BONMeal

+(instancetype)sharedDataStore {
    static BONMeal *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[BONMeal alloc]init];
    });
    return _sharedDataStore;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        _whatWasEaten = nil;
        _whereWasItEaten = nil;
        _whenWasItEaten = nil;
        _howUserFelt = nil;
    }
    return self;
}


@end
