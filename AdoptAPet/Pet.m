//
//  Pet.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "Pet.h"
#import "Contact.h"

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
      _animal = PetTypeDog;
    }
    else if ([json[@"animal"][@"$t"] isEqualToString:@"Cat"])
    {
      _animal = PetTypeCat;
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
    
    // size:
    if ([json[@"size"][@"$t"] isEqualToString:@"S"])
    {
      _size = PetSizeSmall;
    }
    else if ([json[@"size"][@"$t"] isEqualToString:@"M"])
    {
      _size = PetSizeMedium;
    }
    else if ([json[@"size"][@"$t"] isEqualToString:@"L"])
    {
      _size = PetSizeLarge;
    }
    else if ([json[@"size"][@"$t"] isEqualToString:@"XL"])
    {
      _size = PetSizeExtraLarge;
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
    if ([json[@"options"] count] > 0)
    {
      if ([json[@"options"][@"option"] isKindOfClass:[NSArray class]])
      {
        NSMutableArray * tempOptions = [@[] mutableCopy];
        for (NSDictionary * option in json[@"options"][@"option"]) {
          if ([option[@"$t"] isEqualToString:@"specialNeeds"])
          {
            [tempOptions addObject:[NSNumber numberWithInt:PetOptionSpecialNeeds]];
          }
          else if ([option[@"$t"] isEqualToString:@"noDogs"])
          {
            [tempOptions addObject:[NSNumber numberWithInt:PetOptionNoDogs]];
          }
          else if ([option[@"$t"] isEqualToString:@"noCats"])
          {
            [tempOptions addObject:[NSNumber numberWithInt:PetOptionNoCats]];
          }
          else if ([option[@"$t"] isEqualToString:@"noKids"])
          {
            [tempOptions addObject:[NSNumber numberWithInt:PetOptionNoKids]];
          }
          else if ([option[@"$t"] isEqualToString:@"noClaws"])
          {
            [tempOptions addObject:[NSNumber numberWithInt:PetOptionNoClaws]];
          }
          else if ([option[@"$t"] isEqualToString:@"hasShots"])
          {
            [tempOptions addObject:[NSNumber numberWithInt:PetOptionHasShots]];
          }
          else if ([option[@"$t"] isEqualToString:@"housebroken"])
          {
            [tempOptions addObject:[NSNumber numberWithInt:PetOptionHousebroken]];
          }
        }
        _options = tempOptions;
      }
      else
      {
        _options = @[json[@"options"][@"option"][@"$t"]];
      }
    }
    
    // contact:
    _contact = [[Contact alloc] init];
    _contact.phone = [json[@"contact"][@"phone"] count] > 0 ? json[@"contact"][@"phone"][@"$t"] : @"";
    _contact.email = [json[@"contact"][@"email"] count] > 0 ? json[@"contact"][@"email"][@"$t"] : @"";
    _contact.address1 = [json[@"contact"][@"address1"] count] > 0 ? json[@"contact"][@"address1"][@"$t"] : @"";
    _contact.address2 = [json[@"contact"][@"address2"] count] > 0 ? json[@"contact"][@"address1"][@"$t"] : @"";
    _contact.city = [json[@"contact"][@"city"] count] > 0 ? json[@"contact"][@"city"][@"$t"] : @"";
    _contact.state = [json[@"contact"][@"state"] count] > 0 ? json[@"contact"][@"state"][@"$t"] : @"";
    _contact.zip = [json[@"contact"][@"zip"] count] > 0 ? json[@"contact"][@"zip"][@"$t"] : @"";
    
    // idNUmber:
    _idNumber = json[@"id"][@"$t"];
    
    // lastUpdated:
    NSString * dateString = [json[@"lastUpdate"][@"$t"] componentsSeparatedByString:@"T"].firstObject;
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _lastUpdated = [dateFormatter dateFromString:dateString];
    
    // photoURLs:
    NSMutableArray * tempPhotoURLs = [@[] mutableCopy];
    for (NSDictionary * photo in json[@"media"][@"photos"][@"photo"])
    {
      NSString * photoURLString = photo[@"$t"];
      if ([photo[@"@size"] isEqualToString: @"x"])  // Full-size photos have "size" key's value set to "x"
      {
        [tempPhotoURLs addObject:[NSURL URLWithString:photoURLString]];
      }
    }
    _photoURLs = tempPhotoURLs;
  }
  
  _photos = [@[] mutableCopy];
  
  return self;
}


