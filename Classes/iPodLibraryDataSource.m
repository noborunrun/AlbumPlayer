//
//  iPodLibraryDataSource.m
//  albumPlayer
//
//  Created by noboru on 3/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "iPodLibraryDataSource.h"


@implementation iPodLibraryDataSource
@synthesize delegate;

-(NSMutableArray *)getAllAlbumJacketData {
    NSMutableArray *_array = [[NSMutableArray alloc] init];
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    NSArray *_albums = [[albumQuery collections] retain];
    
    if ([_albums count] == 0) {
        return _array;
    }else {
        [self.delegate setAlbumArray:_albums];
        int jacketCount = 0;
        for (int i = 0; i < [_albums count]; i++) {
            MPMediaItemCollection *collection = [_albums objectAtIndex:i];
            MPMediaItem *artwork = collection.representativeItem;
            if ([artwork valueForProperty:MPMediaItemPropertyArtwork]) {
                [_array insertObject:[[artwork valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(JACKET_SIZE, JACKET_SIZE)] atIndex:jacketCount];
            }else {
                [_array insertObject:[UIImage imageNamed:@"nonimage.png"] atIndex:jacketCount];
            }
            jacketCount += 1;
        }
        return _array;
    }
}

-(NSMutableDictionary *) getAlbumSongsFromID:(MPMediaItemCollection *)collection {
    NSMutableDictionary *_dict =[[NSMutableDictionary alloc] init];
    MPMediaItem *album = collection.representativeItem;
    NSString *albumTitle = [album valueForProperty:MPMediaItemPropertyAlbumTitle];
    NSLog(@"%@",albumTitle);
    [_dict setObject:albumTitle forKey:@"AlbumTitle"];
    return _dict;
}
@end
