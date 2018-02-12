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
#import "StringRealm.h"
#import "Pet.h"
#import "Contact.h"

@implementation DataManager

+ (void)favorite:(Pet *)pet {
  if ([self checkPet:pet.idNumber]) {
    [self savePet:pet];
  } else {
    [self deletePet:pet.idNumber];
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
  
  
  if (pet.count > 0) {
    return NO;
  }
  return YES;
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
  
  // Pet
  PetRealm *petRealm = [[PetRealm alloc] init];
  
  petRealm.name = pet.name;
  petRealm.type = (int)pet.type;
  
  for (NSString *breed in pet.breeds) {
    StringRealm *strBreed = [[StringRealm alloc] init];
    strBreed.string = breed;
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
    [petRealm.options addObject:intOption];
  }
  
  petRealm.contact = contactRealm;
  petRealm.idNumber = pet.idNumber;
  
  petRealm.lastUpdated = pet.lastUpdated;
  
  for (NSURL *url in pet.photoURLs) {
    StringRealm *strUrl = [[StringRealm alloc] init];
    strUrl.string = url.absoluteString;
    [petRealm.photoURLs addObject:strUrl];
  }
  
  for (UIImage *image in pet.photos) {
    StringRealm *img = [[StringRealm alloc] init];
    NSData *data = UIImageJPEGRepresentation(image, 0);
    img.image = data;
    [petRealm.photos addObject:img];
    
  }
  
  
  
  [realm transactionWithBlock:^{
    [realm addObject:petRealm];
  }];
}

+ (void)deletePet:(NSString *)idPet {
  
  NSString *filter = [NSString stringWithFormat:@"idNumber = '%@'", idPet];
  RLMResults *results = [PetRealm objectsWhere:filter];
  
  RLMRealm *realm = [RLMRealm defaultRealm];
  for (PetRealm *pet in results) {
    [realm beginWriteTransaction];
    [realm deleteObject:pet];
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
}

@end
