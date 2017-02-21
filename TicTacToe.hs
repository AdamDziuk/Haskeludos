{-# Language MultiParamTypeClasses, InstanceSigs #-}

import Board
import Utils
import Data.Map
import Data.Maybe

data TP = X | O deriving (Show, Eq, Ord)

nextPlayer :: TP -> TP
nextPlayer X = O
nextPlayer O = X

type Index = (Int, Int)

data TTTState
    = TTTState
        { stSpots :: Map Index (Maybe TP)
        , stTurn :: TP
        } deriving (Show, Eq, Ord)

placeSymbol :: TTTState -> Int -> Int -> TP -> TTTState
placeSymbol state i0 i1 sym = state {stSpots = Data.Map.update (\x -> Just (Just sym)) (i0,i1) (stSpots state), stTurn = nextPlayer (stTurn state)}

data TTTBoard 
    = TTTBoard
        { boState :: TTTState
        , boPlayers :: [TP]
        } deriving (Show, Ord, Eq)

winnings :: [[Index]]
winnings =  [[(1, 1), (1, 2), (1, 3)]
            ,[(2, 1), (2, 2), (2, 3)]
            ,[(3, 1), (3, 2), (3, 3)]
            ,[(1, 1), (2, 1), (3, 1)]
            ,[(1, 2), (2, 2), (3, 2)]
            ,[(1, 3), (2, 3), (3, 3)]
            ,[(1, 1), (2, 2), (3, 3)]
            ,[(3, 1), (2, 2), (1, 3)]
            ]

getOwner :: TTTBoard -> Index -> Maybe TP
getOwner board index = case res of 
        Nothing -> Nothing
        Just x -> x
    where
        res = Data.Map.lookup index $ (stSpots $ boState board)

checkWinner' :: [Maybe TP] -> Maybe TP
checkWinner' [Just X, Just X, Just X] = Just X
checkWinner' [Just O, Just O, Just O] = Just O
checkWinner' _ = Nothing

checkWinner'' :: [Maybe TP] -> Maybe TP
checkWinner'' [] = Nothing
checkWinner'' ((Just x):xs) = Just x
checkWinner'' (Nothing:xs) = checkWinner'' xs

checkWinner :: TTTBoard -> Maybe TP
checkWinner bo = checkWinner'' $ Prelude.map checkWinner' (Prelude.map (Prelude.map (getOwner bo)) winnings)

instance BoardGame TTTBoard TP TTTState where
    initilizeGame :: TTTBoard
    initilizeGame = TTTBoard
            { boState = TTTState
                { stSpots = Data.Map.fromList [((x, y), Nothing) | x <- [1..3], y <- [1..3] ]
                , stTurn = X
                }
            , boPlayers = [X, O]
            }

    curPlayer :: TTTBoard -> TP
    curPlayer board = stTurn (boState board)

    state :: TTTBoard -> TTTState
    state board = boState board

    possibilities :: TTTBoard -> [GameChange TTTState]
    possibilities board = case checkWinner board of
     Just x -> [const $ boState board]
     Nothing -> [const $ placeSymbol (boState board) x y (stTurn $ boState board) | (x,y) <- filterKeys isNothing $ stSpots $ boState board]

    isValid :: TTTBoard -> GameChange TTTState -> Bool
    isValid _ _ = True

    progress :: TTTBoard -> GameChange TTTState -> TTTBoard
    progress board update = board {boState = update (boState board)}

evalState

evalState :: TP -> TTTBoard -> (TTTBoard -> Float) -> Float
evalState play board f = case winner of
    Just play -> 10
    Nothing -> (/) 10 $ sum $ Prelude.map (evalState play) (iteratePossibilities [board])
    Just x -> -10
    where
        winner = checkWinner board
