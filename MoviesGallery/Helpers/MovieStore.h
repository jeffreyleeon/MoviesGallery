#import <foundation/Foundation.h>

@interface MovieStore : NSObject

+(id) sharedInstance;

-(void) fetchTopMovies;

@end