//
//  ArrayUtil.h
//  youcoach
//
//  对数组类型的扩展功能，提供各种各种的工具方法，包括循环、过滤、排序、排重、分组等等……可提高编码效率。
//
//  Created by June on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef id(^ArrayUtilForEach) (id object);
typedef void(^ArrayUtilEachOne) (id object, int i);
typedef void(^ArrayUtilForRepeat) (int i);
typedef id(^ArrayUtilForArrayRepeat) (int i);
typedef BOOL(^ArrayUtilCheckFirstObject) (id object, int i);
typedef BOOL(^ArrayUtilFilterObjects) (id object, int i);
typedef void(^ArrayUtilEachForTwoArrays) (id object1, id object2, int i);
typedef BOOL(^ArrayUtilSumEnities) (id entity);
typedef id(^ArrayUtilCopyArrayForCount) (id object, int i);
typedef BOOL(^ArrayUtilFindIndex) (id object, int i);
typedef CGFloat(^ArrayUtilGetMaxValueInArray) (id object, int i);
typedef CGFloat(^ArrayUtilGetMinValueInArray) (id object, int i);
typedef BOOL(^ArrayUtilExistInArray) (id object, int i);
typedef void(^ArrayUtilSplitArray) (NSArray *array, int section, int fromIndex, int toIndex);

@interface ArrayUtil : NSObject


+ (NSArray*)appendString:(NSString*)string inArray:(NSArray*)array;
+ (NSArray*)wrapperWithLeftString:(NSString*)leftString rightString:(NSString*)rightString inArray:(NSArray*)array;
+ (NSArray*)insertBeforeWithString:(NSString*)string inArray:(NSArray*)array;
+ (int)findIndexBesizeNumber:(NSNumber*)targetNumber inArray:(NSArray*)array;
+ (NSArray*)rangeWithStartNumber:(CGFloat)start count:(int)count step:(CGFloat)step;
+ (NSArray*)rangeWithStartNumber:(CGFloat)start endNumber:(CGFloat)end step:(CGFloat)step;
+ (NSArray*)filterObjectsWithKey:(NSString*)key equal:(id)value inArray:(NSArray*)allObjects;
+ (void)updateAllValueWithKey:(NSString*)key value:(id)value inArray:(NSArray*)allObjects;
+ (NSArray*)uniqueWithArray:(NSArray*)array;
+ (NSArray*)getValuesFromEntitiesWithKey:(NSString*)key inArray:(NSArray*)array;
+ (NSArray*)padArrayWithObject:(NSObject*)object totalCount:(int)total inArray:(NSArray*)array;
+ (NSArray*)uniqueForOriginalOrderWithArray:(NSArray*)array;
+ (void)updateValueWithKey:(NSString*)key manyValues:(NSArray*)allValues inArray:(NSArray*)allObjects;
+ (NSArray*)filterArrayWithEachBoolValues:(NSArray*)eachBoolValues inArray:(NSArray*)array;
+ (NSMutableArray*)fillArrayWithValue:(id)value count:(NSUInteger)count;
+ (NSArray*)mergeEntitiesWithKey:(NSString*)key oldEnities:(NSArray*)oldEnitites newEnities:(NSArray*)newEnitities;
+ (NSArray*)arrayForEachWithArray:(NSArray*)array doing:(ArrayUtilForEach)doing;
+ (NSArray*)arrayForEachWithArray:(NSArray*)array decompressArray:(BOOL)decompressArray doing:(ArrayUtilForEach)doing;
+ (void)eachOneWithArray:(NSArray*)array doing:(ArrayUtilEachOne)doing;
+ (void)repeat:(int)count doing:(ArrayUtilForRepeat)doing;
+ (NSMutableArray*)arrayWithRepeat:(NSUInteger)count eachOne:(ArrayUtilForArrayRepeat)doEach;
+ (void)copyValuesFromEntity:(id)fromEntity toEntity:(id)toEntity forProperties:(NSArray*)properties;
+ (id)filterFirstObjectInArray:(NSArray*)array checking:(ArrayUtilCheckFirstObject)checking;
+ (NSArray*)filterObjectsInArray:(NSArray*)array checking:(ArrayUtilFilterObjects)checking;
+ (void)eachWithArray1:(NSArray*)array1 array2:(NSArray*)array2 doing:(ArrayUtilEachForTwoArrays)doing;
+ (NSArray*)copyArray:(NSArray*)array forCount:(NSUInteger)count doing:(ArrayUtilCopyArrayForCount)doing;
+ (NSMutableArray*)splitFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex inArray:(NSArray*)array;
+ (int)findIndexInArray:(NSArray*)array doing:(ArrayUtilFindIndex)doing;
+ (BOOL)existInArray:(NSArray*)array checking:(ArrayUtilExistInArray)checking;

+ (NSNumber*)sumEntities:(NSArray*)entities forKey:(NSString*)key;
+ (NSNumber*)sumEntities:(NSArray*)entities forKey:(NSString*)key checking:(ArrayUtilSumEnities)checking;
+ (NSNumber*)sumWithArray:(NSArray*)array;

+ (NSMutableArray*)diffArrayWithBaseArray:(NSArray*)baseArray newArray:(NSArray*)newArray forKey:(NSString*)key;
+ (id)getLoopValueInArray:(NSArray*)array atIndex:(NSUInteger)index;

+ (CGFloat)getMaxFloatValueInArray:(NSArray*)array doing:(ArrayUtilGetMaxValueInArray)doing;
+ (CGFloat)getMaxFloatValueInArray:(NSArray*)array minValue:(CGFloat)minValue doing:(ArrayUtilGetMaxValueInArray)doing;
+ (CGFloat)getMinFloatValueInArray:(NSArray*)array doing:(ArrayUtilGetMinValueInArray)doing;
+ (CGFloat)getMinFloatValueInArray:(NSArray*)array maxValue:(CGFloat)maxValue doing:(ArrayUtilGetMinValueInArray)doing;

+ (NSMutableArray*)arrayWithJoinManyObjects:(id)array1, ...;

+ (void)splitArray:(NSArray*)array countPerSection:(int)countPerSection doing:(ArrayUtilSplitArray)doing;
+ (void)splitArray:(NSArray*)array countPerSection:(int)countPerSection step:(int)step doing:(ArrayUtilSplitArray)doing;

+ (int)findIndexInAllSectionsWithIndexPath:(NSIndexPath*)indexPath inArray:(NSArray*)array;

@end
