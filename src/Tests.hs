module Tests where

import System.IO  
import System.Directory  
import Data.List
import Data.Char
import Contract

main = do
    putStrLn "What contract do you want to load? "
    file <- getLine        
    handle <- openFile (file ++ ".txt") ReadMode  
    (tempName, tempHandle) <- openTempFile "." "temp"  
    contents <- hGetContents handle  
    let todoTasks = (map (map toLower) (words contents) )   
    putStrLn "Contract:"  
    putStr (show todoTasks)  
    hClose handle  
    hClose tempHandle 

readDataTypes :: [String] -> Contract
readDataTypes ("end":xs) = End  
readDataTypes ("function":x:xs) = (Function x (readDataTypes xs))
readDataTypes ("constructor":xs) = (Constructor (readDataTypes xs))
readDataTypes ("set":"contractowner":xs) = (Set (ContractOwner) (readDataTypes xs))
readDataTypes ("cashin":"nolimit":xs) = (CashIn (NoLimit) (readDataTypes xs))
readDataTypes ("addto":x:xs) = (AddTo x (readDataTypes xs))
readDataTypes ("Withdraw": xs) = (Withdraw (readDataTypes xs)) 


{--

import           Text.Parsec
import           Text.Parsec.String

type UserRatings = (String, Int)
type Title = String
type Director = String
type Year = Int
type Film = (Title, Director, Year, [UserRatings])

str :: Parser String
str = many1 (noneOf ",")

int :: Parser Int
int = read <$> many1 digit

tup :: Parser UserRatings
tup = do user <- str
         _ <- oneOf ","
         rating <- int
         return (user, rating)

parser :: Parser Film
parser = do
	title <- str
    _ <- oneOf ","
    director <- str
    _ <- oneOf ","
    year <- int
    _ <- oneOf ","
    ratings <- sepBy tup (oneOf ",")
    eof
    return (title, director, year, ratings)


	       

testString :: String
testString = "Blade Runner Ridley Scott 1982 Amy 5,Bill,8,Ian,7,Kevin,9,Emma,4,Sam,7,Megan,4"

main :: IO ()
main = print $ runParser parser () "testString" testString

--}