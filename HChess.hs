import Board
import Utils
import HChessData
import HChessCards
import HChessEffects

playerName :: HearthstonePlayer -> String
playerName White = "White"
playerName Black = "Black"

chessDeck :: HearthstonePlayer -> [HearthstoneCard]
chessDeck player = 
    (replicate 8 (pawnCard name)) ++
    (replicate 2 (bishopCard name)) ++
    (replicate 2 (rookCard name)) ++ 
    (replicate 2 (knightCard name)) ++
    (replicate 1 (queenCard name))
        where
    name = playerName player

initField :: HearthstonePlayer -> HearthstoneField
initField player = HearthstoneField
    { owner = player
    , hero = chessHero player
    , hand = []
    , deck = []
    , discard = []
    , mana = initManaGauge
    }

initState :: HearthstoneState
initState = HearthstoneState
    { p1State = initField White
    , p2State = initField Black
    , turn = 0
    }
