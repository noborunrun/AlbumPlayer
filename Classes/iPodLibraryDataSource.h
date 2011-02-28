//
//  iPodLibraryDataSource.h
//  albumPlayer
//
//  Created by noboru on 3/1/11.
//  Copyright 2011 Nine Drafts Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

#define JACKET_SIZE 80

@class FirstViewController;

@interface iPodLibraryDataSource : NSObject {
    FirstViewController *delegate;
}

@property (nonatomic, retain) FirstViewController *delegate;

-(NSMutableArray *)getAllAlbumJacketData;

@end
