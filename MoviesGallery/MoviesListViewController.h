//
//  MoviesListViewController.h
//  MoviesGallery
//
//  Created by Jeffrey on 10/2/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helpers/MovieStore.h"
#import "Models/Movie.h"

@interface MoviesListViewController : UIViewController

@property (assign) MovieStore* movieStore;
@property (assign) Movie* selectedMovie;
@property (strong) NSArray* currentMovies;
@property (strong) NSArray* comingSoonMovies;

@property (strong, nonatomic) IBOutlet UITableView* tableView;

@end
