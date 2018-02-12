//
//  SearchViewController.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "SearchViewController.h"
#import "PetSearch.h"
#import "NetworkManager.h"
#import "AlertsViewController.h"
#import "SearchResultsViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface SearchViewController () <UITextFieldDelegate, CLLocationManagerDelegate, AlertsDelegate>

@property (nonatomic) PetSearch * petSearch;
@property (nonatomic) NSArray<Pet *> * pets;

@property (nonatomic) CLLocationManager * locationManager;
@property (weak, nonatomic) IBOutlet UITextField * locationTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl * petTypeSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl * petSexSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl * petSizeSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl * petAgeSegmentedControl;
@property (weak, nonatomic) IBOutlet UIButton * searchButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicator;

@end


@implementation SearchViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
  
  self.locationTextField.delegate = self;
  
  self.locationManager = [[CLLocationManager alloc] init];
  self.locationManager.delegate = self;
}

- (void)collectSearchTerms
{
  self.petSearch = [[PetSearch alloc] init];
  self.petSearch.locationZip = self.locationTextField.text;
  self.petSearch.type = self.petTypeSegmentedControl.selectedSegmentIndex;
  self.petSearch.sex = self.petSexSegmentedControl.selectedSegmentIndex;
  self.petSearch.size = self.petSizeSegmentedControl.selectedSegmentIndex;
  self.petSearch.age = self.petAgeSegmentedControl.selectedSegmentIndex;
}


#pragma mark - Touches

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self.view endEditing:YES];
}


#pragma mark - UITextFieldDelegate

- (IBAction)textFieldEditingDidEnd:(UITextField *)sender
{
  if ([self.locationTextField.text isEqualToString:@""])
  {
    [self.searchButton setEnabled:NO];
  }
  else
  {
    [self.searchButton setEnabled:YES];
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [self.view endEditing:YES];
  
  return YES;
}


#pragma mark - Button actions

- (IBAction)search:(UIButton *)sender
{
  [self.activityIndicator startAnimating];
  [self.activityIndicator setHidden:NO];
  
  [self collectSearchTerms];
  
  [NetworkManager fetchPetDataFromURL:[self.petSearch generatePetSearchURL] completionHandler:^(NSArray<Pet *> * pets) {
    
    // TODO: Only proceed if fetched data is valid
    
    self.pets = pets;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      
      [self.activityIndicator stopAnimating];
      
      [self performSegueWithIdentifier:@"showSearchResults" sender:nil];
      
    }];
    
  }];
}

- (IBAction)resetFilters:(UIButton *)sender
{
  self.petTypeSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment;
  self.petSexSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment;
  self.petSizeSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment;
  self.petAgeSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment;
}

- (IBAction)getLocation:(UIButton *)sender
{
  [self.locationManager requestLocation];
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
    
    NSString * locationZip = placemarks.firstObject.postalCode;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      
      self.locationTextField.text = locationZip;
      
      [self textFieldEditingDidEnd:self.locationTextField];
      
    }];
    
  }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
  NSLog(@"Error: %@", error.localizedDescription);
}


#pragma mark - AlertsDelegate

- (void)alertsViewController:(AlertsViewController *)avc didSelectAlert:(PetSearch *)alert
{
  self.petTypeSegmentedControl.selectedSegmentIndex = alert.type;
  self.petSexSegmentedControl.selectedSegmentIndex = alert.sex;
  self.petSizeSegmentedControl.selectedSegmentIndex = alert.size;
  self.petAgeSegmentedControl.selectedSegmentIndex = alert.age;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"showSearchResults"])
  {
    SearchResultsViewController * srvc = (SearchResultsViewController *)segue.destinationViewController;
    
    srvc.pets = self.pets;
    srvc.searchTerms = [self.petSearch searchTermsString];
    srvc.locationZip = self.petSearch.locationZip;
  }
  if ([segue.identifier isEqualToString:@"showAlerts"])
  {
    UINavigationController * nvc = (UINavigationController *)segue.destinationViewController;
    
    AlertsViewController * avc = nvc.viewControllers.firstObject;
    
    [self collectSearchTerms];
    
    avc.currentSearch = self.petSearch;
    
    avc.delegate = self;
  }
}

@end
