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

typedef NS_ENUM(NSUInteger, PetSex)
{
  PetSexMale,
  PetSexFemale
};

typedef NS_ENUM(NSUInteger, PetSize)
{
  PetSizeSmall,
  PetSizeMedium,
  PetSizeLarge,
  PetSizeExtraLarge
};

typedef NS_ENUM(NSUInteger, PetOption)
{
  PetOptionSpecialNeeds,
  PetOptionNoDogs,
  PetOptionNoCats,
  PetOptionNoKids,
  PetOptionNoClaws,
  PetOptionHasShots,
  PetOptionHousebroken
};

@interface Pet : NSObject

@property (nonatomic) NSString * name;
@property (nonatomic) PetType animal;
@property (nonatomic) NSArray<NSString *> * breeds;
@property (nonatomic) BOOL mix;
@property (nonatomic) PetSex sex;
@property (nonatomic) NSString * petDescription;
@property (nonatomic) NSArray * options;
@property (nonatomic) Contact * contact;
@property (nonatomic) NSString * idNumber;
@property (nonatomic) NSDate * lastUpdated;
@property (nonatomic) NSArray<NSURL *> * photoURLs;

- (instancetype)initWithJSON:(NSDictionary *)json;

@end
