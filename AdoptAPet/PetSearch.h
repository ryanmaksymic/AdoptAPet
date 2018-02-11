//
//  PetSearch.h
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-09.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pet.h"

@interface PetSearch : NSObject

@property (nonatomic, copy) NSString * locationZip;
@property (nonatomic) PetType type;
@property (nonatomic) PetSex sex;
@property (nonatomic) PetSize size;
@property (nonatomic) PetAge age;
@property (nonatomic) NSMutableSet * options;

- (instancetype)initWithType:(PetType)type sex:(PetSex)sex size:(PetSize)size age:(PetAge)age;
- (NSURL *)generatePetSearchURL;
- (NSString *)searchTermsString;

@end
