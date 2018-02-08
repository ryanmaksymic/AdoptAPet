//
//  ViewController.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "ViewController.h"
#import "Contact.h"
#import "Pet.h"
#import "NetworkManager.h"
#import "PetTableViewCell.h"

@interface ViewController ()

@property (nonatomic) NSArray<Pet *> * pets;

@end


@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  NSURL * url = [NSURL URLWithString:@"http://api.petfinder.com/pet.find?location=M5T2V4&key=67a4b38197ee28774594388ab415505a&format=json"];
  //NSURL * url = [NSURL URLWithString:@"http://api.petfinder.com/pet.find?animal=bird&location=M5T2V4&key=67a4b38197ee28774594388ab415505a&format=json"];
  
  [NetworkManager fetchPetDataFromURL:url completionHandler:^(NSArray<Pet *> *pets) {
    
    self.pets = pets;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      
      [self.tableView reloadData];
      
    }];
    
  }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.pets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  PetTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"petCell"];
  
  cell.nameLabel.text = self.pets[indexPath.row].name;
  cell.sizeLabel.text = [self.pets[indexPath.row] sizeString];
  cell.sexLabel.text = [self.pets[indexPath.row] sexString];
  cell.breedsLabel.text = [self.pets[indexPath.row] breedsString];
  cell.locationLabel.text = [NSString stringWithFormat:@"%@, %@", self.pets[indexPath.row].contact.city, self.pets[indexPath.row].contact.state];
  cell.lastUpdatedLabel.text = [NSString stringWithFormat:@"Last updated: %@", [self.pets[indexPath.row] lastUpdatedString]];
  
  return cell;
}

@end
