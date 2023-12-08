#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Read input file
        NSString *input = [NSString stringWithContentsOfFile:@"input.txt" encoding:NSUTF8StringEncoding error:nil];
        NSArray *lines = [input componentsSeparatedByString:@"\n"];

        // Extract instructions and build the node map
        NSString *instructions = lines[0];
        NSMutableDictionary *nodeMap = [NSMutableDictionary dictionary];
        for (int i = 1; i < lines.count; i++) {
            NSArray *parts = [lines[i] componentsSeparatedByString:@" = "];
            if (parts.count == 2) {
                NSString *node = parts[0];
                NSArray *neighbors = [parts[1] componentsSeparatedByString:@", "];
                nodeMap[node] = neighbors;
            }
        }

        // Navigate the network
        NSString *currentNode = @"AAA";
        int stepCount = 0;
        int instructionIndex = 0;
        while (![currentNode isEqualToString:@"ZZZ"]) {
            NSArray *neighbors = nodeMap[currentNode];
            char instruction = [instructions characterAtIndex:instructionIndex];
            currentNode = (instruction == 'L') ? neighbors[0] : neighbors[1];
            instructionIndex = (instructionIndex + 1) % instructions.length;
            stepCount++;
        }

        // Output the number of steps
        NSLog(@"Steps to reach ZZZ: %d", stepCount);
    }
    return 0;
}
