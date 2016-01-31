#import "MovieStore.H"

@implementation MovieStore

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
    }
    return self;
}

- (void)dealloc {
}

- (void) fetchTopMovies {
    
}

@end