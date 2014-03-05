//
// Created by Dani Postigo on 2/20/14.
//

#import "DPWindowFrameView.h"
#import "SNRHUDConstants.h"

@implementation DPWindowFrameView

//- (BOOL) canBecomeKeyView {
//    return NO;
//}


//- (BOOL) acceptsFirstResponder {
//    return NO;
//}


- (void) drawRect: (NSRect) dirtyRect {
    NSRect drawingRect = NSInsetRect(self.bounds, 0.5f, 0.5f);
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect: drawingRect xRadius: SNRWindowCornerRadius yRadius: SNRWindowCornerRadius];
    [NSGraphicsContext saveGraphicsState];
    [path addClip];
    // Fill in the title bar with a gradient background
    NSRect titleBarRect = NSMakeRect(0.f, NSMaxY(self.bounds) - SNRWindowTitlebarHeight, self.bounds.size.width, SNRWindowTitlebarHeight);
    NSGradient *titlebarGradient = [[NSGradient alloc] initWithStartingColor: SNRWindowBottomColor endingColor: SNRWindowTopColor];
    [titlebarGradient drawInRect: titleBarRect angle: 90.f];
    // Draw the window title
    [self snr_drawTitleInRect: titleBarRect];
    // Rest of the window has a solid fill
    NSRect bottomRect = NSMakeRect(0.f, 0.f, self.bounds.size.width, self.bounds.size.height - SNRWindowTitlebarHeight);
    [SNRWindowBottomColor set];
    [NSBezierPath fillRect: bottomRect];
    // Draw the highlight line around the top edge of the window
    // Outset the width of the rectangle by 0.5px so that the highlight "bleeds" around the rounded corners
    // Outset the height by 1px so that the line is drawn right below the border
    NSRect highlightRect = NSInsetRect(drawingRect, 0.f, 0.5f);
    // Make the height of the highlight rect something bigger than the bounds so that it won't show up on the bottom
    highlightRect.size.height += 50.f;
    highlightRect.origin.y -= 50.f;
    NSBezierPath *highlightPath = [NSBezierPath bezierPathWithRoundedRect: highlightRect xRadius: SNRWindowCornerRadius yRadius: SNRWindowCornerRadius];
    [SNRWindowHighlightColor set];
    [highlightPath stroke];
    [NSGraphicsContext restoreGraphicsState];
    [SNRWindowBorderColor set];
    [path stroke];
}

- (void) snr_drawTitleInRect: (NSRect) titleBarRect {
    NSString *title = [[self window] title];
    if (!title) {return;}
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor: SNRWindowTitleShadowColor];
    [shadow setShadowOffset: SNRWindowTitleShadowOffset];
    [shadow setShadowBlurRadius: SNRWindowTitleShadowBlurRadius];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    [style setAlignment: NSCenterTextAlignment];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys: SNRWindowTitleColor, NSForegroundColorAttributeName, SNRWindowTitleFont, NSFontAttributeName, shadow, NSShadowAttributeName, style, NSParagraphStyleAttributeName, nil];
    NSAttributedString *attrTitle = [[NSAttributedString alloc] initWithString: title attributes: attributes];
    NSSize titleSize = attrTitle.size;
    NSRect titleRect = NSMakeRect(0.f, NSMidY(titleBarRect) - (titleSize.height / 2.f), titleBarRect.size.width, titleSize.height);
    [attrTitle drawInRect: NSIntegralRect(titleRect)];
}
@end