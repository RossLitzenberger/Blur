//
//  CSSwizzler.h
//  EnumeratePhotos
//
//  Created by Eric Allam on 3/6/13.
//  Copyright (c) 2013 Code School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSSwizzler : NSObject

+(void)swizzleClass:(id)cls
 replaceClassMethod:(SEL)origMethodSelector
         withMethod:(SEL)replacementMethodSelector;

+(void)swizzleClass:(id)cls
      replaceMethod:(SEL)origMethodSelector
         withMethod:(SEL)replacementMethodSelector;

+(void)swizzleClassOfInstance:(id)inst
                replaceMethod:(SEL)origMethodSelector
                   withMethod:(SEL)replacementMethodSelector;
@end
