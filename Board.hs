{-# Language MultiParamTypeClasses, FunctionalDependencies, RankNTypes #-}

module Board where

import Data.Maybe
import Data.Either

class GameState state where
    allEntity :: state -> [entity]

type GameChange a = a -> a

-- Restricted to finite games
-- We want to restrict state information from being kept on Players
-- basically "player" strictly refers to IO 

-- GameState maintains state.
-- BoardGame handles player interaction with game

class BoardGame a player state | a -> player, a -> state where

   curPlayer :: a -> player
   allState  :: a -> state
   initilizeGame :: a
   progress :: a -> GameChange state -> Either message (player, a)
   possibilities :: a -> [GameChange state]
   isValid :: a -> GameChange state -> Bool
