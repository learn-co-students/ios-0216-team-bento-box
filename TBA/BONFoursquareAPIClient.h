//
//  BONFoursquareAPIClient.h
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/7/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoursquareAPIClientConstants.h"
#import <AFNetworking/AFNetworking.h>

@interface BONFoursquareAPIClient : NSObject

+ (void)searchForVenue:(NSString *)venueName
        withCompletion:(void (^)(NSDictionary *venues))completionBlock;

@end
