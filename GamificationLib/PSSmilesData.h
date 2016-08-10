//
//  PSSmilesData.h
//  GamificationLib
//
//  Created by Raheel Ahmad on 8/10/16.
//  Copyright © 2016 EurekaTechStudio. All rights reserved.
//

#import "PSAPI.h"
#import "PSSmiles.h"


@protocol PSSmiles
@end

@interface PSSmilesData : PSAPI

@property (nonatomic, strong) NSNumber<Optional> *current_smiles;
@property (nonatomic, strong) NSNumber<Optional> *expired_smiles;
@property (nonatomic, strong) NSArray<PSSmiles,Optional> *smiles;

@end
