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
#import "Pet.h"
#import "Contact.h"

@interface DetailViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray<NSString *> *detailPhotos;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *breadLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *optionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"thumb_default_pet"]];
    
//    UIBarButtonItem *favButton = [[UIBarButtonItem alloc]
//                                   initWithImage:[UIImage imageNamed:@"fav_button"]
//                                   style:UIBarButtonItemStyleDone
//                                   target:self
//                                   action:@selector(addFavorite)];
//    self.navigationItem.rightBarButtonItem = favButton;
    


    [self loadInfo];
}

- (void)loadInfo {
    
    self.detailPhotos = @[@"thumb_default_pet", @"fav_button", @"thumb_default_pet"];

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

    self.navigationItem.title = pet.name;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    
    cell.photo.image = [UIImage imageNamed:[self.detailPhotos objectAtIndex:indexPath.row]];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.detailPhotos.count ? self.detailPhotos.count : 0;
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
