WMNavigationProgress
==========

A progress bar at the bottom of the navigation bar as seen in the Messages.app and Safari.app

![Screenshot](https://raw.github.com/wmattelaer/WMNavigationProgress/master/screenshot.png)

## Usage

Change the class of your `UINavigationController` to `WMNavigationController` and set the progress of the `UINavigationItem` for a view controller.

```obj-c
#import "UINavigationItem+WMProgress.h"

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.navigationItem.progress = 0.5f;
}
```

## Issue

The progress bar now has a height of 3 pixels. To be completely similar to the Messages.app it should be 2.5 pixels. Using this height gives a problem when the progress bar needs to be repositioned because of a prompt of a rotation. I considered three approaches to update the position of the progress bar:

1. `autoresizingMask`: This will put the top of the progress bar 3 pixels from the bottom of the navigation bar and give the progress bar a height of 2 pixels
2. Auto Layout: This is not possible, because you are not allowed to add constraints to a `UINavigationBar`
3. `- (void)viewDidLayoutSubviews`: The height of the navigation bar has not been updated by the time this method is called.

## License

WMNavigationProgress is available under the MIT license.