- (NSString *)animalString
{
  if (self.animal == PetTypeDog)
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
    [result appendFormat:@"%@", breed];
    
    if (breed != self.breeds.lastObject)
    {
      [result appendString:@" / "];
    }
  }
  
  return result;
}

- (NSString *)mixString
{
  return self.mix ? @"YES" : @"NO";
}

- (NSString *)sizeString
{
  if (self.size == PetSizeSmall)
  {
    return @"Small";
  }
  else if (self.size == PetSizeMedium)
  {
    return @"Medium";
  }
  else if (self.size == PetSizeLarge)
  {
    return @"Large";
  }
  
  return @"Extra Large";
}

- (NSString *)sexString
{
  return self.sex == PetSexMale ? @"Male" : @"Female";
}

- (NSString *)optionsString
{
  NSMutableString * result = [@"" mutableCopy];
  
  for (NSNumber * option in self.options)
  {
    if (option == PetOptionSpecialNeeds)
    {
      [result appendString:@"Special Needs ∙ "];
    }
    else if (option.integerValue == PetOptionNoDogs)
    {
      [result appendString:@"No Dogs ∙ "];
    }
    else if (option.integerValue == PetOptionNoCats)
    {
      [result appendString:@"No Cats ∙ "];
    }
    else if (option.integerValue == PetOptionNoKids)
    {
      [result appendString:@"No Kids ∙ "];
    }
    else if (option.integerValue == PetOptionNoClaws)
    {
      [result appendString:@"No Claws ∙ "];
    }
    else if (option.integerValue == PetOptionHasShots)
    {
      [result appendString:@"Has Shots ∙ "];
    }
    else if (option.integerValue == PetOptionHousebroken)
    {
      [result appendString:@"Housebroken ∙ "];
    }
  }

    if ([result length] > 3) {
        NSString *resultFormatted = [result substringToIndex:[result length]-3];
        return resultFormatted;
    }
    
    return result;
}

- (NSString *)contactString
{
  NSMutableString * result = [@"" mutableCopy];
  
  [result appendFormat:@"%@\n", self.contact.phone];
  [result appendFormat:@"%@\n", self.contact.email];
  [result appendFormat:@"%@\n", self.contact.address1];
  [result appendFormat:@"%@\n", self.contact.address2];
  [result appendFormat:@"%@\n", self.contact.city];
  [result appendFormat:@"%@\n", self.contact.state];
  [result appendFormat:@"%@\n", self.contact.zip];
  
  return result;
}

- (NSString *)photoURLsString
{
  NSMutableString * result = [@"" mutableCopy];
  
  for (NSURL * url in self.photoURLs)
  {
    [result appendFormat:@"%@\n", url];
  }
  
  return result;
}

- (NSString *)lastUpdatedString
{
  NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"MM-dd-yyyy"];
  return [dateFormatter stringFromDate:self.lastUpdated];
}

- (NSString *)description
{
  NSMutableString * result = [@"" mutableCopy];
  
  [result appendString:@"\n\n* * * * * * * * - - - - - - - -"];
  [result appendFormat:@"\n\nPet #%@", self.idNumber];
  [result appendFormat:@"\n\nName: %@", self.name];
  [result appendFormat:@"\n\nAnimal: %@", [self animalString]];
  [result appendFormat:@"\n\nBreeds: %@", [self breedsString]];
  [result appendFormat:@"\n\nMix: %@", [self mixString]];
  [result appendFormat:@"\n\nSex: %@", [self sexString]];
  [result appendFormat:@"\n\nDescription: %@", self.petDescription];
  [result appendFormat:@"\n\nOptions:\n%@", [self optionsString]];
  [result appendFormat:@"\n\nContact:\n%@", [self contactString]];
  [result appendFormat:@"\n\nLast updated: %@", [self lastUpdatedString]];
  [result appendFormat:@"\n\nPhoto URLs:\n%@", [self photoURLsString]];
  [result appendString:@"\n- - - - - - - - * * * * * * * *\n"];
  
  return result;
}

@end
