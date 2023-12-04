import Data.Char (isDigit)
import qualified Data.Map as Map
import Data.Maybe (mapMaybe)

-- Parse the schematic into a 2D array
parseSchematic :: String -> [[Char]]
parseSchematic = lines

-- Function to check if a given position is within bounds
inBounds :: [[Char]] -> (Int, Int) -> Bool
inBounds schematic (x, y) = x >= 0 && x < length schematic && y >= 0 && y < length (head schematic)

-- Extracts all numbers from the schematic along with their starting positions
findAllNumbers :: [[Char]] -> Map.Map (Int, Int) Int
findAllNumbers sch = Map.fromList $ concatMap (findNumbersInRow sch) [0..length sch - 1]
  where
    findNumbersInRow sch row = go 0 []
      where
        go col acc
          | col >= length (head sch) = acc
          | isDigit (sch !! row !! col) =
              let numberStr = takeWhile isDigit (drop col (sch !! row))
                  number = read numberStr
              in go (col + length numberStr) (((row, col), number):acc)
          | otherwise = go (col + 1) acc

-- Function to check if a position is a gear and calculate its ratio
gearRatio :: Map.Map (Int, Int) Int -> [[Char]] -> (Int, Int) -> Maybe Int
gearRatio numberMap schematic (x, y) = case filter (`Map.member` numberMap) adjacentPositions of
                                          [pos1, pos2] -> Just (numberMap Map.! pos1 * numberMap Map.! pos2)
                                          _            -> Nothing
  where
    adjacentPositions = [(x + dx, y + dy) | dx <- [-1..1], dy <- [-1..1],
                          (dx, dy) /= (0, 0), inBounds schematic (x, y), isAdjacentToNumber (x, y) (dx, dy)]
    isAdjacentToNumber (i, j) (dx, dy) =
      let pos = (i + dx, j + dy)
      in inBounds schematic pos && isDigit (schematic !! fst pos !! snd pos)

-- Sum all gear ratios in the schematic
sumGearRatios :: [[Char]] -> Int
sumGearRatios schematic = sum $ mapMaybe (gearRatio numberMap schematic) gears
  where
    gears = [(x, y) | x <- [0..length schematic - 1], y <- [0..length (head schematic) - 1],
                     schematic !! x !! y == '*']
    numberMap = findAllNumbers schematic

-- Main function
main :: IO ()
main = do
    contents <- readFile "input.txt"
    let schematic = parseSchematic contents
    print $ sumGearRatios schematic
