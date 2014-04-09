//
//  TSComfortViewController.h
//  iTranSafe
//
//  Created by Nishant Sony on 23/03/2014.
//  Copyright (c) 2014 ENVIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSComfortViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISlider *hot_cold;
@property (weak, nonatomic) IBOutlet UISlider *crowded_empty;
@property (weak, nonatomic) IBOutlet UISlider *noisy_quiet;
@property (weak, nonatomic) IBOutlet UISlider *overallcomfort;
@property (weak, nonatomic) NSString *surveyID;
- (IBAction)submitButton:(id)sender;
@property (weak,nonatomic) NSString *namestr;

@property(nonatomic,strong) NSString *locationID;

@end
