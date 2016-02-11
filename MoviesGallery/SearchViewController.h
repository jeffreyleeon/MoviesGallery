//
//  SearchViewController.h
//  MoviesGallery
//
//  Created by Jeffrey on 11/2/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helpers/MovieStore.h"
#import "Models/Movie.h"

@interface SearchViewController : UIViewController

@property (strong) NSArray* searchedMovies;
@property (assign) MovieStore* movieStore;

@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;
@property (weak, nonatomic) IBOutlet UITableView* tableView;

@end
