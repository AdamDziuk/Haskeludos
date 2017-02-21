{-# Language MultiParamTypeClasses, FunctionalDependencies, InstanceSigs #-}

module HChessData where 

import Board
import Utils

data HearthstonePlayer = White | Black deriving (Show, Eq, Ord)
type HPl = HearthstonePlayer

type HS = HearthstoneState

data Keywords = AutoAttack | Charge | OnPlay | Target

data HearthstoneEffect =
    HearthstoneEffect
        { effName :: String
        , effFunc :: HS -> HS
        , origName :: String
        , effKeys :: [Keywords]
        , expiry :: HS -> Bool
        }

instance Show HearthstoneEffect where
    show :: HearthstoneEffect -> String
    show hs = "[" ++ origName hs ++ "]" ++ effName hs

instance Eq HearthstoneEffect where
    (==) :: HearthstoneEffect -> HearthstoneEffect -> Bool
    (==) hs1 hs2 = (effName hs1) == (effName hs2) && (origName hs1) == (origName hs2)

instance Ord HearthstoneEffect where
    compare :: HearthstoneEffect -> HearthstoneEffect -> Ordering
    compare a b = compare (show a) (show b)

data Rarity = Basic | Free | Common | Rare | Epic | Legendary deriving (Show, Eq, Ord)

data HearthstoneCard =
    HearthstoneMinion
        { cardName :: String
        , rarity :: Rarity
        , cost :: Int
        , attack :: Int
        , hp :: Int
        , effects :: [HearthstoneEffect]
        }
    | HearthstoneSpell
        { cardName :: String
        , rarity :: Rarity
        , cost :: Int
        , effects :: [HearthstoneEffect]
        }
    | HearthstoneWeapon
        { cardName :: String
        , rarity :: Rarity
        , cost :: Int
        , effects :: [HearthstoneEffect]
        , damage :: Int
        }

instance Show HearthstoneCard where
    show hm = cardName hm

instance Eq HearthstoneCard where
    (==) a b = (show a) == (show b)

instance Ord HearthstoneCard where
    compare a b = compare (show a) (show b)

data HearthstoneHero = 
    HearthstoneHero
        { heroName :: String
        , heroPower :: HearthstoneCard -- must be spell
        , heroWeapon :: Maybe HearthstoneCard -- must be weapon
        } deriving (Show, Eq, Ord)

type Deck = [HearthstoneCard]
type Hand = [HearthstoneCard]
type Discard = [HearthstoneCard]

data ManaGauge =
    ManaGauge
        { maxMana :: Int
        , currMana :: Int
        } deriving (Show, Eq, Ord)

initManaGauge :: ManaGauge
initManaGauge =  ManaGauge
    { maxMana = 0
    , currMana = 0
    }

data HearthstoneField =
    HearthstoneField
        { owner :: HearthstonePlayer
        , hero :: HearthstoneHero
        , hand :: Hand
        , deck :: Deck
        , discard :: Discard
        , mana :: ManaGauge
        } deriving (Show, Eq, Ord)

data HearthstoneState =
    HearthstoneState 
        { p1State :: HearthstoneField
        , p2State :: HearthstoneField
        , turn :: Int
        } deriving (Show)
