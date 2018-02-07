//
//  Pet.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "Pet.h"

@implementation Pet

- (instancetype)initWithJSON:(NSDictionary *)json
{
  self = [super init];
  
  if (self)
  {
    // name:
    _name = json[@"name"][@"$t"];
    
    // animal:
    if ([json[@"animal"][@"$t"] isEqualToString:@"Dog"])
    {
      _animal = PetAnimalDog;
    }
    else if ([json[@"animal"][@"$t"] isEqualToString:@"Cat"])
    {
      _animal = PetAnimalCat;
    }
    
    // breeds:
    if ([json[@"breeds"][@"breed"] isKindOfClass:[NSArray class]])
    {
      NSMutableArray * tempBreeds = [@[] mutableCopy];
      for (NSDictionary * breed in json[@"breeds"][@"breed"])
      {
        [tempBreeds addObject:breed[@"$t"]];
      }
      _breeds = tempBreeds;
    }
    else if ([json[@"breeds"][@"breed"] isKindOfClass:[NSDictionary class]])
    {
      _breeds = @[json[@"breeds"][@"breed"][@"$t"]];
    }
    
    // mix:
    if ([json[@"mix"][@"%t"] isEqualToString:@"yes"])
    {
      _mix = YES;
    }
    else if ([json[@"mix"][@"%t"] isEqualToString:@"no"])
    {
      _mix = NO;
    }
    
    // sex:
    if ([json[@"sex"][@"$t"] isEqualToString:@"M"])
    {
      _sex = PetSexMale;
    }
    else if ([json[@"sex"][@"$t"] isEqualToString:@"F"])
    {
      _sex = PetSexFemale;
    }
    
    // petDescription:
    if ([json[@"description"] count] > 0)
    {
      _petDescription = json[@"description"][@"$t"];
    }
    else
    {
      _petDescription = @"";
    }
    
    // options:
    
    
    // contact:
    
    
    // idNUmber:
    
    
    // lastUpdated:
    
    
    // photoURLs:
    NSMutableArray * tempPhotoURLs = [@[] mutableCopy];
    for (NSDictionary * photo in json[@"media"][@"photos"][@"photo"])
    {
      [tempPhotoURLs addObject:[NSURL URLWithString:photo[@"$t"]]];
    }
    _photoURLs = tempPhotoURLs;
  }
  
  return self;
}


- (NSString *) photoURLsString
{
  NSMutableString * result = [@"" mutableCopy];
  
  for (NSURL * url in self.photoURLs)
  {
    [result appendFormat:@"%@\n", url];
  }
  
  return result;
}

- (NSString *)animalString
{
  if (self.animal == PetAnimalDog)
  {
    return @"dog";
  }
  
  return @"cat";
}

- (NSString *)breedsString
{
  NSMutableString * result = [@"" mutableCopy];
  
  for (NSString * breed in self.breeds)
  {
    [result appendFormat:@"%@  ", breed];
  }
  
  return result;
}

- (NSString *)mixString
{
  return self.mix ? @"YES" : @"NO";
}

- (NSString *)sexString
{
  return self.sex == PetSexMale ? @"male" : @"female";
}

- (NSString *)description
{
  NSMutableString * result = [@"" mutableCopy];
  
  [result appendFormat:@"\nName: %@", self.name];
  [result appendFormat:@"\nAnimal: %@", [self animalString]];
  [result appendFormat:@"\nBreeds: %@", [self breedsString]];
  [result appendFormat:@"\nMix: %@", [self mixString]];
  [result appendFormat:@"\nSex: %@", [self sexString]];
  [result appendFormat:@"\nDescription: %@", self.petDescription];
  [result appendFormat:@"\nPhoto URLS:\n%@", [self photoURLsString]];
  
  return result;
}

@end
