//
//  FirstViewController.h
//  albumPlayer
//
//  Created by noboru on 3/1/11.

//  Copyright 2011 Nine Drafts Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPodLibraryDataSource.h"

#define JACKET_SIZE 80

@interface FirstViewController : UIViewController <UIScrollViewDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSArray *dataArray;
    NSArray *albumArray;
    UIScrollView *scrollView;
    iPodLibraryDataSource *iPLDS;
}
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) NSArray *albumArray;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@end
