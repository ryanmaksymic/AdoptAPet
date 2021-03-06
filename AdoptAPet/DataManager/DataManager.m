//
//  DataManager.m
//  AdoptAPet
//
//  Created by Fernando Zanei on 2018-02-09.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "DataManager.h"
#import "PetRealm.h"
#import "ContactRealm.h"
#import "PetSearchRealm.h"
#import "StringRealm.h"
#import "Pet.h"
#import "Contact.h"
#import "PetSearch.h"

@implementation DataManager

#pragma mark - Favorites

+ (void)favorite:(Pet *)pet {
  if (![self checkPet:pet.idNumber]) {
    [self savePet:pet];
    pet.isFavorite = YES;
  } else {
    [self deletePet:pet.idNumber];
    pet.isFavorite = NO;
  }
}

+ (NSArray<Pet *> *)getFavourites {
  RLMResults *results = [PetRealm allObjects];
  
  NSMutableArray<Pet *> *pets = [NSMutableArray arrayWithCapacity:results.count];
  for (PetRealm *petRealm in results) {
    
    Contact *contact = [[Contact alloc] init];
    contact.phone = petRealm.contact.phone;
    contact.email = petRealm.contact.email;
    contact.address1 = petRealm.contact.address1;
    contact.address2 = petRealm.contact.address2;
    contact.city = petRealm.contact.city;
    contact.state = petRealm.contact.state;
    contact.zip = petRealm.contact.zip;
    
    Pet *pet = [[Pet alloc] init];
    pet.name = petRealm.name;
    pet.type = petRealm.type;
    
    NSMutableArray<NSString *> *breedArray = [[NSMutableArray alloc] initWithCapacity:petRealm.breeds.count];
    for (StringRealm *breed in petRealm.breeds) {
      [breedArray addObject:breed.string];
    }
    pet.breeds = [breedArray copy];
    
    pet.mix = petRealm.mix;
    pet.size = petRealm.size;
    pet.age = petRealm.age;
    pet.sex = petRealm.sex;
    pet.petDescription = petRealm.petDescription;
    
    NSMutableArray *optionsArray = [[NSMutableArray alloc] initWithCapacity:petRealm.options.count];
    for (StringRealm *option in petRealm.options) {
      [optionsArray addObject:[NSNumber numberWithInt:option.integer]];
    }
    pet.options = [optionsArray copy];
    
    pet.contact = contact;
    pet.idNumber = petRealm.idNumber;
    pet.lastUpdated = petRealm.lastUpdated;
    
    NSMutableArray<NSString *> *urlsArray = [[NSMutableArray alloc] initWithCapacity:petRealm.photoURLs.count];
    for (StringRealm *url in petRealm.photoURLs) {
      [urlsArray addObject:url.string];
    }
    pet.photoURLs = [urlsArray copy];
    
    NSMutableArray<UIImage *> *photosArray = [[NSMutableArray alloc] initWithCapacity:petRealm.photos.count];
    for (StringRealm *photo in petRealm.photos) {
      [photosArray addObject:[UIImage imageWithData:photo.image]];
    }
    pet.photos = [photosArray copy];
    
    pet.isFavorite = YES;
    
    [pets addObject:pet];
  }
  return pets;
}

+ (BOOL)checkPet:(NSString *)idPet {
  NSString *filter = [NSString stringWithFormat:@"idNumber = '%@'", idPet];
  RLMResults *pet = [PetRealm objectsWhere:filter];
  
  
  if (pet.count >= 1) {
    return YES;
  }
  return NO;
}

