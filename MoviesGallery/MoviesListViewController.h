//
//  MoviesListViewController.h
//  MoviesGallery
//
//  Created by Jeffrey on 10/2/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helpers/MovieStore.h"

@interface MoviesListViewController : UIViewController

@property (assign) MovieStore* movieStore;
@property (strong) NSArray* currentMovies;
@property (strong) NSArray* comingSoonMovies;

@property (strong, nonatomic) IBOutlet UITableView* tableView;

@end
