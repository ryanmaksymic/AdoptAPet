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
    
    
    NSMutableArray * tempPhotoURLs = [@[] mutableCopy];
    
    for (NSDictionary * photo in json[@"media"][@"photos"][@"photo"])
    {
      [tempPhotoURLs addObject:[NSURL URLWithString:photo[@"$t"]]];
    }
    
    _photoURLs = tempPhotoURLs;
    
    
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

- (NSString *)description
{
  NSMutableString * result = [@"" mutableCopy];
  
  [result appendFormat:@"\nName: %@", self.name];
  [result appendFormat:@"\nAnimal: %@", [self animalString]];
  [result appendFormat:@"\nBreeds: %@", [self breedsString]];
  [result appendFormat:@"\nPhoto URLS:\n%@", [self photoURLsString]];
  
  return result;
}

@end
