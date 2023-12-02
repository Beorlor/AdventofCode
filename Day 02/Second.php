<?php

// Opens the file 'input.txt' for reading
$file = fopen('input.txt', 'r');
// Initializes a variable to keep track of the total power sum of the games
$totalPower = 0;

// Checks if the file was successfully opened
if ($file) {
    // Reads the file line by line in a loop
    while (($line = fgets($file)) !== false) {
        // Trims white spaces from the beginning and end of the line
        $line = trim($line);
        // Continues to the next iteration if the line is empty
        if ($line === '') continue;

        // Uses a regular expression to extract the game ID and the sets of cubes data from the line
        preg_match('/^Game (\d+): (.+)$/', $line, $matches);
        // Splits the sets of cubes into an array
        $sets = explode(';', $matches[2]);

        // Initializes variables to track the minimum number of cubes needed for each color
        $minRed = $minGreen = $minBlue = 0;
        // Iterates over each set of cubes
        foreach ($sets as $set) {
            // Initializes counters for the current number of each color of cube in the set
            $red = $green = $blue = 0;

            // Uses a regular expression to count the number of cubes of each color in the set
            preg_match_all('/(\d+) (red|green|blue)/', $set, $matches, PREG_SET_ORDER);
            // Iterates over each match found
            foreach ($matches as $match) {
                // Assigns the number of red, green, and blue cubes based on the match
                if ($match[2] == 'red') $red = (int)$match[1];
                if ($match[2] == 'green') $green = (int)$match[1];
                if ($match[2] == 'blue') $blue = (int)$match[1];

                // Updates the minimums if the current number of cubes in the set is greater than the previous minimum
                $minRed = max($minRed, $red);
                $minGreen = max($minGreen, $green);
                $minBlue = max($minBlue, $blue);
            }
        }

        // Calculates the power for this game (product of the minimum numbers of cubes of each color)
        $gamePower = $minRed * $minGreen * $minBlue;
        // Adds the game's power to the total sum
        $totalPower += $gamePower;
    }
    // Closes the file once all lines are read
    fclose($file);
}

// Displays the total sum of the power of all the games
echo "Total sum of power: " . $totalPower;
?>
