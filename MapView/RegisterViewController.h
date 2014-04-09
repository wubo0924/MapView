//
//  RegisterViewController.h
//  MapView
//
//  Created by Bo Wu on 16/03/2014.
//  Copyright (c) 2014 rmit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RadioButton;

@interface RegisterViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *registerScrolly;
@property (strong, nonatomic) IBOutlet RadioButton *maleButton;
@property (strong, nonatomic) IBOutlet RadioButton *commuterButton;
@property (strong, nonatomic) IBOutlet RadioButton *studentButton;


@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *occupation;
@property (weak, nonatomic) NSString *gender;
@property (assign, nonatomic) int *commuterType;
@property (assign, nonatomic) int *studentType;
@property (weak, nonatomic) IBOutlet UILabel *promptBox;

- (IBAction)genderBtnPress:(id)sender;
- (IBAction)commuterBtnPress:(id)sender;
- (IBAction)studentBtnPress:(id)sender;

- (IBAction)goButton:(id)sender;

@end
