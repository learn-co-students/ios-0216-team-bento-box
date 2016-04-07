//
//  BONFoursquareAPIClient.m
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/7/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONFoursquareAPIClient.h"

@implementation BONFoursquareAPIClient

+ (void)searchForVenue:(NSString *)venueName withCompletion:(void (^)(NSDictionary *))completionBlock {
    
    NSString *foursquareSearchURL = [NSString stringWithFormat:@"%@%@", foursquareAPIBaseURL, venueName];
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:foursquareSearchURL
             parameters:nil
               progress:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    completionBlock(responseObject);
                }
                failure:^(NSURLSessionDataTask *task, NSError * error) {
                    NSLog(@"Something went wrong with the API call");
                    NSLog(@"Error: %@", error);
                }];
}

@end
