//
//  SearchViewController.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "SearchViewController.h"
#import "PetSearch.h"

@interface SearchViewController ()

@property (nonatomic) PetSearch * petSearch;

@property (weak, nonatomic) IBOutlet UISegmentedControl * petTypeSegmentedControl;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * sexButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * sizeButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * ageButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * optionsButtons;

@end


@implementation SearchViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.petSearch = [[PetSearch alloc] init];
  self.petSearch.type = PetTypeDog;
}

- (void)collectSearchTerms
{
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
  [self collectSearchTerms];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"showSearchResults"])
  {
    self.petSearch.locationZip = @"M5T2V4";
    
    // TODO: Use petSearch with NetworkManager method to get array of Pet objects with given search terms
    
    // TODO: Pass Pet array to destination VC
  }
}

@end
