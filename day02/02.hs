import Data.Char (toUpper)
import Data.Bifunctor (first, second)

data Cmd
  = CmdFwd  {val :: Int}
  | CmdDown {val :: Int}
  | CmdUp   {val :: Int}

data Submarine = Submarine {
  horizontal :: Int,
  aim        :: Int,
  depth      :: Int
}


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

getLoc' :: Submarine -> [Cmd] -> Submarine
getLoc' (Submarine horz aim depth) (CmdDown x:xs) = getLoc' (Submarine horz (aim + x) depth) xs
getLoc' (Submarine horz aim depth) (CmdUp   x:xs) = getLoc' (Submarine horz (aim - x) depth) xs
getLoc' (Submarine horz aim depth) (CmdFwd  x:xs) = getLoc' (Submarine (horz+x) aim (depth+(x*aim))) xs
getLoc' sub [] = sub
getLoc :: [Cmd] -> Submarine
getLoc = getLoc' (Submarine 0 0 0)

main :: IO ()
main = do
  x <- readFile "day02/input"
  let (Submarine horz aim depth) = (getLoc . map (toCmd . findWord) . lines) x
  print horz
  print aim
  print depth
  print (horz * depth)