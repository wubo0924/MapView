//
//  TSVenueSurveyViewController.h
//  iTranSafe
//
//  Created by Nishant Sony on 16/03/2014.
//  Copyright (c) 2014 ENVIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSVenueSurveyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *VenueLabel;
@property (weak, nonatomic) IBOutlet UISlider *sad_happy;
@property (weak,nonatomic) NSString *nameStr;
@property (weak,nonatomic) NSString *foursquareID;

@property (weak, nonatomic) IBOutlet UISlider *bored_excited;
@property (weak, nonatomic) IBOutlet UISlider *scared_safe;
@property (weak, nonatomic) IBOutlet UISlider *angry_peaceful;


- (IBAction)Submit:(id)sender;

@end
