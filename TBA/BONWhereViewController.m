//
//  BONWhereViewController.m
//  TBA
//
//  Created by Ariel Scott-Dicker on 4/8/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "BONWhereViewController.h"

@interface BONWhereViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation BONWhereViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    self.searchResultsTableView.delegate = self;
    self.searchResultsTableView.dataSource = self;
    
    self.searchQuery = [HNKGooglePlacesAutocompleteQuery sharedQuery];
}

#pragma mark - SearchBar Delegate

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length > 0)
    {
        [self.searchResultsTableView setHidden:NO];
        
        [self.searchQuery fetchPlacesForSearchQuery: searchText
                                         completion:^(NSArray *places, NSError *error) {
                                             if (error) {
                                                 NSLog(@"ERROR: %@", error);
                                             } else {
                                                 self.searchResults = places;
                                                 [self.searchResultsTableView reloadData];
                                             }
                                         }];
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO
                           animated:YES];
    [searchBar resignFirstResponder];
    [self.searchResultsTableView setHidden:YES];
}

#pragma mark - TableView Data Source And Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchResultCellIdentifier"
                                                            forIndexPath:indexPath];
    
    HNKGooglePlacesAutocompletePlace *placeAtRow = self.searchResults[indexPath.row];
    cell.textLabel.text = placeAtRow.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.searchBar setShowsCancelButton:NO
                                animated:YES];
    [self.searchBar resignFirstResponder];
    
    HNKGooglePlacesAutocompletePlace *placeAtSelectedRow = self.searchResults[indexPath.row];
    
    NSLog(@"Tapped Place: %@", placeAtSelectedRow.name);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
