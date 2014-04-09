//
//  LoginViewController.h
//  MapView
//
//  Created by Bo Wu on 10/03/2014.
//  Copyright (c) 2014 rmit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

- (IBAction)registerAction:(id)sender;
- (IBAction)loginAction:(id)sender;


@end
