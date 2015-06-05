//
//  LoadImageAsync.m
//  SimpleTable
//
//  Created by Rishabh Jain on 6/5/15.
//  Copyright (c) 2015 Rishabh Jain. All rights reserved.
//

#import "LoadImageAsync.h"
#import "ViewController.h"

@implementation LoadImageAsync{
    int index;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
    
    }
    return self;
}

- (id)initWithDelegate:(id<LoadImageAsyncDelegate>) delegatedItem{
    
    self = [super init];
    if (self) {
        _delegate = delegatedItem;
    }
    
    //NSLog(@"%@", self);
    return self;
}

- (void)testMethod{
}


#pragma mark - LoadImageAsyncFromURL Method
- (void)loadImageAsyncFromURL:(NSURL *)url atIndex:(int)i {
    
    index = i;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:90.0];
    
    if (connection) {
        [connection cancel];
        connection = nil;
        data = nil;
    }
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

#pragma mark - NSURLConnection Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [data setLength:0];
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData{
    if (data == nil) {
        data = [[NSMutableData alloc] init];
    }
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection{
    UIImage *image = [UIImage imageWithData:data];
    if (image) {
        self.image = image;
    }
    
    [_delegate imageFinishedDownloading:index image:self.image];
    data = nil;
    connection = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Connection Failed: %@", [error description]);
}

@end
