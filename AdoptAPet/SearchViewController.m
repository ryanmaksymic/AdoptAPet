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
#import "SearchResultsViewController.h"

@interface SearchViewController () <UITextFieldDelegate>

@property (nonatomic) PetSearch * petSearch;
@property (nonatomic) NSArray<Pet *> * pets;

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

- (IBAction)getLocation:(UIButton *)sender
{
  // TODO: Get user location
}

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
}

@end
