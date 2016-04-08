//
//  BONWhereViewController.h
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/8/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BONGooglePlacesAPIClient.h"

@interface BONWhereViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *searchResultsTableView;

@property (strong, nonatomic) HNKGooglePlacesAutocompleteQuery *searchQuery;
@property (strong, nonatomic) NSArray *searchResults;

@end
