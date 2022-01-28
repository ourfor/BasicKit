//
//  Macros.h
//  BasicKit
//
//  Created by XuWang Real on 2021/10/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define STRING(value) #value
#define STRING_WRAP(value) STRING(value)
#define CONCAT(A, B) A B
#define CONCATN(...) #__VA_ARGS__
#define JOIN(A, B) CONCAT(A, B)
#define JOINN(...) CONCATN(__VA_ARGS__)
#define TRACE_POINT "[" __FILE__ "]" "(" STRING_WRAP(__LINE__) ")"

NS_ASSUME_NONNULL_END
