//
//  LoadImageAsync.m
//  SimpleTable
//
//  Created by Rishabh Jain on 6/5/15.
//  Copyright (c) 2015 Rishabh Jain. All rights reserved.
//

#import "LoadImageAsync.h"
#import "ViewController.h"
#import "AFNetworking.h"

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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFHTTPRequestOperation *operation = [manager GET:[url absoluteString]
                                          parameters:nil
                                             success:^(AFHTTPRequestOperation *operation, NSData *responseData)
                                         {
                                             NSLog(@"Success");
                                             UIImage *image = [UIImage imageWithData: responseData];
                                             if (image) {
                                                 self.image = image;
                                             }
                                             
                                             [_delegate imageFinishedDownloading:index image:self.image];

                                         }
                                             failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                         {
                                             NSLog(@"Downloading error: %@", error);
                                         }];
    
    /*
     AFNetworking: NSURLSession
     
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = url;
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        NSString *path = [filePath path];
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];

        UIImage *image = [UIImage imageWithData: data];
        if (image) {
            self.image = image;
        }
        
        [_delegate imageFinishedDownloading:index image:self.image];
    
    }];
    [downloadTask resume];
     */

}
/*
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
 */

@end
