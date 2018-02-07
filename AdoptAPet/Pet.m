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
    _name = json[@"name"][@"$t"];
    
    
    if ([json[@"animal"][@"$t"] isEqualToString:@"Dog"])
    {
      _animal = PetAnimalDog;
    }
    else if ([json[@"animal"][@"$t"] isEqualToString:@"Cat"])
    {
      _animal = PetAnimalCat;
    }
    
    
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
  }
  
  return self;
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
    [result appendFormat:@"%@ ", breed];
  }
  
  return result;
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"%@ the %@%@", self.name, [self breedsString], [self animalString]];
}

@end
