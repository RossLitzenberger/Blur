//
//  CSPropertyDefinition.m
//  ChallengePhotoModel
//
//  Created by Eric Allam on 2/22/13.
//  Copyright (c) 2013 Code School. All rights reserved.
//

#import "CSPropertyDefinition.h"

@interface CSPropertyDefinition ()
-(NSArray *)getAttributes;
@end

@implementation CSPropertyDefinition

- (NSString *)description
{
    return [NSString stringWithFormat:@"<CSPropertyDefinition name=%@; attributes=%@", self.name, self.getAttributes];
}

- (NSString *)name
{
    return [NSString stringWithCString:property_getName(_propertyDefinition) encoding:NSASCIIStringEncoding];
}

+(instancetype)firstPropertyWithEncoding:(const char *)encodingString forClass:(id)klass;
{
    unsigned int outPropertyCount;
    
    objc_property_t *properties = class_copyPropertyList(klass, &outPropertyCount);
    
    for (int i = 0; i < outPropertyCount; i++) {
        objc_property_t property = properties[i];
        NSString *attrString = [NSString stringWithCString:property_getAttributes(property)
                                                  encoding:NSASCIIStringEncoding];
        
        NSArray *propertyAttributes = [attrString componentsSeparatedByString:@","];
        
        NSString *propertyTypeString = [NSString stringWithFormat:@"T%s", encodingString];
        
        if ([propertyAttributes containsObject:propertyTypeString]) {
            return [[self alloc] initWithProperty:property];
        }
        
    }
    
    return nil;
}

+(instancetype)firstPropertyWithType:(NSString *)typeAsString forClass:(id)klass;
{
    unsigned int outPropertyCount;
    
    objc_property_t *properties = class_copyPropertyList(klass, &outPropertyCount);
    
    for (int i = 0; i < outPropertyCount; i++) {
        objc_property_t property = properties[i];
        NSString *attrString = [NSString stringWithCString:property_getAttributes(property)
                                                  encoding:NSASCIIStringEncoding];
        
        NSArray *propertyAttributes = [attrString componentsSeparatedByString:@","];
        
        NSString *propertyTypeString = [NSString stringWithFormat:@"T@\"%@\"", typeAsString];
        
        if ([propertyAttributes containsObject:propertyTypeString]) {            
            return [[self alloc] initWithProperty:property];
        }
        
        
    }
    
    return nil;
}

-(instancetype)initWithProperty:(objc_property_t)property;
{
    self = [super init];
    _propertyDefinition = property;
    return self;
}

-(BOOL)hasType:(NSString *)typeAsString;
{
    NSArray *attributes = [self getAttributes];
    NSString *propertyTypeString = [NSString stringWithFormat:@"T@\"%@\"", typeAsString];
    return [attributes containsObject:propertyTypeString];
}

-(BOOL)isWeak;
{
    NSArray *attributes = [self getAttributes];
    NSString *attr = attributes[1];
    if(attr){
        return [attr isEqualToString:@"W"];
    }else{
        return NO;
    }
}
-(BOOL)isStrong;
{
    NSArray *attributes = [self getAttributes];
    NSString *attr = attributes[1];
    if(attr){
        return [attr isEqualToString:@"&"];
    }else{
        return NO;
    }
    
}
// TODO
-(BOOL)isNonAtomic;
{
    return NO;
}
// TODO
-(BOOL)isAtomic;
{
    return NO;
}

-(NSArray *)getAttributes;
{
    if (propertyAttributes) {
        return propertyAttributes;
    }else{
        NSString *attrString = [NSString stringWithCString:property_getAttributes(self.propertyDefinition)
                                                          encoding:NSASCIIStringEncoding];
        
        propertyAttributes = [attrString componentsSeparatedByString:@","];
        return propertyAttributes;
    }
}
@end
