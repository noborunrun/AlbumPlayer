//
//  FirstViewController.m
//  albumPlayer
//
//  Created by noboru on 3/1/11.
//  Copyright 2011 Nine Drafts Inc.. All rights reserved.
//

#define S_HOSEI					0.95

#import <QuartzCore/QuartzCore.h>
#import "FirstViewController.h"
#import "iPodLibraryDataSource.h"

@implementation FirstViewController
@synthesize dataArray;
@synthesize albumArray;
@synthesize scrollView;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    iPLDS = [[iPodLibraryDataSource alloc] init];
    iPLDS.delegate = self;
    self.dataArray = [iPLDS getAllAlbumJacketData];
    self.scrollView.contentSize = CGSizeMake(320, 480);
	// set scroll view's background color. 
	self.scrollView.backgroundColor = [UIColor colorWithRed:(10/255) green:(74/255) blue:(12/255) alpha:1.0];

    [self setAlbumDataToScrollView];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark scrollViewContents
-(void) setAlbumDataToScrollView {
    int x = 0;
    int y = 0;
	// 補正後の画像サイズ
	float _jacket_image_ssize = JACKET_SIZE * S_HOSEI;
	float _x_y_hosei = JACKET_SIZE-_jacket_image_ssize;
    for (int i= 0; i<[dataArray count]; i++) {
        NSLog(@"%d,%d",x,y);
		// Made mask layer.
		CALayer *roundRectLayer = [CALayer layer];
		roundRectLayer.frame = CGRectMake(0, 0, _jacket_image_ssize, _jacket_image_ssize);
		UIGraphicsBeginImageContextWithOptions(CGSizeMake(_jacket_image_ssize, _jacket_image_ssize), NO, 0.0); // iOS4
		//UIGraphicsBeginImageContext(CGSizeMake(JACKET_SIZE, JACKET_SIZE)); // iOS3
		UIBezierPath *roundRectPath = [UIBezierPath bezierPathWithRoundedRect:roundRectLayer.frame cornerRadius:10.f];
		[[UIColor blackColor] setFill];
		[roundRectPath fill];
		UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		roundRectLayer.contents = (id)img.CGImage;
		
        UIImageView *aImageView = [[UIImageView alloc] initWithImage:[dataArray objectAtIndex:i]];
        aImageView.frame = CGRectMake(JACKET_SIZE * x, JACKET_SIZE * y, _jacket_image_ssize, _jacket_image_ssize);
		aImageView.layer.masksToBounds = YES;	//UIImageView's layer mask is YES.
		aImageView.layer.mask = roundRectLayer;	//Insert mask layer.
		
        [self.scrollView addSubview:aImageView];
        UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //aButton.frame = aImageView.frame;
		aButton.frame = CGRectMake(JACKET_SIZE * x, JACKET_SIZE * y, JACKET_SIZE, JACKET_SIZE);
        aButton.tag = i;
        [aButton addTarget:self action:@selector(albumTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:aButton];
        x += 1;
        if (x == 4) {
            y += 1;
            x = 0;
            self.scrollView.contentSize = CGSizeMake(320, JACKET_SIZE * y+1);
        }
    }
}

-(void)albumTapped:(id)sender {
    NSLog(@"%d",[sender tag]);
    NSDictionary *_dict = [iPLDS getAlbumSongsFromID:[self.albumArray objectAtIndex:[sender tag]]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat: @"%@",_dict] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

}

#pragma mark -
#pragma mark UITableViewDataSource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.tableDataArray count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc] init];
//    cell.imageView.image = [self.tableDataArray objectAtIndex:indexPath.row];
//    return cell;
//}



@end
