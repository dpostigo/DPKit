//
// Created by Dani Postigo on 2/28/14.
//

#import "DPTimeInputTextFieldCell.h"
#import "DPTimeInputTextView.h"

@implementation DPTimeInputTextFieldCell

- (void) awakeFromNib {
    [super awakeFromNib];
}


- (void) setObjectValue: (id <NSCopying>) obj {
    [super setObjectValue: obj];
}

- (NSText *) setUpFieldEditorAttributes: (NSText *) textObj {
    NSTextView *fieldEditor = (NSTextView *) [super setUpFieldEditorAttributes: textObj];
    //    NSColor *textColor = SNRTextFieldTextColor;
    //    [customFieldEditor setInsertionPointColor: textColor];
    //    [customFieldEditor setTextColor: textColor];
    //    [fieldEditor setDrawsBackground: NO];

    //    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary: [fieldEditor selectedTextAttributes]];
    //    [attributes setObject: [NSColor redColor] forKey: NSBackgroundColorAttributeName];
    //    [fieldEditor setSelectedTextAttributes: attributes];
    return fieldEditor;
}


- (void) selectWithFrame: (NSRect) aRect inView: (NSView *) controlView editor: (NSText *) textObj delegate: (id) anObject start: (NSInteger) selStart length: (NSInteger) selLength {
    NSRange range = [self.customFieldEditor firstRangeForString: self.stringValue];
    [super selectWithFrame: aRect inView: controlView editor: textObj delegate: anObject start: range.location length: range.length];
}


- (NSTextView *) fieldEditorForView: (NSView *) aControlView {
    return self.customFieldEditor;
}


#pragma mark Custom field editor

- (void) setCustomFieldEditor: (DPTimeInputTextView *) customFieldEditor1 {
    if (customFieldEditor != customFieldEditor1) {
        customFieldEditor = customFieldEditor1;
        customFieldEditor.fieldEditor = YES;
        self.stringValue = customFieldEditor.string;
        self.formatter = customFieldEditor.formatter;
    }
}

- (DPTimeInputTextView *) customFieldEditor {
    if (customFieldEditor == nil) {
        customFieldEditor = [[DPTimeInputTextView alloc] init];
        customFieldEditor.fieldEditor = YES;
        self.stringValue = customFieldEditor.string;
        self.formatter = customFieldEditor.formatter;
    }
    return customFieldEditor;
}


#pragma mark Drawing




@end