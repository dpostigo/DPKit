//
// Created by Dani Postigo on 3/3/14.
//

#import <Foundation/Foundation.h>

@protocol DPKitDrawing <NSObject>

typedef void (^DPKitDrawingBlock)(NSRect drawingRect);
typedef void (^DPKitTextFieldCellDrawingBlock)(NSTextFieldCell *textFieldCell, NSRect drawingRect);

@end