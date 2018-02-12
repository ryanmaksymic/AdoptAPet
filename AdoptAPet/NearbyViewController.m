//
//  NearbyViewController.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-09.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "NearbyViewController.h"
#import "Pet.h"
#import "NetworkManager.h"
#import "ListViewController.h"

@interface NearbyViewController ()

@property (weak, nonatomic) IBOutlet UIView * listView;

@property (nonatomic) ListViewController * lvc;
@property (nonatomic) NSArray<Pet *> * nearbyDogs;
@property (nonatomic) NSArray<Pet *> * nearbyCats;
@property (nonatomic) NSMutableArray<Pet *> * nearbyPets;

@end


@implementation NearbyViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
}

- (void)viewDidAppear:(BOOL)animated
{
  [self.lvc.tableView setNeedsDisplay];
  [self.lvc.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"embedList"])
  {
    self.lvc = (ListViewController *)segue.destinationViewController;
    
    // TODO: Get user location to search nearby
    
    NSURL * url = [NSURL URLWithString:@"http://api.petfinder.com/pet.find?key=67a4b38197ee28774594388ab415505a&format=json&location=M5V2H8&animal=dog"];
    
    [NetworkManager fetchPetDataFromURL:url completionHandler:^(NSArray<Pet *> * pets) {
      
      self.nearbyDogs = pets;
      
      NSURL * url = [NSURL URLWithString:@"http://api.petfinder.com/pet.find?key=67a4b38197ee28774594388ab415505a&format=json&location=M5V2H8&animal=cat"];
      
      [NetworkManager fetchPetDataFromURL:url completionHandler:^(NSArray<Pet *> * pets) {
        
        self.nearbyCats = pets;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          
          self.nearbyPets = [@[] mutableCopy];
          
          for (int i = 0; i < [self.nearbyCats count]; i++)
          {
            self.nearbyPets[i * 2] = self.nearbyCats[i];
            
            self.nearbyPets[i * 2 + 1] = self.nearbyDogs[i];
          }
          
          self.lvc.pets = self.nearbyPets;
          
          [self.lvc.tableView reloadData];
          
        }];
        
      }];
      
    }];
  }
}

@end
