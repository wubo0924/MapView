//
//  MainNavigationController.m
//  MapView
//
//  Created by Bo Wu on 11/03/2014.
//  Copyright (c) 2014 rmit. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

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
    
    //[self.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationBar setBackgroundColor:[UIColor blackColor]];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
}



@end
