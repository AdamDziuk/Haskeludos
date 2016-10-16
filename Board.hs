{-# Language MultiParamTypeClasses, FunctionalDependencies #-}

module Board where

import Data.Maybe
import Data.Either
import Utils

class GameState entity state where
    allEntity :: state -> [entity]

type GameChange a = a -> a

type Message = String

-- Restricted to finite games
-- We want to restrict state information from being kept on Players
-- basically "player" strictly refers to IO 

-- GameState maintains state.
-- BoardGame handles player interaction with game

class BoardGame a player state | a -> player, a -> state where

   curPlayer :: a -> player
   state :: a -> state
   initilizeGame :: a
   progress :: a -> GameChange state -> a
   possibilities :: a -> [GameChange state]

   isValid :: a -> GameChange state -> Bool
   isValid _ _ = True

iteratePossibilities :: BoardGame a p s => [a] -> [a]
iteratePossibilities [] = []
iteratePossibilities (b:bs) = Prelude.map (progress b) (possibilities b) ++ iteratePossibilities bs 

generatePossibilities' :: Ord a => BoardGame a p s => Int -> [a] -> [a]
generatePossibilities' 0 bs = bs
generatePossibilities' n bs = removeDuplicates $ iteratePossibilities $ generatePossibilities' (n - 1) bs

generatePossibilities :: Ord a => BoardGame a p s => Int -> [a]
generatePossibilities n = generatePossibilities' n [initilizeGame] 
