//
//  ViewController.m
//  MoviesGallery
//
//  Created by Jeffrey on 31/1/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import "ViewController.h"
#import "Models/Movie.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect frame = CGRectMake(0, 0, 200, 500); // Replacing with your dimensions
    UIView* v = [[UIView alloc] initWithFrame: frame];
    [v setBackgroundColor: [UIColor redColor]];
    [self.view addSubview: v];
    
    _movieStore = [MovieStore sharedInstance];
    
    [self fetchTopMovies];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchTopMovies {
    [_movieStore fetchTopMoviesWithCallback: ^(NSMutableArray* movies) {
    }];
}

@end
