//
//  RegisterViewController.m
//  MapView
//
//  Created by Bo Wu on 16/03/2014.
//  Copyright (c) 2014 rmit. All rights reserved.
//

#import "RegisterViewController.h"
#import "RadioButton.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize registerScrolly;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [registerScrolly setScrollEnabled:YES];
}



-(void)viewDidLayoutSubviews
{
    [registerScrolly setContentSize:CGSizeMake(320, 600)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark UITextField delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // Check for non-numeric characters
    NSUInteger lengthOfString = string.length;
    for (NSInteger index = 0; index < lengthOfString; index++) {
        unichar character = [string characterAtIndex:index];
        if (character < 48) return NO; // 48 unichar for 0
        if (character > 57) return NO; // 57 unichar for 9
    }
    // Check for total length
    NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
    if (proposedNewLength > 6)
        return YES;
    return YES;
}

- (IBAction)genderBtnPress:(RadioButton*)sender {
    NSString *genderString = sender.titleLabel.text;
    NSLog(@"%ld",(long)sender.tag);
    
    
}

- (IBAction)commuterBtnPress:(RadioButton*)sender {
    NSString *commuterString=sender.titleLabel.text;
    NSLog(@"%li",(long)sender.tag);
}

- (IBAction)studentBtnPress:(RadioButton*)sender {
    NSString *studentTypeString=sender.titleLabel.text;
    NSLog(@"%li",(long)sender.tag);
}

- (IBAction)goButton:(id)sender {
   
}
@end
