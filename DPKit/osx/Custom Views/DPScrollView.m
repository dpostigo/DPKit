//
// Created by Dani Postigo on 2/6/14.
//

#import "DPScrollView.h"
#import "DPFlippedView.h"

@implementation DPScrollView {
    NSView *_documentView;
    DPFlippedView *_flippedView;
}

- (id) initWithFrame: (NSRect) frameRect {
    self = [super initWithFrame: frameRect];
    if (self) {

        [self setup];
    }

    return self;
}

- (void) setup {
    self.translatesAutoresizingMaskIntoConstraints = NO;

    _flippedView = [[DPFlippedView alloc] init];
    // TODO: Implement the rest of DPScrollView

}

#pragma mark Automatically flip document view

- (void) setDocumentView: (NSView *) aView {
    //    [super setDocumentView: aView];
    _documentView = aView;
}

@end