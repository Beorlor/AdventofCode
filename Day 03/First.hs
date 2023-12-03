import Data.Char (isDigit)

-- Parse the schematic into a 2D array
parseSchematic :: String -> [[Char]]
parseSchematic = lines

-- Check if a given position has a symbol adjacent to it
hasAdjacentSymbol :: [[Char]] -> (Int, Int) -> Bool
hasAdjacentSymbol schematic (x, y) = any isSymbol adjacentPositions
  where
    adjacentPositions = [(x + dx, y + dy) | dx <- [-1..1], dy <- [-1..1],
                         not (dx == 0 && dy == 0), inBounds (x + dx) (y + dy)]
    isSymbol (i, j) = let c = schematic !! i !! j in c /= '.' && not (isDigit c)
    inBounds i j = i >= 0 && i < length schematic && j >= 0 && j < length (head schematic)

-- Sum all part numbers in the schematic
sumPartNumbers :: [[Char]] -> Int
sumPartNumbers schematic = sum [read num | (num, startPos) <- findAllNumbers schematic, any (hasAdjacentSymbol schematic) (numberPositions num startPos)]
  where
    findAllNumbers :: [[Char]] -> [(String, (Int, Int))]
    findAllNumbers sch = concatMap (findNumbersInRow sch) [0..length sch - 1]

    findNumbersInRow :: [[Char]] -> Int -> [(String, (Int, Int))]
    findNumbersInRow sch row = go 0 []
      where
        go col acc
          | col >= length (head sch) = acc
          | isDigit (sch !! row !! col) =
              let number = takeWhile isDigit (drop col (sch !! row))
              in go (col + length number) ((number, (row, col)):acc)
          | otherwise = go (col + 1) acc

    numberPositions :: String -> (Int, Int) -> [(Int, Int)]
    numberPositions num (x, y) = [(x, y + offset) | offset <- [0..length num - 1]]

-- Main function
main :: IO ()
main = do
    contents <- readFile "input.txt"
    let schematic = parseSchematic contents
    print $ sumPartNumbers schematic
