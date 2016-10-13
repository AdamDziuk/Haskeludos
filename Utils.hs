import Data.Maybe

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

instance Viewable (Visibility f i) where
    view (Open item) _ = Just item
    view (Hidden item) _ = Nothing
    view (Secret f sitem) a = case f a of
        True -> Just sitem
        False -> Nothing
                    
