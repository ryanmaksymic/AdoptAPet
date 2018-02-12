//
//  PetSearchRealm.h
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-12.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import <Realm/Realm.h>

@interface PetSearchRealm : RLMObject

@property (nonatomic) int type;
@property (nonatomic) int sex;
@property (nonatomic) int size;
@property (nonatomic) int age;

@end
