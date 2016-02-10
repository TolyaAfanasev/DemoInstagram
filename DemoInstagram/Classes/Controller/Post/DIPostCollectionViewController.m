//
//  DIPostCollectionViewController.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 12/24/15.
//  Copyright © 2015 Anatoliy Afanasev. All rights reserved.
//

#import "DIPostCollectionViewController.h"
#import "DICellSizeManager.h"
#import "DIUuidPaginationObject.h"
#import "DIPostCollectionViewCell.h"
#import "DIMediaModel.h"
#import "DIMediaApiClient.h"
#import "DIProfileInfoProtocol.h"
#import "DIUserModel.h"
#import "DIPaginationModel.h"
#import "DILoadDataState.h"
#import "DILoadingCollectionReusableView.h"
#import "DIPostDetailViewController.h"

@interface DIPostCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DIProfileInfoProtocol>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) DICellSizeManager *cellSizeManager;
@property (strong, nonatomic) DIUuidPaginationObject *paginationObject;
@property (strong, nonatomic) DIUserModel *user;
@property (copy, nonatomic) MediaListSuccessBlock mediaListSuccessBlock;
@property (copy, nonatomic) Failure failure;
@property (assign, nonatomic) DILoadDataState dataState;
@end

@implementation DIPostCollectionViewController

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
    [self setupCollectionView];
    [self loadData];
}

#pragma mark - Data

- (void)loadData {
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

- (MediaListSuccessBlock)mediaListSuccessBlock {
    if (!_mediaListSuccessBlock) {
        @weakify(self);
        _mediaListSuccessBlock = ^(NSArray<DIMediaModel *> *list, DIPaginationModel *pagination){
            @strongify(self);
            self.paginationObject.nextUrl = pagination.next;
            [self.paginationObject.list addObjectsFromArray:list];
            self.paginationObject.lowThanStep = pagination.next ? NO : YES;
            self.dataState = DILoadDataStateComplete;
            [self.collectionView reloadData];
        };
    }
    return _mediaListSuccessBlock;
}

- (Failure)failure {
    if (!_failure) {
        @weakify(self);
        _failure = ^(id error) {
            @strongify(self);
            self.dataState = DILoadDataStateConnectionError;
            [self.collectionView reloadData];
        };
    }
    return _failure;
}

- (DICellSizeManager *)cellSizeManager {
    if (!_cellSizeManager) {
        _cellSizeManager = [[DICellSizeManager alloc]init];
    }
    return _cellSizeManager;
}

#pragma mark - Controller Initialization

- (void)setupCollectionView{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DIPostCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([DIPostCollectionViewCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DILoadingCollectionReusableView class]) bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                 withReuseIdentifier:NSStringFromClass([DILoadingCollectionReusableView class])];
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellSizeManager getCollectionViewCellSize:collectionView];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DIPostDetailViewController *vc = [[DIPostDetailViewController alloc] initWithNibName:@"DIPostDetailViewController" bundle:nil];
    vc.post = self.paginationObject.list[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    if (self.paginationObject.list.count == 0) {
        
    } else {
        edgeInsets = UIEdgeInsetsMake(kContentMargine, kContentMargine, kContentMargine, kContentMargine);
    }
    return edgeInsets;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGSize size = CGSizeZero;
    if (self.paginationObject.list.count == 0) {
        size = CGSizeMake(collectionView.bounds.size.width, collectionView.bounds.size.height);
    } else if (!self.paginationObject.lowThanStep){
        size = CGSizeMake(collectionView.bounds.size.width, 44.0f);
    }
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.paginationObject ? self.paginationObject.list.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DIPostCollectionViewCell *storeCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DIPostCollectionViewCell class])
                                                                                    forIndexPath:indexPath];;
    DIMediaModel *media = self.paginationObject.list[indexPath.row];
    storeCell.media = media;
    return storeCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionFooter) {
        if ([self.self.paginationObject.list count] == 0) {
            switch (self.dataState) {
                case DILoadDataStateInProcess:
                case DILoadDataStateComplete:
                case DILoadDataStateNoData:
                    reusableView = [self getLoadingView:collectionView atIndexPath:indexPath startLoad:NO];
                    break;
                    
                case DILoadDataStateConnectionError:
                    reusableView = [self getLoadingView:collectionView atIndexPath:indexPath startLoad:YES];
                    break;
                    
                default:
                    break;
            }
            
        } else {
            reusableView = [self getLoadingView:collectionView atIndexPath:indexPath startLoad:YES];
        }
    }
    return reusableView;
}

- (UICollectionReusableView *)getLoadingView:(UICollectionView *)collectionView
                                 atIndexPath:(NSIndexPath *)indexPath
                                   startLoad:(BOOL)startLoad{
    NSString *identifier = NSStringFromClass([DILoadingCollectionReusableView class]);
    DILoadingCollectionReusableView *loadingReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                    withReuseIdentifier:identifier
                                                                                           forIndexPath:indexPath];
    loadingReusableView.activityIndicator.hidden = NO;
    [loadingReusableView.activityIndicator startAnimating];
    
    if (self.paginationObject) {
        @weakify(self);
        loadingReusableView.onShowLoadingBlock = (^(DILoadingCollectionReusableView *view){
            @strongify(self);
            if (self.paginationObject) {
                self.paginationObject.onPaginationLoadingBlock();
            }
        });
        
        if (startLoad) {
            loadingReusableView.onShowLoadingBlock(loadingReusableView);
        } else {
            [loadingReusableView.activityIndicator stopAnimating];
        }
    }
    return loadingReusableView;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end