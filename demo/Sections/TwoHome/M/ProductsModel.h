//
//  ProductsModel.h
//  demo
//
//  Created by wertyu on 17/5/19.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductsModel : NSObject
@property (nonatomic, copy) NSString *itemType;

@property (nonatomic, assign) NSInteger collectStatus;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) NSInteger authentic;

@property (nonatomic, copy) NSString *specHeight;       //H

@property (nonatomic, copy) NSString *specLength;       //D

@property (nonatomic, copy) NSString *productStyle;

@property (nonatomic, copy) NSString *brandPicUri;

@property (nonatomic, copy) NSString *productId;

@property (nonatomic, copy) NSString *productColor;

@property (nonatomic, copy) NSString *productType;

@property (nonatomic, copy) NSString *ezgstatus;

@property (nonatomic, copy) NSString *brandName;   //品牌名

@property (nonatomic, copy) NSString *brandId;

@property (nonatomic, assign) NSInteger productStocks;      //库存

@property (nonatomic, copy) NSString *lightSourceCount;

@property (nonatomic, copy) NSString *productNum;

@property (nonatomic, copy) NSString *specWidth;    //W

@property (nonatomic, copy) NSString *cartId;

@property (nonatomic, assign) NSInteger productQty;

@property (nonatomic, assign) NSInteger originPrice;        //零售价

@property (nonatomic, copy) NSString *productMade;

@property (nonatomic, assign) NSInteger productPrice;       //批发价

@property (nonatomic, copy) NSString *dealerpurchaseprice;

@property (nonatomic, copy) NSString *addDate;

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSString *productPicUri;   //图片url

@property (nonatomic, strong) NSArray *productDetailPicUirs;

@property (nonatomic, copy) NSString *cartType;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *applicableRegion;

@property(nonatomic, assign)BOOL isSelected;

@end
