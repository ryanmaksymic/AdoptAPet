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

@interface DataManager : NSObject

@property Pet *pet;

+ (void)favorite:(Pet *)pet;
+ (BOOL)checkPet:(NSString *)idPet;
+ (NSArray<NSString *> *)getFavourites;

@end
