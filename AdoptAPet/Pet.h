//
//  Pet.h
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class Contact;

typedef NS_ENUM(NSUInteger, PetType)
{
  PetTypeDog,
  PetTypeCat
};

typedef NS_ENUM(NSUInteger, PetSize)
{
  PetSizeSmall,
  PetSizeMedium,
  PetSizeLarge,
  PetSizeExtraLarge
};

typedef NS_ENUM(NSUInteger, PetAge) {
  PetAgeBaby,
  PetAgeYoung,
  PetAgeAdult,
  PetAgeSenior
};

typedef NS_ENUM(NSUInteger, PetSex)
{
  PetSexMale,
  PetSexFemale
};

typedef NS_ENUM(NSUInteger, PetOption)
{
  PetOptionSpecialNeeds,
  PetOptionNoDogs,
  PetOptionNoCats,
  PetOptionNoKids,
  PetOptionHasShots,
  PetOptionHousetrained
};

@interface Pet : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic) PetType animal;
@property (nonatomic, strong) NSArray<NSString *> * breeds;
@property (nonatomic) BOOL mix;
@property (nonatomic) PetSize size;
@property (nonatomic) PetAge age;
@property (nonatomic) PetSex sex;
@property (nonatomic, strong) NSString * petDescription;
@property (nonatomic, strong) NSArray * options;
@property (nonatomic, strong) Contact * contact;
@property (nonatomic, strong) NSString * idNumber;
@property (nonatomic, strong) NSDate * lastUpdated;
@property (nonatomic, strong) NSArray<NSURL *> * photoURLs;
@property (nonatomic, strong) NSMutableArray<UIImage *> * photos;

- (instancetype)initWithJSON:(NSDictionary *)json;

- (NSString *)animalString;
- (NSString *)breedsString;
- (NSString *)mixString;
- (NSString *)sizeString;
- (NSString *)ageString;
- (NSString *)sexString;
- (NSString *)optionsString;
- (NSString *)contactString;
- (NSString *)lastUpdatedString;

@end
