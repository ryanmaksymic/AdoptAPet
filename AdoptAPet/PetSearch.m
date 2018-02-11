//
//  PetSearch.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-09.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "PetSearch.h"

@implementation PetSearch

- (instancetype)init
{
  self = [super init];
  
  if (self)
  {
    _options = [NSMutableSet setWithCapacity:2];
  }
  
  return self;
}

- (instancetype)initWithType:(PetType)type sex:(PetSex)sex size:(PetSize)size age:(PetAge)age
{
  self = [super init];
  
  if (self)
  {
    _type = type;
    _sex = sex;
    _size = size;
    _age = age;
  }
  
  return self;
}


-(void)setLocationZip:(NSString *)locationZip
{
  _locationZip = [locationZip stringByReplacingOccurrencesOfString:@" " withString:@""];
}


- (NSURL *)generatePetSearchURL
{
  // base URL:
  NSMutableString * urlString = [@"http://api.petfinder.com/pet.find?key=67a4b38197ee28774594388ab415505a&format=json" mutableCopy];
  
  // count:
  [urlString appendString:@"&count=50"];  // TODO: Sort out how many to retrieve
  
  // location:
  [urlString appendFormat:@"&location=%@", self.locationZip];
  
  // type:
  NSString * typeArgument;
  switch (self.type)
  {
    case PetTypeDog:
      typeArgument = @"&animal=dog";
      break;
    case PetTypeCat:
      typeArgument = @"&animal=cat";
      break;
    default:
      typeArgument = @"";
      break;
  }
  [urlString appendString:typeArgument];
  
  // sex:
  NSString * sexArgument;
  switch (self.sex)
  {
    case PetSexMale:
      sexArgument = @"&sex=M";
      break;
    case PetSexFemale:
      sexArgument = @"&sex=F";
      break;
    default:
      sexArgument = @"";
      break;
  }
  [urlString appendString:sexArgument];
  
  // size:
  NSString * sizeArgument;
  switch (self.size)
  {
    case PetSizeSmall:
      sizeArgument = @"&size=S";
      break;
    case PetSizeMedium:
      sizeArgument = @"&size=M";
      break;
    case PetSizeLarge:
      sizeArgument = @"&size=L";
      break;
    case PetSizeExtraLarge:
      sizeArgument = @"&size=XL";
      break;
    default:
      sizeArgument = @"";
      break;
  }
  [urlString appendString:sizeArgument];
  
  // age:
  NSString * ageArgument;
  switch (self.age)
  {
    case PetAgeBaby:
      ageArgument = @"&age=Baby";
      break;
    case PetAgeYoung:
      ageArgument = @"&age=Young";
      break;
    case PetAgeAdult:
      ageArgument = @"&age=Adult";
      break;
    case PetAgeSenior:
      ageArgument = @"&age=Senior";
      break;
    default:
      ageArgument = @"";
      break;
  }
  [urlString appendString:ageArgument];
  
  // options:
  // TODO: Figure out how to filter by Options
  
  NSLog(@"Search URL: %@", urlString);
  
  return [NSURL URLWithString:urlString];
}


#pragma mark - String output methods

- (NSString *)searchTermsString
{
  return [NSString stringWithFormat:@"Type: %@ / Sex: %@ / Size: %@ / Age: %@", [self typeString], [self sexString], [self sizeString], [self ageString]];
}

- (NSString *)typeString
{
  switch (self.type)
  {
    case PetTypeDog:
      return @"Dog";
      break;
    case PetTypeCat:
      return @"Cat";
      break;
    default:
      return @"Any";
      break;
  }
}

- (NSString *)sexString
{
  switch (self.sex)
  {
    case PetSexMale:
      return @"Male";
      break;
    case PetSexFemale:
      return @"Female";
      break;
    default:
      return @"Any";
      break;
  }
}

- (NSString *)sizeString
{
  switch (self.size)
  {
    case PetSizeSmall:
      return @"Small";
      break;
    case PetSizeMedium:
      return @"Medium";
      break;
    case PetSizeLarge:
      return @"Large";
      break;
    case PetSizeExtraLarge:
      return @"Large";
      break;
    default:
      return @"Any";
      break;
  }
}

- (NSString *)ageString
{
  switch (self.age)
  {
    case PetAgeBaby:
      return @"Baby";
      break;
    case PetAgeYoung:
      return @"Young";
      break;
    case PetAgeAdult:
      return @"Adult";
      break;
    case PetAgeSenior:
      return @"Senior";
      break;
    default:
      return @"Any";
      break;
  }
}

/*
 - (NSString *)optionsString
 {
 if ([self.options count] == 0)
 {
 return @"No Options";
 }
 
 NSMutableString * result = [@"" mutableCopy];
 
 if ([self.options containsObject:[NSNumber numberWithInteger:PetOptionHasShots]])
 {
 [result appendString:@"Has Shots, "];
 }
 
 if ([self.options containsObject:[NSNumber numberWithInteger:PetOptionHousetrained]])
 {
 [result appendString:@"Housetrained, "];
 }
 
 return result;
 }
 */

@end
