//
//  BONWhereViewController.h
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/8/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BONGooglePlacesAPIClient.h"
#import "BONContainerViewController.h"

@interface BONWhereViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *searchResultsTableView;

@property (strong, nonatomic) HNKGooglePlacesAutocompleteQuery *searchQuery;
@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) UIAlertController *alertController;
@property (strong, nonatomic) BONContainerViewController *parentContainerViewController;

#pragma mark - Helper Methods

- (void)configureAndShowAlertController;

@end
