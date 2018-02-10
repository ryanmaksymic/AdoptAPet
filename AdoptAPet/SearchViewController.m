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

@interface SearchViewController ()

@property (nonatomic) PetSearch * petSearch;
@property (nonatomic) NSArray<Pet *> * pets;

@property (weak, nonatomic) IBOutlet UITextField * locationTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl * petTypeSegmentedControl;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * sexButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * sizeButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * ageButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * optionsButtons;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicator;

@end


@implementation SearchViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
  
  self.petSearch = [[PetSearch alloc] init];
  self.petSearch.type = PetTypeDog;
}


- (IBAction)getLocation:(UIButton *)sender
{
  // TODO: Get user location
}

- (void)collectSearchTerms
{
  self.petSearch.locationZip = self.locationTextField.text;
  
  self.petSearch.type = self.petTypeSegmentedControl.selectedSegmentIndex == 0 ? PetTypeDog : PetTypeCat;
  
  [self.petSearch.sexes removeAllObjects];
  for (UIButton * sexButton in self.sexButtons)
  {
    if (sexButton.isSelected)
    {
      [self.petSearch.sexes addObject:[NSNumber numberWithInteger:sexButton.tag]];
    }
  }
  
  [self.petSearch.sizes removeAllObjects];
  for (UIButton * sizeButton in self.sizeButtons)
  {
    if (sizeButton.isSelected)
    {
      [self.petSearch.sizes addObject:[NSNumber numberWithInteger:sizeButton.tag]];
    }
  }
  
  [self.petSearch.ages removeAllObjects];
  for (UIButton * ageButton in self.ageButtons)
  {
    if (ageButton.isSelected)
    {
      [self.petSearch.ages addObject:[NSNumber numberWithInteger:ageButton.tag]];
    }
  }
  
  [self.petSearch.options removeAllObjects];
  for (UIButton * optionsButton in self.optionsButtons)
  {
    if (optionsButton.isSelected)
    {
      [self.petSearch.options addObject:[NSNumber numberWithInteger:optionsButton.tag]];
    }
  }
  
  NSLog(@"");
  NSLog(@"Location: %@", self.petSearch.locationZip);
  NSLog(@"Type: %@", [self.petSearch typeString]);
  NSLog(@"Sexes: %@", [self.petSearch sexesString]);
  NSLog(@"Sizes: %@", [self.petSearch sizesString]);
  NSLog(@"Ages: %@", [self.petSearch agesString]);
  NSLog(@"Options: %@", [self.petSearch optionsString]);
}

- (IBAction)buttonToggled:(UIButton *)sender
{
  sender.selected = !sender.selected;
}

- (IBAction)search:(UIButton *)sender
{
  [self.activityIndicator startAnimating];
  [self.activityIndicator setHidden:NO];
  
  [self collectSearchTerms];
  
  [NetworkManager fetchPetDataFromURLs:@[[self.petSearch generatePetSearchURLs]] completionHandler:^(NSArray<Pet *> * pets) {
    
    self.pets = pets;
    
    // TODO: Fix this transition:
    [self performSegueWithIdentifier:@"showSearchResults" sender:nil];
    
  }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"showSearchResults"])
  {
    SearchResultsViewController * srvc = (SearchResultsViewController *)segue.destinationViewController;
    
    srvc.pets = self.pets;
  }
}

@end
