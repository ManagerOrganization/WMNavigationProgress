//
//  WMNavigationController.m
//  WMNavigationProgress
//
//  Created by Willem Mattelaer on 24/03/14.
//  Copyright (c) 2014 Willem Mattelaer. All rights reserved.
//

#import "WMNavigationController.h"

#import "WMProgressView.h"
#import "UINavigationItem+WMProgress.h"

@interface WMNavigationController ()

@property (nonatomic, strong) WMProgressView *progressView;

@property (nonatomic) NSInteger numberOfViewControllersAtStartOfPop;

@end

@implementation WMNavigationController

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
	
	self.progressView = [[WMProgressView alloc] initWithFrame:CGRectMake(0, self.navigationBar.bounds.size.height - 3, self.navigationBar.bounds.size.width, 3)];
	self.progressView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
	self.progressView.progress = 0.0f;
	[self.navigationBar addSubview:self.progressView];
	
	if (self.viewControllers.count > 0) {
		UINavigationItem *item = [[self.viewControllers lastObject] navigationItem];
		[item addObserver:self forKeyPath:@"progress" options:0 context:NULL];
	}
	
	[self.interactivePopGestureRecognizer addTarget:self action:@selector(popGestureChanged:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation methods

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
	UINavigationItem *oldItem = [[self.viewControllers lastObject] navigationItem];
	UINavigationItem *newItem = [viewController navigationItem];
	[super pushViewController:viewController animated:animated];
	
	[self updateProgressViewFromNavigationItem:oldItem toNavigationItem:newItem animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
	UIViewController *oldController = [super popViewControllerAnimated:animated];
	UINavigationItem *oldItem = oldController.navigationItem;
	UINavigationItem *newItem = [[self.viewControllers lastObject] navigationItem];
	
	[self updateProgressViewFromNavigationItem:oldItem toNavigationItem:newItem animated:animated];
	
	return oldController;
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
	UINavigationItem *oldItem = [[self.viewControllers lastObject] navigationItem];
	UINavigationItem *newItem = [viewController navigationItem];
	
	NSArray *result = [super popToViewController:viewController animated:animated];
	
	[self updateProgressViewFromNavigationItem:oldItem toNavigationItem:newItem animated:animated];
	
	return result;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
	UINavigationItem *oldItem = [[self.viewControllers lastObject] navigationItem];
	UINavigationItem *newItem = [self.viewControllers[0] navigationItem];
	
	NSArray *result = [super popToRootViewControllerAnimated:animated];
	
	[self updateProgressViewFromNavigationItem:oldItem toNavigationItem:newItem animated:animated];
	
	return result;
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated {
	if (self.viewControllers.count > 0) {
		UINavigationItem *item = [[self.viewControllers lastObject] navigationItem];
		[item removeObserver:self forKeyPath:@"progress"];
	}
	
	[super setViewControllers:viewControllers animated:animated];
	
	if (self.viewControllers.count > 0) {
		UINavigationItem *item = [[self.viewControllers lastObject] navigationItem];
		[item addObserver:self forKeyPath:@"progress" options:0 context:NULL];
	}
}

#pragma mark - Progress view

- (void)updateProgressViewFromNavigationItem:(UINavigationItem *)oldItem toNavigationItem:(UINavigationItem *)newItem animated:(BOOL)animated {
	[oldItem removeObserver:self forKeyPath:@"progress"];
	[newItem addObserver:self forKeyPath:@"progress" options:0 context:NULL];
	
	if (animated) {
		if (newItem.progress == 0) {
			[UIView animateWithDuration:0.3f animations:^{
				self.progressView.alpha = 0;
			} completion:^(BOOL finished) {
				if (newItem.progress == 0) {
					self.progressView.progress = 0;
				}
				self.progressView.alpha = 1;
			}];
		} else {
			if (oldItem.progress == 0) {
				self.progressView.progress = newItem.progress;
				self.progressView.alpha = 0;
				[UIView animateWithDuration:0.3f animations:^{
					self.progressView.alpha = 1;
				}];
			} else {
				[self.progressView setProgress:newItem.progress animated:YES];
			}
		}
	} else {
		self.progressView.progress = newItem.progress;
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"progress"]) {
		[self.progressView setProgress:[[[self.viewControllers lastObject] navigationItem] progress] animated:YES];
		self.progressView.alpha = 1;
	}
}

#pragma mark - Interactive pop gesture

- (void)popGestureChanged:(UIGestureRecognizer *)popGesture {
	if (popGesture.state == UIGestureRecognizerStateBegan) {
		self.numberOfViewControllersAtStartOfPop = self.viewControllers.count;
	} else if (popGesture.state == UIGestureRecognizerStateEnded) {
		[self performSelector:@selector(uglyButNecessarySolution) withObject:nil afterDelay:0.05f];
	} else if (popGesture.state == UIGestureRecognizerStateCancelled) {
		[self performSelector:@selector(uglyButNecessarySolution) withObject:nil afterDelay:0.05f];
	}
}

- (void)uglyButNecessarySolution {
	if (self.numberOfViewControllersAtStartOfPop < self.viewControllers.count) {
		UINavigationItem *newItem = [[self.viewControllers lastObject] navigationItem];
		UINavigationItem *oldItem = [self.viewControllers[self.viewControllers.count-2] navigationItem];
		
		[self updateProgressViewFromNavigationItem:oldItem toNavigationItem:newItem animated:YES];
	}
}

@end
