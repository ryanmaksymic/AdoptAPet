//
//  DetailViewController.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCollectionViewCell.h"
#import "NetworkManager.h"
#import "DataManager.h"
#import "Pet.h"
#import "Contact.h"

@interface DetailViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *breadLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *optionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
// TODO: Add ageLabel

@end

@implementation DetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadInfo];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.pet.isFavorite = [DataManager checkPet:self.pet.idNumber];
  [self loadInfo];
  self.navigationItem.rightBarButtonItem.image = [self imgFavorite:self.pet.isFavorite];
}

- (void)favorite {
  [DataManager favorite:self.pet];
//  self.pet.isFavorite = !self.pet.isFavorite;
  self.navigationItem.rightBarButtonItem.image = [self imgFavorite:self.pet.isFavorite];
}

- (UIImage *)imgFavorite:(BOOL)is {
  return is ? [UIImage imageNamed:@"fav_button2"] : [UIImage imageNamed:@"fav_button"];
}

- (void)loadInfo {
  
  self.collectionView.delegate = self;
  self.descriptionLabel.text = self.pet.petDescription;
  self.sizeLabel.text = [self.pet sizeString];
  self.sexLabel.text = [self.pet sexString];
  self.breadLabel.text = [NSString stringWithFormat:@"%@ %@", [self.pet breedsString], self.pet.mix ? @" | Mixed" : @""];
  self.locationLabel.text = [NSString stringWithFormat:@"%@, %@", self.pet.contact.city, self.pet.contact.state];
  self.dateLabel.text = [NSString stringWithFormat:@"Last updated: %@", [self.pet lastUpdatedString]];
  self.optionsLabel.text = [self.pet optionsString];
  self.contactLabel.text = [self.pet contactString];
  
  
}

- (void)setPet:(Pet *)pet {
  _pet = pet;
  if (pet.photos.count < pet.photoURLs.count) {
    for (NSInteger i = pet.photos.count; i < pet.photoURLs.count; i++) {
      [NetworkManager fetchImageFileFromURL:self.pet.photoURLs[i] completionHandler:^(UIImage * image) {
        [_pet.photos addObject:image];
      }];

    }
  }
  
  self.navigationItem.title = pet.name;
  UIBarButtonItem *favButton = [[UIBarButtonItem alloc]
                                initWithImage:[self imgFavorite:pet.isFavorite]
                                style:UIBarButtonItemStyleDone
                                target:self
                                action:@selector(favorite)];
  self.navigationItem.rightBarButtonItem = favButton;
  
}

 #pragma mark - Navigation

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
  DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
  
  cell.photo.image = self.pet.photos[indexPath.item];
  
  return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.pet.photoURLs.count ? self.pet.photoURLs.count : 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return self.collectionView.frame.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  return 0.0;
}

@end
