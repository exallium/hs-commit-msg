module Main where
import Text.ParserCombinators.Parsec
import System.Environment
import System.IO
import System.Exit

data CommitBox = CommitBox deriving Show
data CommitContent = CommitContent String String String deriving Show

parseProjectCode :: Parser String
parseProjectCode = do 
                    code <- many alphaNum
                    char '-'
                    return code

parseIssueNumber :: Parser String
parseIssueNumber = do 
                    is <- many digit
                    space
                    return is

parseCommitSummary :: Parser String
parseCommitSummary = many $ noneOf "\n"

parseEOF :: Parser CommitBox
parseEOF = eof >>= \x -> return CommitBox

parseBody :: Parser CommitBox
parseBody = newline >>= \x -> return CommitBox

parseFile :: Parser CommitContent
parseFile = do
                pc <- parseProjectCode
                is <- parseIssueNumber
                cs <- parseCommitSummary
                newline
                parseEOF <|> parseBody
                return $ CommitContent pc is cs
                
                
readCommit :: String -> IO ()
readCommit input = case parse parseFile "commit-msg" input of
    Left err -> print err >> exitFailure
    Right val -> print val >> exitSuccess

validateLineLength :: String -> Bool
validateLineLength xs = foldl (\x y -> x && y) True . map (\x -> length x <= 72) $ (lines xs)

main :: IO ()
main = do
    (fname:_) <- getArgs
    fdata <- readFile fname
    if validateLineLength fdata 
        then readCommit fdata 
        else print "too many chars per line: max is 72" >> exitFailure
