//
//  MovieDetailsViewController.h
//  MoviesGallery
//
//  Created by Jeffrey on 11/2/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCDYouTubeKit/XCDYouTubeKit.h>
#import "Models/Movie.h"
#import "Helpers/MovieStore.h"

@interface MovieDetailsViewController : UIViewController

@property (assign) Movie* movie;
@property (assign) MovieStore* movieStore;
@property (strong) NSArray<NSString*>* trailerIdsArray;
@property (strong, nonatomic) UIView* playerView;
@property (assign) float accumulatedHeight;
@property (strong) XCDYouTubeVideoPlayerViewController* videoPlayerViewController;

@property (weak, nonatomic) IBOutlet UIScrollView* scrollView;

- (void)setMovie:(Movie*) movie;

@end
