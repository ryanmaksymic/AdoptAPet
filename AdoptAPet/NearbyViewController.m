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
#import <CoreLocation/CoreLocation.h>

@interface NearbyViewController () <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIView * listView;

@property (nonatomic) CLLocationManager * locationManager;
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
  
  self.locationManager = [[CLLocationManager alloc] init];
  self.locationManager.delegate = self;
  [self.locationManager requestWhenInUseAuthorization];
  [self.locationManager requestLocation];
}

- (void)viewDidAppear:(BOOL)animated
{
  [self.lvc.tableView setNeedsDisplay];
  [self.lvc.tableView reloadData];
}


#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"embedList"])
  {
    self.lvc = (ListViewController *)segue.destinationViewController;
  }
}


#pragma mark - Private methods

- (void)updateListViewForZip:(NSString *)locationZip
{
  NSString *urlString = [NSString stringWithFormat:@"http://api.petfinder.com/pet.find?key=67a4b38197ee28774594388ab415505a&format=json&location=%@&animal=dog", locationZip];
  NSURL * url = [NSURL URLWithString:urlString];
  
  [NetworkManager fetchPetDataFromURL:url completionHandler:^(NSArray<Pet *> * pets) {
    
    self.nearbyDogs = pets;
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.petfinder.com/pet.find?key=67a4b38197ee28774594388ab415505a&format=json&location=%@&animal=cat", locationZip];
    NSURL * url = [NSURL URLWithString:urlString];
    
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


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
  CLLocation * location = locations.firstObject;
  
  [[[CLGeocoder alloc] init] reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
    
    if (error != nil)
    {
      NSLog(@"Error: %@", error.localizedDescription);
    }
    
    NSString * locationZip = [placemarks.firstObject.postalCode stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      
      [self updateListViewForZip:locationZip];
      
    }];
    
  }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
  NSLog(@"Error: %@", error.localizedDescription);
}

@end
