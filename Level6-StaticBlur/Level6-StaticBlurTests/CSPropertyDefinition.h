//
//  CSPropertyDefinition.h
//  ChallengePhotoModel
//
//  Created by Eric Allam on 2/22/13.
//  Copyright (c) 2013 Code School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface CSPropertyDefinition : NSObject {
    NSArray *propertyAttributes;
}

+(instancetype)firstPropertyWithEncoding:(const char *)encodingString forClass:(id)klass;
+(instancetype)firstPropertyWithType:(NSString *)typeAsString forClass:(id)klass;
-(instancetype)initWithProperty:(objc_property_t)property;
-(BOOL)hasType:(NSString *)typeAsString;
-(BOOL)isWeak;
-(BOOL)isStrong;
-(BOOL)isNonAtomic;
-(BOOL)isAtomic;

@property (nonatomic) objc_property_t propertyDefinition;
@property (nonatomic, readonly) NSString *name;
@end
