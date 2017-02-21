{-# Language MultiParamTypeClasses, FunctionalDependencies, InstanceSigs #-}

module HChessEffects where 

import Board
import Utils
import HChessData

-- Auto-Attack: Deal 1 damage to the enemies opposite this minion
pawnEffect :: String -> HearthstoneEffect
pawnEffect orig = HearthstoneEffect
    { effName = "Pawn Effect"
    , effFunc = id 
    , origName = orig
    , effKeys = [AutoAttack]
    , expiry = const True
    }

-- Auto-Attack: Restore 2 Health to adjacent minions.
bishopEffect :: String -> HearthstoneEffect
bishopEffect orig = HearthstoneEffect
    { effName = "Bishop Effect"
    , effFunc = id
    , origName = orig
    , effKeys = [AutoAttack]
    , expiry = const True
    }

-- Auto-Attack: Deal 2 damage to the enemies opposite this minion
rookEffect :: String -> HearthstoneEffect
rookEffect orig = HearthstoneEffect
    { effName = "Rook Effect"
    , effFunc = id
    , origName = orig
    , effKeys = [AutoAttack]
    , expiry = const True
    }

-- Can't Attack Heroes
knightTarget :: String -> HearthstoneEffect
knightTarget orig = HearthstoneEffect
    { effName = "Knight Targeting"
    , effFunc = id
    , origName = orig
    , effKeys = [Target]
    , expiry = const True
    }

-- Auto-Attack: Deal 4 damage to the enemies opposite this minion
queenEffect :: String -> HearthstoneEffect
queenEffect orig = HearthstoneEffect
    { effName = "Queen Effect"
    , effFunc = id
    , origName = orig
    , effKeys = [AutoAttack]
    , expiry = const True
    }

-- Castling
