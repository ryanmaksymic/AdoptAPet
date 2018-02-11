//
//  DataManager.m
//  AdoptAPet
//
//  Created by Fernando Zanei on 2018-02-09.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "DataManager.h"
#import "PetRealm.h"
#import "Pet.h"
#import "Contact.h"
#import "StringRealm.h"

@implementation DataManager

+ (void)favorite:(Pet *)pet {
  if ([self checkPet:pet.idNumber]) {
    [self savePet:pet];
  } else {
    [self deletePet:pet.idNumber];
  }
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

@end
