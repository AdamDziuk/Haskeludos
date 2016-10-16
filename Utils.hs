module Utils where

import Data.Maybe
import Data.Map
import Data.Set

-- Information State Possibilities:
--  Open (All)
--  Secret (Some can see)
--  Hidden (None)

class Viewable item where
   view :: item -> a -> Maybe item
   view _ _ = Nothing

data Visibility f item
    = Open item
    | Hidden item
    | Secret f item

--instance Viewable (Visibility f i) where
--    view (Open item) _ = Just item
--    view (Hidden item) _ = Nothing
--    view (Secret f sitem) a = case f a of
--        True -> Just sitem
---        False -> Nothing

applyList :: [(a -> b)] -> a -> [b]

applyList (f:[]) a = [f a]
applyList (f:fs) a = f a:applyList fs a

removeDuplicates :: Ord a => [a] -> [a]
removeDuplicates as = Data.Set.toList $ Data.Set.fromList as

filterKeysHelper :: (a -> Bool) -> (k,a) -> Maybe k
filterKeysHelper f (key, item) = case f item of
        True -> Just key
        False -> Nothing

filterKeys :: (a -> Bool) -> Map k a -> [k]
filterKeys f mp = catMaybes $ Prelude.map (filterKeysHelper f)  (Data.Map.toList mp)
