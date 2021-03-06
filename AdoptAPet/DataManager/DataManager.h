//
//  DataManager.h
//  AdoptAPet
//
//  Created by Fernando Zanei on 2018-02-09.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
@class Pet;
@class PetSearch;

@interface DataManager : NSObject

@property Pet *pet;

+ (void)favorite:(Pet *)pet;
+ (BOOL)checkPet:(NSString *)idPet;
+ (NSArray<NSString *> *)getFavourites;
+ (void)deleteAllPetsCompletionHandler:(void (^)(void) )completion;

+ (NSMutableArray<PetSearch *> *)getSavedSearches;
+ (void)deleteSearch:(NSString *)idPetSearch;
+ (void)saveSearch:(PetSearch *)petSearch;

@end
