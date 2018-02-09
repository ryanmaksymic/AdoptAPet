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
@property (nonatomic) NSMutableSet * sexes;
@property (nonatomic) NSMutableSet * sizes;
@property (nonatomic) NSMutableSet * ages;
@property (nonatomic) NSMutableSet * options;

- (NSString *)typeString;
- (NSString *)sexesString;
- (NSString *)sizesString;
- (NSString *)agesString;
- (NSString *)optionsString;

@end
