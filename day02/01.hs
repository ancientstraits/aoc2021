import Data.Char (toUpper)
import Data.Bifunctor (first, second)

data Cmd
    = CmdFwd  {val :: Int}
    | CmdDown {val :: Int}
    | CmdUp   {val :: Int}


findWord :: String -> (String, Int)
findWord (' ':xs) = ([], read xs :: Int)
findWord (x:xs)   = first (x :) a where a = findWord xs
findWord [] = ([], 0)

toCmd :: (String, Int) -> Cmd
toCmd (str, i) = case str of
    "forward" -> CmdFwd  i
    "down"    -> CmdDown i
    "up"      -> CmdUp   i
    _         -> CmdUp   0

getLoc :: [Cmd] -> (Int, Int)
getLoc (CmdFwd  x:xs) = second (   x  +) a where a = getLoc xs
getLoc (CmdDown x:xs) = first  (   x  +) a where a = getLoc xs
getLoc (CmdUp   x:xs) = first  ((- x) +) a where a = getLoc xs
getLoc _ = (0, 0)

main :: IO ()
main = do
    -- This file should be provided by going to the AOC2021 website.
    x <- readFile "day02/input"
    let ans = (getLoc . map (toCmd . findWord) . lines) x
    print $ uncurry (*) ans