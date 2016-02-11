//
//  MovieDetailsViewController.h
//  MoviesGallery
//
//  Created by Jeffrey on 11/2/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Models/Movie.h"
#import "Helpers/MovieStore.h"

@interface MovieDetailsViewController : UIViewController

@property (assign) Movie* movie;
@property (assign) MovieStore* movieStore;

- (void)setMovie:(Movie*) movie;

@end
