//
//  FirstViewController.h
//  albumPlayer
//
//  Created by noboru on 3/1/11.

//  Copyright 2011 Nine Drafts Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JACKET_SIZE 80

@class APiPodLibraryDataSource;

@interface APAlbumCoverViewControllelr : UIViewController <UIScrollViewDelegate>{
    NSArray *dataArray;
//    NSArray *albumArray;
    UIScrollView *scrollView;
    APiPodLibraryDataSource *iPLDS;
}
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) NSArray *albumArray;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

-(void) setAlbumDataToScrollView;
-(void)albumTapped:(id)sender;

@end
