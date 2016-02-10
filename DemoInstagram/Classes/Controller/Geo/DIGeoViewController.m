//
//  DIGeoViewController.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/23/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "DIGeoViewController.h"
#import "DIUserModel.h"
#import "DIMediaApiClient.h"
#import "DIUuidPaginationObject.h"
#import "DIPaginationModel.h"
#import "DIProfileInfoProtocol.h"
#import "DIMediaModel.h"
#import "DIImagesModel.h"
#import "NSArray+DIMapAnnotation.h"
#import "DIMapAnnotation.h"
#import "DIImageDataModel.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import "UIImage+DIImageWithSize.h"
#import "DIPostDetailViewController.h"

@interface DIGeoViewController ()<DIProfileInfoProtocol, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) DIUserModel *user;
@property (copy, nonatomic) MediaListSuccessBlock mediaListSuccessBlock;
@property (copy, nonatomic) Failure failure;
@property (strong, nonatomic) DIUuidPaginationObject *paginationObject;
@end

@implementation DIGeoViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setup

- (void)setup {
    [self data];
}

- (void)data {
    self.paginationObject = [[DIUuidPaginationObject alloc] init];
    self.paginationObject.list = [NSMutableArray new];
    
    @weakify(self);
    self.paginationObject.onPaginationLoadingBlock = ^(){
        @strongify(self);
        
        if (self.user) {
            self.paginationObject.uuid = self.user.idKey;
            [[DIMediaApiClient client] userMedia:self.paginationObject
                                         success:self.mediaListSuccessBlock
                                         failure:self.failure];
        } else {
            [[DIMediaApiClient client] myMedia:self.mediaListSuccessBlock
                                       failure:self.failure];
        }
    };
    
    self.paginationObject.onPaginationLoadingBlock();
}

#pragma mark - Custom Getters

- (MediaListSuccessBlock)mediaListSuccessBlock {
    if (!_mediaListSuccessBlock) {
        @weakify(self);
        _mediaListSuccessBlock = ^(NSArray<DIMediaModel *> *list, DIPaginationModel *pagination){
            @strongify(self);
            self.paginationObject.nextUrl = pagination.next;
            [self.paginationObject.list addObjectsFromArray:list];
            self.paginationObject.lowThanStep = pagination.next ? NO : YES;
            
            [self prepareLocationList:list];
            
            if (!self.paginationObject.lowThanStep) {
                if (self.paginationObject.onPaginationLoadingBlock) {
                    self.paginationObject.onPaginationLoadingBlock();
                }
            }
        };
    }
    return _mediaListSuccessBlock;
}

- (Failure)failure {
    if (!_failure) {
        _failure = ^(id error) {
        };
    }
    return _failure;
}

#pragma mark - Common

- (void)prepareLocationList:(NSArray<DIMediaModel *> *)list {
    [[NSOperationQueue new] addOperationWithBlock:^{
        id predicate = [NSPredicate predicateWithBlock:
                        ^BOOL(DIMediaModel * _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                            BOOL locationPresent = evaluatedObject.location;
                            return locationPresent;
                        }];        
        [self displayLocationList:[list filteredArrayUsingPredicate:predicate]];
    }];
}

- (void)displayLocationList:(NSArray<DIMediaModel *> *)list {
    @weakify(self);
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        @strongify(self);
        NSLog(@"%lu", (unsigned long)list.count);
        [self.map addAnnotations:[list mapAnnotationList]];
    }];
}

#pragma mark - MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(DIMapAnnotation *)annotation {
    MKAnnotationView *annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
   [annotation.post.images.low_resolution image:^(UIImage *image) {
       annotationView.image = image;
   }];
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    DIMapAnnotation *annotation = view.annotation;
    [self showPostDetail:annotation.post];
}

#pragma mark - Navigation

- (void)showPostDetail:(DIMediaModel *)model {
    DIPostDetailViewController *vc = [[DIPostDetailViewController alloc] initWithNibName:@"DIPostDetailViewController" bundle:nil];
    vc.post = model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end