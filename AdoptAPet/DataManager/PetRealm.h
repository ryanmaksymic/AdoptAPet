//
//  PetRealm.h
//  AdoptAPet
//
//  Created by Fernando Zanei on 2018-02-09.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import <Realm/Realm.h>
#import "ContactRealm.h"
#import "StringRealm.h"
@class UIImage;

@interface PetRealm : RLMObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic) int type;
@property (nonatomic) RLMArray<StringRealm *><StringRealm> *breeds;
@property (nonatomic) BOOL mix;
@property (nonatomic) int size;
@property (nonatomic) int age;
@property (nonatomic) int sex;
@property (nonatomic, strong) NSString * petDescription;
@property (nonatomic) RLMArray<StringRealm *><StringRealm> *options;
@property ContactRealm *contact;
@property (nonatomic, strong) NSString * idNumber;
@property (nonatomic, strong) NSDate * lastUpdated;
@property (nonatomic) RLMArray<StringRealm *><StringRealm> *photoURLs;
@property (nonatomic) RLMArray<StringRealm *><StringRealm> *photos;

@end
