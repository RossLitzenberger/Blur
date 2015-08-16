#import "ParallaxEffect.h"

@implementation ParallaxEffect
- (NSDictionary *)keyPathsAndRelativeValuesForViewerOffset:(UIOffset)viewerOffset
{
    
    NSNumber *horizontal;
    NSNumber *vertical;
    
    horizontal = @(viewerOffset.horizontal * 20);
    vertical = @(viewerOffset.vertical * 20);
    
    return @{
             @"center.x": horizontal,
             @"center.y": vertical
             };
}
@end
