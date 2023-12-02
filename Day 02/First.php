<?php

// Define the maximum number of each cube color available
$MAX_RED = 12;
$MAX_GREEN = 13;
$MAX_BLUE = 14;

// Open the file 'input.txt' for reading
$file = fopen('input.txt', 'r');
// Initialize a variable to keep track of the sum of Game IDs
$sumOfGameIDs = 0;

// Check if the file was successfully opened
if ($file) {
    // Read the file line by line
    while (($line = fgets($file)) !== false) {
        // Trim white spaces from the beginning and end of the line
        $line = trim($line);
        // Continue to the next iteration if the line is empty
        if ($line === '') continue;

        // Use a regular expression to extract the game ID and the sets of cubes from the line
        preg_match('/^Game (\d+): (.+)$/', $line, $matches);
        // Store the game ID
        $gameID = $matches[1];
        // Split the sets of cubes into an array
        $sets = explode(';', $matches[2]);

        // Initialize a flag to keep track of whether the game is possible
        $gamePossible = true;
        // Iterate over each set of cubes
        foreach ($sets as $set) {
            // Initialize counters for each color of cube
            $red = $green = $blue = 0;

            // Use a regular expression to count the number of cubes of each color in the set
            preg_match_all('/(\d+) (red|green|blue)/', $set, $matches, PREG_SET_ORDER);
            foreach ($matches as $match) {
                // Increment the respective color counter based on the match
                if ($match[2] == 'red') $red += (int)$match[1];
                if ($match[2] == 'green') $green += (int)$match[1];
                if ($match[2] == 'blue') $blue += (int)$match[1];
            }

            // Check if the number of cubes of any color in this set exceeds the maximum
            if ($red > $MAX_RED || $green > $MAX_GREEN || $blue > $MAX_BLUE) {
                // Mark the game as impossible and break out of the loop
                $gamePossible = false;
                break;
            }
        }

        // If the game is possible, add its ID to the sum
        if ($gamePossible) {
            $sumOfGameIDs += $gameID;
        }
    }
    // Close the file
    fclose($file);
}

// Output the sum of the Game IDs
echo "Sum of Game IDs: " . $sumOfGameIDs;
?>
