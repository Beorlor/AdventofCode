import Data.Char (isDigit)
import Data.List (nub)

-- Parse the schematic into a 2D array
parseSchematic :: String -> [[Char]]
parseSchematic = lines

-- Function to check if a given position is within bounds
inBounds :: [[Char]] -> (Int, Int) -> Bool
inBounds schematic (x, y) = x >= 0 && x < length schematic && y >= 0 && y < length (head schematic)

-- Extracts and sums gear ratios from the schematic
sumGearRatios :: [[Char]] -> Int
sumGearRatios schematic = sum $ map calculateGearRatio gears
  where
    gears = [(x, y) | x <- [0..length schematic - 1], y <- [0..length (head schematic) - 1],
                     schematic !! x !! y == '*']
    calculateGearRatio (x, y) = case nub $ filter (/= 0) $ concatMap (findNumbers (x, y)) adjacentOffsets of
                                [a, b] -> a * b
                                _      -> 0
    adjacentOffsets = [(dx, dy) | dx <- [-1..1], dy <- [-1..1], (dx, dy) /= (0, 0)]
    findNumbers (x, y) (dx, dy)
      | inBounds schematic (x + dx, y + dy) && isDigit (schematic !! (x + dx) !! (y + dy)) =
          [read $ takeWhile isDigit $ drop (y + dy) (schematic !! (x + dx))]
      | otherwise = []

-- Main function
main :: IO ()
main = do
    contents <- readFile "input.txt"
    let schematic = parseSchematic contents
    print $ sumGearRatios schematic
