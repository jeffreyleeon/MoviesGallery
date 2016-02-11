//
//  ViewController.h
//  MoviesGallery
//
//  Created by Jeffrey on 31/1/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SwipeView/SwipeView.h>
#import "Helpers/MovieStore.h"
#import "Models/Movie.h"

@interface ViewController : UIViewController <
    SwipeViewDataSource,
    SwipeViewDelegate
>

@property (assign) MovieStore* movieStore;
@property (strong) NSArray<Movie*>* popularMovies;
@property (assign) Movie* selectedMovie;

@property (strong, nonatomic) IBOutlet SwipeView* swipeView;

// SwipeView delegates
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *) swipeView;
- (UIView *)swipeView:(SwipeView *) swipeView viewForItemAtIndex:(NSInteger) index reusingView:(UIView *) view;
- (CGSize)swipeViewItemSize:(SwipeView *) swipeView;

@end

