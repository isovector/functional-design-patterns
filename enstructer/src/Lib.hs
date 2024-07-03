{-# LANGUAGE DeriveGeneric       #-}
{-# LANGUAGE DerivingStrategies  #-}
{-# LANGUAGE DerivingVia         #-}
{-# LANGUAGE ImportQualifiedPost #-}
{-# LANGUAGE OverloadedStrings   #-}

module Lib where

import Data.Foldable
import Data.List (isPrefixOf)
import Data.Char
import Control.Applicative hiding (many)
import Data.Void
import Algebra.Graph.AdjacencyMap qualified as G
import Data.IntMap (IntMap)
import Data.IntMap qualified as IM
import GHC.Generics
import Text.Megaparsec
import Text.Megaparsec.Char (space1, char)
import Text.Megaparsec.Char.Lexer
import Data.Either


type Parser = Parsec Void String

data G = G
  { g_gr :: G.AdjacencyMap Int
  , g_map :: IntMap String
  }
  deriving stock (Generic, Show)
  deriving (Semigroup, Monoid) via Generically G

mkG :: G -> G.AdjacencyMap String
mkG (G gr m) = G.gmap (m IM.!) gr

sp :: Parser ()
sp = space space1 empty empty

parseIt :: Parser G
parseIt = asum
  [ try $ do
      ix <- lexeme sp decimal
      symbol sp "["
      lexeme sp "label"
      symbol sp "="
      str <- fmap getName stringLiteral
      symbol sp "]"
      symbol sp ";"
      pure $ G (G.vertex ix) $ IM.singleton ix str
  , do
      ix <- lexeme sp decimal
      symbol sp "->"
      jx <- lexeme sp decimal
      symbol sp ";"
      pure $ G (G.edge ix jx) mempty
  ]

stringLiteral :: Parser String
stringLiteral = char '"' >> manyTill charLiteral (char '"')



parseG :: String -> G
parseG = fromRight (error "cant parse") . parse parseIt ""


toYaml :: [String] -> String
toYaml [] = " []"
toYaml x = mappend "\n" $ init $ unlines $ fmap (mappend "- ") x


main :: IO ()
main = do
  f <- readFile "../test.dot"
  let g = mkG $ foldMap parseG $ lines f
  for_ (G.vertexList g) $ \v -> do
    let ins = toList $ G.preSet  v g
        outs = toList $ G.postSet  v g
    putStrLn $ unlines
      [ "---"
      , "id: " <> v
      , "confidence: 7"
      , "tags: []"
      , "bigger:" <> toYaml ins
      , "smaller:" <> toYaml outs
      , "see-also:" <> toYaml []
      , "name: " <> show v
      , "teaser: " <> show ""
      , "---"
      , ""
      , ""
      , "...bigger context..."
      , ""
      , "---"
      , ""
      , "main body"
      , ""
      , "---"
      , ""
      , "...smaller context..."
      ]


getName :: String -> String
getName = betterName . foldMap unspace . fmap toLower
  where
    unspace ' ' = "-"
    unspace '-' = "-"
    unspace x
      | isSymbol x = mempty
      | isPunctuation x = mempty
      | otherwise = pure x

betterName :: String -> String
betterName "aps" = "pointwise-monoid"
betterName "compose" = "compose-type"
betterName x | isPrefixOf "of-" x= "composition-" <> x
betterName x = x
