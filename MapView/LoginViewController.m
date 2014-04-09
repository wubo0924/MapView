//
//  LoginViewController.m
//  MapView
//
//  Created by Bo Wu on 10/03/2014.
//  Copyright (c) 2014 rmit. All rights reserved.
//

#import "LoginViewController.h"
#import "WebServiceRequest.h"

@interface LoginViewController ()



@end

@implementation LoginViewController
{
    WebServiceRequest *wsr;
}

@synthesize username;
@synthesize password;

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
    
    wsr = [WebServiceRequest new];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(0, 0, 40, 40)];
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_listview_new.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(displayView:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTag:1];
    
    UIButton *button2= [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setFrame:CGRectMake(0, 0, 40, 40)];
    [button2 setBackgroundImage:[UIImage imageNamed:@"icon_mapview.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(displayView:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTag:2];
    
    UIButton *button3= [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setFrame:CGRectMake(0, 0, 40, 40)];
    [button3 setBackgroundImage:[UIImage imageNamed:@"icon_login.png"] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(displayView:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setTag:3];
    
    UIButton *button4= [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setFrame:CGRectMake(0, 0, 40, 40)];
    [button4 setBackgroundImage:[UIImage imageNamed:@"icon_info.png"] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(displayView:) forControlEvents:UIControlEventTouchUpInside];
    [button4 setTag:4];
    
    UIBarButtonItem *listButton = [[UIBarButtonItem alloc] initWithCustomView:button1];
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithCustomView:button2];
    UIBarButtonItem *loginButton=[[UIBarButtonItem alloc] initWithCustomView:button3];
    UIBarButtonItem *infoButton=[[UIBarButtonItem alloc] initWithCustomView:button4];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:infoButton,loginButton,mapButton,listButton,nil];

	
}


-(IBAction)displayView:(id)sender
{
    NSInteger tag = [sender tag];
    if(tag==2){
        [self performSegueWithIdentifier:@"mapViewSegue" sender:sender];
        return;
    }
    if(tag==4){
        /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INFO" message:@"LIST VIEW - to fill out a survey\nMAP VIEW - to see other places that have been surveyed\nView Participant Terms & Conditions? Clicking YES will open a PDF, please allow pop-ups to view it." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];*/
        [self performSegueWithIdentifier:@"infoViewSegue" sender:sender];
        return;
    }
    if(tag==1){
        [self performSegueWithIdentifier:@"listViewSegue" sender:sender];
        return;
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerAction:(id)sender {
    
}

- (IBAction)loginAction:(id)sender {
    
    BOOL *loginStatus = [wsr wsLoginWithUsername:[username text] password:[password text]];
    if(loginStatus){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Username or Password is not correct" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
       
        [alert show];
    }
}

@end