+ (void)savePet:(Pet *)pet {
  RLMRealm *realm = [RLMRealm defaultRealm];
  
  
  // Contact
  ContactRealm *contactRealm = [[ContactRealm alloc] init];
  contactRealm.phone = pet.contact.phone;
  contactRealm.email = pet.contact.email;
  contactRealm.address1 = pet.contact.address1;
  contactRealm.address2 = pet.contact.address2;
  contactRealm.city = pet.contact.city;
  contactRealm.state = pet.contact.state;
  contactRealm.zip = pet.contact.zip;
  contactRealm.idPet = pet.idNumber;
  
  // Pet
  PetRealm *petRealm = [[PetRealm alloc] init];
  
  petRealm.name = pet.name;
  petRealm.type = (int)pet.type;
  
  for (NSString *breed in pet.breeds) {
    StringRealm *strBreed = [[StringRealm alloc] init];
    strBreed.string = breed;
    strBreed.idPet = pet.idNumber;
    [petRealm.breeds addObject:strBreed];
  }
  
  petRealm.mix = pet.mix;
  petRealm.size = (int)pet.size;
  petRealm.age = (int)pet.age;
  petRealm.sex = (int)pet.sex;
  petRealm.petDescription = pet.petDescription;
  
  for (id opt in pet.options) {
    StringRealm *intOption = [[StringRealm alloc] init];
    intOption.integer = [opt intValue];
    intOption.idPet = pet.idNumber;
    [petRealm.options addObject:intOption];
  }
  
  petRealm.contact = contactRealm;
  petRealm.idNumber = pet.idNumber;
  
  petRealm.lastUpdated = pet.lastUpdated;
  
  for (NSURL *url in pet.photoURLs) {
    StringRealm *strUrl = [[StringRealm alloc] init];
    strUrl.string = url.absoluteString;
    strUrl.idPet = pet.idNumber;
    [petRealm.photoURLs addObject:strUrl];
  }
  
  for (UIImage *image in pet.photos) {
    StringRealm *img = [[StringRealm alloc] init];
    NSData *data = UIImageJPEGRepresentation(image, 0);
    img.image = data;
    img.idPet = pet.idNumber;
    [petRealm.photos addObject:img];
    
  }
  
  
  
  [realm transactionWithBlock:^{
    [realm addObject:petRealm];
  }];
}

+ (void)deletePet:(NSString *)idPet {
  
  NSString *filter = [NSString stringWithFormat:@"idNumber = '%@'", idPet];
  RLMResults *pets = [PetRealm objectsWhere:filter];
  
  NSString *filter2 = [NSString stringWithFormat:@"idPet = '%@'", idPet];
  RLMResults *contacts = [ContactRealm objectsWhere:filter2];
  RLMResults *strings = [StringRealm objectsWhere:filter2];
  
  RLMRealm *realm = [RLMRealm defaultRealm];
  for (PetRealm *pet in pets) {
    [realm beginWriteTransaction];
    [realm deleteObject:pet];
    [realm commitWriteTransaction];
  }
  for (ContactRealm *contact in contacts) {
    [realm beginWriteTransaction];
    [realm deleteObject:contact];
    [realm commitWriteTransaction];
  }
  for (StringRealm *string in strings) {
    [realm beginWriteTransaction];
    [realm deleteObject:string];
    [realm commitWriteTransaction];
  }
}

+ (void)deleteAllPetsCompletionHandler:(void (^)(void) )completion {
  RLMResults *pets = [PetRealm allObjects];
  RLMResults *contacts = [ContactRealm allObjects];
  RLMResults *strings = [StringRealm allObjects];
  RLMRealm *realm = [RLMRealm defaultRealm];
  [realm beginWriteTransaction];
  [realm deleteObjects:pets];
  [realm deleteObjects:contacts];
  [realm deleteObjects:strings];
  [realm commitWriteTransaction];
  
  completion();
}


#pragma mark - Saved searches

+ (NSMutableArray<PetSearch *> *)getSavedSearches
{
  RLMResults *results = [PetSearchRealm allObjects];
  
  NSMutableArray<PetSearch *> * petSearches = [NSMutableArray arrayWithCapacity:results.count];
  
  for (PetSearchRealm * petSearchRealm in results)
  {
    PetSearch * petSearch = [[PetSearch alloc] init];
    
    petSearch.type = petSearchRealm.type;
    petSearch.sex = petSearchRealm.sex;
    petSearch.size = petSearchRealm.size;
    petSearch.age = petSearchRealm.age;
    petSearch.idPetSearch = petSearchRealm.idPetSearch;
    
    [petSearches addObject:petSearch];
  }
  
  return petSearches;
}

+ (void)saveSearch:(PetSearch *)petSearch
{
  RLMRealm * realm = [RLMRealm defaultRealm];
  
  PetSearchRealm * petSearchRealm = [[PetSearchRealm alloc] init];
  
  petSearchRealm.type = petSearch.type;
  petSearchRealm.sex = petSearch.sex;
  petSearchRealm.size = petSearch.size;
  petSearchRealm.age = petSearch.age;
  petSearchRealm.idPetSearch = petSearch.idPetSearch;
  
  [realm transactionWithBlock:^{
    [realm addObject:petSearchRealm];
  }];
}

+ (void)deleteSearch:(NSString *)idPetSearch
{
  NSString *filter = [NSString stringWithFormat:@"idPetSearch = '%@'", idPetSearch];
  RLMResults *petSearches = [PetSearchRealm objectsWhere:filter];
  
  RLMRealm *realm = [RLMRealm defaultRealm];
  
  for (PetSearchRealm * petSearch in petSearches)
  {
    [realm beginWriteTransaction];
    [realm deleteObject:petSearch];
    [realm commitWriteTransaction];
  }
}

@end
