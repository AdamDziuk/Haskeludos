{-# Language MultiParamTypeClasses, FunctionalDependencies, InstanceSigs #-}

module HChessCards where 

import Board
import Utils
import HChessData
import HChessEffects

-- Cost / Attack / HP

-- Pawn : 1 / 1 / 6 x 8
-- Auto-Attack: Deal 1 damage to the enemies opposite this minion
pawnCard :: String -> HearthstoneCard
pawnCard color = HearthstoneMinion
    { cardName = color ++ " Pawn"
    , rarity = Free
    , cost = 1
    , attack = 1
    , hp = 6
    , effects = [pawnEffect (color ++ " Pawn")]
    }

-- Bishop : 3 / 0 / 6 x 2
-- Auto-Attack: Restore 2 Health to adjacent minions.
bishopCard :: String -> HearthstoneCard
bishopCard color = HearthstoneMinion
    { cardName = color ++ " Bishop"
    , rarity = Free
    , cost = 3
    , attack = 0
    , hp = 6
    , effects = [bishopEffect (color ++ " Bishop")]
    }

-- Rook : 3 / 2 / 6 x 2
-- Auto-Attack: Deal 2 damage to the enemies opposite this minion
rookCard :: String -> HearthstoneCard
rookCard color = HearthstoneMinion
    { cardName = color ++ " Rook"
    , rarity = Free
    , cost = 3
    , attack = 2
    , hp = 6
    , effects = [rookEffect (color ++ " Rook")]
    }

-- Knight : 4 / 4 / 3 x 2
-- Can't Attack Heroes
knightCard :: String -> HearthstoneCard
knightCard color = HearthstoneMinion
    { cardName = color ++ " Knight"
    , rarity = Free
    , cost = 4
    , attack = 4
    , hp = 3
    , effects = [knightTarget (color ++ " Knight")]
    }

-- Queen : 7 / 4 / 6 x 1
-- Auto-Attack: Deal 4 damage to the enemies opposite this minion
queenCard :: String -> HearthstoneCard
queenCard color = HearthstoneMinion
    { cardName = color ++ " Queen"
    , rarity = Free
    , cost = 7
    , attack = 4
    , hp = 6
    , effects = [queenEffect (color ++ " Queen")]
    }

-- Castle : Cost 1, Move a friendly minion left. Repeatable
castle :: HearthstoneCard
castle = HearthstoneSpell
    { cardName = "Castle"
    , rarity = Free
    , cost = 1
    , effects = []
    }


-- White King : Player, 20 HP, Power: 2 Cost - "Castle" - Swap Two Pieces
whiteKing :: HearthstoneHero
whiteKing = HearthstoneHero
    { heroName = "White King"
    , heroPower = castle
    , heroWeapon = Nothing
    }

-- Black King : Enemy, 20 HP, Power: 2 Cost - "Cheat" - Swap Two Pieces
blackKing :: HearthstoneHero
blackKing = HearthstoneHero
    { heroName = "Black King"
    , heroPower = castle
    , heroWeapon = Nothing
    }

chessHero :: HearthstonePlayer -> HearthstoneHero
chessHero White = whiteKing
chessHero Black = blackKing
