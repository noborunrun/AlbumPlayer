//
//  FirstViewController.h
//  albumPlayer
//
//  Created by noboru on 3/1/11.
<<<<<<< HEAD
//  Copyright 2011 Nine Drafts Inc.. All rights reserved.
=======
//  Copyright 2011 __MyCompanyName__. All rights reserved.
>>>>>>> 6388c4015518040650d8f044823446986b52a6c6
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
