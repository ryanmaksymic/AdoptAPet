//
//  NetworkManager.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "NetworkManager.h"
#import "Pet.h"

@implementation NetworkManager

+ (void)fetchPetDataFromURL:(NSURL *)url completionHandler:(void (^)(NSArray<Pet *> * pets))completion
{
  NSURLRequest * urlRequest = [[NSURLRequest alloc] initWithURL:url];
  
  NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  
  NSURLSession * session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    if (error)
    {
      NSLog(@"error: %@", error.localizedDescription);
      return;
    }
    
    NSError * jsonError = nil;
    
    NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError][@"petfinder"][@"pets"][@"pet"];
    
    if (jsonError)
    {
      NSLog(@"jsonError: %@", jsonError.localizedDescription);
      return;
    }
    
    NSMutableArray<Pet *> * pets = [@[] mutableCopy];
    
    for (NSDictionary * result in results)
    {
      Pet * pet = [[Pet alloc] initWithJSON:result];
      
      [pets addObject:pet];
      
      NSLog(@"%@", pet);
    }
    
    completion(pets);
    
    [session invalidateAndCancel];
    
  }];
  
  [dataTask resume];
}

+ (void)fetchImageFileFromURL:(NSURL *)url completionHandler:(void (^)(UIImage * image))completion
{
  NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  
  NSURLSession * session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDownloadTask * downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    if (error)
    {
      NSLog(@"error: %@", error.localizedDescription);
      return;
    }
    
    NSData * data = [NSData dataWithContentsOfURL:location];
    
    UIImage * image = [UIImage imageWithData:data];
    
    completion(image);
    
    [session invalidateAndCancel];
    
  }];
  
  [downloadTask resume];
}

@end
