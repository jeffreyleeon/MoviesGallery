#import "MovieStore.H"
#import <ILMovieDBClient.h>

@implementation MovieStore

#define MOVIE_DB_API_KEY @"327b8d0c66c74e5eab2ebbec7b6ba4ce"

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

- (void)fetchTopMovies {
    NSDictionary *params = @{
        @"page": @"1",
        @"language": @"en"
    };
    [[ILMovieDBClient sharedClient] GET:kILMovieDBMovieTopRated parameters:params block:^(id responseObject, NSError *error) {
        if (!error) {
            NSLog(@"%@", responseObject);
        }
    }];
}

@end