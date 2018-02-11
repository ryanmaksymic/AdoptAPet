//
//  ListViewController.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "ListViewController.h"
#import "Contact.h"
#import "Pet.h"
#import "PetSearch.h"
#import "NetworkManager.h"
#import "PetTableViewCell.h"
#import "DetailViewController.h"

@interface ListViewController ()

@end

// TODO: Load new batch of pets when user gets to bottom of table
// TODO: Organized pets array by lastUpdated -- most recent first

@implementation ListViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.pets.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 534.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  PetTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"petCell"];
  
  cell.nameLabel.text = self.pets[indexPath.row].name;
  cell.sizeAgeSexLabel.text = [NSString stringWithFormat:@"%@-Sized %@ %@", [self.pets[indexPath.row] sizeString], [self.pets[indexPath.row] ageString], [self.pets[indexPath.row] sexString]];
  cell.breedsLabel.text = [self.pets[indexPath.row] breedsString];
  cell.locationLabel.text = [NSString stringWithFormat:@"%@, %@", self.pets[indexPath.row].contact.city, self.pets[indexPath.row].contact.state];
  cell.lastUpdatedLabel.text = [NSString stringWithFormat:@"Last updated: %@", [self.pets[indexPath.row] lastUpdatedString]];
  
  if ([self.pets[indexPath.row].photoURLs count] == 0 && [self.pets[indexPath.row].photos count] == 0)
  {
    self.pets[indexPath.row].photos[0] = [UIImage imageNamed:@"thumb_default_pet"];
  }
  else if ([self.pets[indexPath.row].photoURLs count] > 0 && [self.pets[indexPath.row].photos count] == 0)
  {
    [NetworkManager fetchImageFileFromURL:self.pets[indexPath.row].photoURLs.firstObject completionHandler:^(UIImage * image) {
      
      self.pets[indexPath.row].photos[0] = image;
      
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
      }];
      
    }];
  }
  
  cell.petImageView.image = self.pets[indexPath.row].photos.firstObject;
  
  return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"petDetail"]) {
    DetailViewController *detail = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Pet *pet = self.pets[indexPath.row];
    detail.pet = pet;
  }
}

@end
