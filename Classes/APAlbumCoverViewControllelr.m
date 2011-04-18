//
//  FirstViewController.m
//  albumPlayer
//
//  Created by noboru on 3/1/11.
//  Copyright 2011 Nine Drafts Inc.. All rights reserved.
//

#define S_HOSEI					0.95
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0];

#import <QuartzCore/QuartzCore.h>
#import "APAlbumCoverViewControllelr.h"
#import "APiPodLibraryDataSource.h"

@implementation APAlbumCoverViewControllelr
@synthesize dataArray;
//@synthesize albumArray;
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
    iPLDS = [[APiPodLibraryDataSource alloc] init];
    iPLDS.delegate = self;
    self.dataArray = [iPLDS getAllAlbumJacketData];
    self.scrollView.contentSize = CGSizeMake(320, 480);
	// set scroll view's background color. 
    
	self.scrollView.backgroundColor = HEXCOLOR(0x2a4820);
    //self.scrollView.backgroundColor = [UIColor whiteColor];
    
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

static BOOL _albumThreadRunning;
static NSMutableArray *_albumQueue;

- (void)loadAlbumInBackground {
    [CATransaction lock];
    if (!_albumThreadRunning) {
        [NSThread detachNewThreadSelector:@selector(albumThread:) toTarget:self withObject:nil];
        _albumThreadRunning = YES;
    }
    [CATransaction unlock];
}

- (void)albumThread:(id)unused {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    [CATransaction lock];
    int x = 0;
    int y = 0;
    float _jacket_image_ssize = JACKET_SIZE * S_HOSEI;
//	float _x_y_hosei = JACKET_SIZE-_jacket_image_ssize;
    

    for (int i = 0; i < [dataArray count]; i++) {
        CALayer *roundRectLayer = [CALayer layer];
        roundRectLayer.frame = CGRectMake(0, 0, _jacket_image_ssize, _jacket_image_ssize);
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(_jacket_image_ssize, _jacket_image_ssize), NO, 0.f);
        UIBezierPath *roundRectPath = [UIBezierPath bezierPathWithRoundedRect:roundRectLayer.frame cornerRadius:10.f];
        [[UIColor blackColor] setFill];
        [roundRectPath fill];
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        roundRectLayer.contents = (id)img.CGImage;

        
        UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aButton.frame = CGRectMake(JACKET_SIZE * x, JACKET_SIZE * y, _jacket_image_ssize, _jacket_image_ssize);

        [CATransaction unlock];
        CALayer *albumLayer = [CALayer layer];
        [albumLayer setFrame:CGRectMake(0, 0, aButton.frame.size.width, aButton.frame.size.height)];
        [albumLayer setBackgroundColor:[UIColor clearColor].CGColor];
        UIImage *aimg = [dataArray objectAtIndex:i];
        [albumLayer setContents:(id)aimg.CGImage];
        albumLayer.masksToBounds = YES;
        albumLayer.mask = roundRectLayer;
        [aButton.layer addSublayer:albumLayer];
        aButton.layer.shadowColor = [UIColor blackColor].CGColor;
        aButton.layer.shadowOpacity = 1.f;
        aButton.layer.shadowOffset = CGSizeMake(0.f, 0.f);
        aButton.layer.shadowRadius = 4.f;
        [CATransaction flush];
        [CATransaction lock];
        
        aButton.tag = i;
        [aButton addTarget:self action:@selector(albumTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:aButton];
        x += 1;
        if (x == 4) {
            y += 1;
            x = 0;
            
        }
        NSInteger idx = [_albumQueue indexOfObjectIdenticalTo:dataArray];
        if (idx != NSNotFound) {
            [_albumQueue removeObjectAtIndex:idx];
        }
    }
    self.scrollView.contentSize = CGSizeMake(320, JACKET_SIZE * y+1);
    _albumThreadRunning = NO;
    [CATransaction unlock];
    [pool drain];

}

#pragma mark -
#pragma mark scrollViewContents
-(void) setAlbumDataToScrollView
{
    if (!_albumQueue) {
        _albumQueue = [[NSMutableArray alloc] init];
    }
    if ([_albumQueue indexOfObjectIdenticalTo:dataArray] == NSNotFound) {
        [_albumQueue setArray:dataArray];
    }
    [self loadAlbumInBackground];
    
}

-(void)albumTapped:(id)sender {
    NSLog(@"%d",[sender tag]);
//    NSDictionary *_dict = [iPLDS getAlbumSongsFromID:[self.albumArray objectAtIndex:[sender tag]]];
    NSDictionary *_dict = [iPLDS getAlbumSongsFromID:[sender tag]];
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
