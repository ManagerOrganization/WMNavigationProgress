//
//  WMDetailViewController.m
//  PullToRefreshNav
//
//  Created by Willem Mattelaer on 23/03/14.
//  Copyright (c) 2014 Willem Mattelaer. All rights reserved.
//

#import "WMDetailViewController.h"

#import "UINavigationItem+WMProgress.h"

@interface WMDetailViewController ()

@end

@implementation WMDetailViewController

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
    // Do any additional setup after loading the view.
	
	self.navigationItem.progress = 0.5f;
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

@end
