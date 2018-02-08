//
//  NetworkManager.h
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class Pet;

@interface NetworkManager : NSObject

+ (void)fetchPetDataFromURL:(NSURL *)url completionHandler:(void (^)(NSArray<Pet *> * pets))completion;
+ (void)fetchImageFileFromURL:(NSURL *)url completionHandler:(void (^)(UIImage * image))completion;

@end
