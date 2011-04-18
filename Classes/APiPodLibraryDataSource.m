//
//  iPodLibraryDataSource.m
//  albumPlayer
//
//  Created by noboru on 3/1/11.
//  Copyright 2011 Nine Drafts Inc.. All rights reserved.
//

#import "APiPodLibraryDataSource.h"
#import "FirstViewController.h"

@implementation APiPodLibraryDataSource
@synthesize delegate;

-(NSMutableArray *)getAllAlbumJacketData {
    NSMutableArray *_array = [[NSMutableArray alloc] init];
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    [albumQuery setGroupingType:MPMediaGroupingAlbum];
    albums = [albumQuery collections];
    
    if ([albums count] == 0) {
        return _array;
    }else {
//        self.delegate.albumArray = albums;
        int jacketCount = 0;
        for (int i = 0; i < [albums count]; i++) {
            MPMediaItemCollection *collection = [albums objectAtIndex:i];
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

//-(NSMutableDictionary *) getAlbumSongsFromID:(MPMediaItemCollection *)collection
-(NSMutableDictionary *) getAlbumSongsFromID:(NSInteger)albumId
{
    NSMutableDictionary *_dict =[[NSMutableDictionary alloc] init];
//    MPMediaItem *album = collection.representativeItem;
    NSString *albumTitle = [[[albums objectAtIndex:albumId] representativeItem] valueForProperty:MPMediaItemPropertyAlbumTitle];
    NSLog(@"%@",albumTitle);
    [_dict setObject:albumTitle forKey:@"AlbumTitle"];
    return _dict;
}
@end
