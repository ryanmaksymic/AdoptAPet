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
@property (weak, nonatomic) IBOutlet UISegmentedControl * petSexSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl * petSizeSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl * petAgeSegmentedControl;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * optionsButtons;
@property (weak, nonatomic) IBOutlet UIButton * findAPetButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicator;

@end

// TODO: Ability to de-select all segments of a segmented control

@implementation SearchViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)collectSearchTerms
{
  self.petSearch = [[PetSearch alloc] init];
  
  self.petSearch.locationZip = self.locationTextField.text;
  // TODO: Check location is non-empty and valid before allowing search to happen
  
  self.petSearch.type = self.petTypeSegmentedControl.selectedSegmentIndex;
  
  self.petSearch.sex = self.petSexSegmentedControl.selectedSegmentIndex;
  
  self.petSearch.size = self.petSizeSegmentedControl.selectedSegmentIndex;
  
  self.petSearch.age = self.petAgeSegmentedControl.selectedSegmentIndex;
  
  
  //  [self.petSearch.options removeAllObjects];
  //  for (UIButton * optionsButton in self.optionsButtons)
  //  {
  //    if (optionsButton.isSelected)
  //    {
  //      [self.petSearch.options addObject:[NSNumber numberWithInteger:optionsButton.tag]];
  //    }
  //  }
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
    
    self.pets = pets;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      
      [self.activityIndicator stopAnimating];
      
      [self performSegueWithIdentifier:@"showSearchResults" sender:nil];
      
    }];
    
  }];
}

- (IBAction)buttonToggled:(UIButton *)sender
{
  sender.selected = !sender.selected;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"showSearchResults"])
  {
    SearchResultsViewController * srvc = (SearchResultsViewController *)segue.destinationViewController;
    
    srvc.pets = self.pets;
    
    srvc.searchTerms = [self.petSearch searchTermsString];
  }
}

@end
