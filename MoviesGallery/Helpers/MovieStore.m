#import "MovieStore.H"
#import <ILMovieDBClient.h>
#import "../Models/Movie.h"

@implementation MovieStore

#define MOVIE_DB_API_KEY @"327b8d0c66c74e5eab2ebbec7b6ba4ce"
#define RESULT_KEY @"results"

#pragma mark Singleton Methods

+ (id)sharedInstance {
    static MovieStore *movieStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        movieStore = [[self alloc] init];
    });
    return movieStore;
}

- (id)init {
    if (self = [super init]) {
        [ILMovieDBClient sharedClient].apiKey = MOVIE_DB_API_KEY;
    }
    return self;
}

- (void)dealloc {
}

- (void)fetchTopMoviesWithCallback:(void(^)(id))callback {
    NSDictionary *params = @{
        @"page": @"1",
        @"language": @"en"
    };
    [[ILMovieDBClient sharedClient] GET:kILMovieDBMovieTopRated parameters:params block:^(id responseObject, NSError *error) {
        if (!error) {
            NSArray* movieJsonsArray = [responseObject objectForKey: RESULT_KEY];
            NSMutableArray* movies = [self adaptMovies: movieJsonsArray];
            callback(movies);
        }
    }];
}

-(void) fetchPopularMoviesWithCallback:(void(^)(id))callback {
    NSDictionary *params = @{
                             @"page": @"1",
                             @"language": @"en"
                             };
    [[ILMovieDBClient sharedClient] GET:kILMovieDBMoviePopular parameters:params block:^(id responseObject, NSError *error) {
        if (!error) {
            NSArray* movieJsonsArray = [responseObject objectForKey: RESULT_KEY];
            NSMutableArray* movies = [self adaptMovies: movieJsonsArray];
            callback(movies);
        }
    }];
}

-(void) fetchCurrentMoviesWithCallback:(void(^)(id))callback {
    NSDictionary *params = @{
                             @"page": @"1",
                             @"language": @"en"
                             };
    [[ILMovieDBClient sharedClient] GET:kILMovieDBMovieTheatres parameters:params block:^(id responseObject, NSError *error) {
        if (!error) {
            NSArray* movieJsonsArray = [responseObject objectForKey: RESULT_KEY];
            NSMutableArray* movies = [self adaptMovies: movieJsonsArray];
            callback(movies);
        }
    }];
}

-(void) fetchComingSoonMoviesWithCallback:(void(^)(id))callback {
    NSDictionary *params = @{
                             @"page": @"1",
                             @"language": @"en"
                             };
    [[ILMovieDBClient sharedClient] GET:kILMovieDBMovieUpcoming parameters:params block:^(id responseObject, NSError *error) {
        if (!error) {
            NSArray* movieJsonsArray = [responseObject objectForKey: RESULT_KEY];
            NSMutableArray* movies = [self adaptMovies: movieJsonsArray];
            callback(movies);
        }
    }];
}

- (NSMutableArray*)adaptMovies:(NSArray*) movieJsonsArray {
    NSMutableArray* movieObjectsArray = [[NSMutableArray alloc] init];
    [movieJsonsArray enumerateObjectsUsingBlock:^(id movieJson, NSUInteger idx, BOOL *stop) {
        NSLog(@"====%@", movieJson);
        Movie* movie = [[Movie alloc] initWithDictionary: movieJson];
        [movieObjectsArray addObject: movie];
    }];
    return movieObjectsArray;
}

@end