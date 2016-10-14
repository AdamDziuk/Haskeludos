module Cards where

data Rank = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | J | Q | K | Ace 
    deriving (Eq, Ord, Enum, Show)
data Suit = Spade | Heard | Diamond | Club
    deriving (Eq, Ord, Enum, Show)
type Card = (Rank, Suit)

type Hand = [Card]
type Deck = [Card]

ranks :: [Rank]
ranks = [Two .. Ace]

suits :: [Suit]
suits = [Spade .. Club]

deck :: [Rank] -> [Suit] -> [Card]
deck rs ss = [(r,s) | r <- rs, s <- ss ]

cardEq :: Card -> Card -> Bool
cardEq (r1, s1) (r2, s2) = (r1 == r2) && (s1 == s2)
