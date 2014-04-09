//
//  InfoViewController.m
//  MapView
//
//  Created by Bo Wu on 18/03/2014.
//  Copyright (c) 2014 rmit. All rights reserved.
//

#import "InfoViewController.h"
#import "KeychainItemWrapper.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

@synthesize pdfWebView;

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
    
    
    pdfWebView.autoresizesSubviews = YES;
    pdfWebView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    
    NSURL *myUrl = [NSURL URLWithString:@"http://florasalim.com/contentfiles/uploads/2014/pdf/PTV_Participant_Information_final.pdf"];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:myUrl];
    
    [pdfWebView loadRequest:myRequest];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)displayView:(id)sender
{
    NSInteger tag = [sender tag];
    if(tag==1){
        /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INFO" message:@"LIST VIEW - to fill out a survey\nMAP VIEW - to see other places that have been surveyed\nView Participant Terms & Conditions? Clicking YES will open a PDF, please allow pop-ups to view it." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];*/
        [self performSegueWithIdentifier:@"listViewSegue" sender:sender];
        return;
    }

    if(tag==2){
        [self performSegueWithIdentifier:@"mapViewSegue" sender:sender];
        return;
    }
        if(tag==3){
            KeychainItemWrapper *keychain =[[KeychainItemWrapper alloc] initWithIdentifier:@"au.edu.rmit.s3363780.MapView" accessGroup:nil];
            NSString *secattrValue=[keychain objectForKey:(__bridge id)kSecAttrService];
            NSString *secvaluedata=[keychain objectForKey:(__bridge id)kSecValueData];
            NSString *secattraccount=[keychain objectForKey:(__bridge id)kSecAttrAccount];
            
            
            
            if(secattraccount!=nil && ![secattraccount isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User Identify" message:@"You have logged in already\n Do you want to log off?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                [alert show];
            }else{
                [self performSegueWithIdentifier:@"loginViewSegue" sender:sender];
            }
            
            return;    }
    
    
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%i",buttonIndex);
    if(buttonIndex==1){
        KeychainItemWrapper *keychain =[[KeychainItemWrapper alloc] initWithIdentifier:@"au.edu.rmit.s3363780.MapView" accessGroup:nil];
        [keychain resetKeychainItem];
    }
}

@end
