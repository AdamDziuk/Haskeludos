import Board

-- Twilight Squabble (minus event module)

data TS_Card
    = EraCard 
        { era :: Int 
        , activity :: Int 
        , counter :: Int
        , space :: Bool
        , name :: String
        } deriving (Show)
    | AgentCard
    | DACard

data TS_Player = UsPlayer | RuPlayer

data TS_Phase
    = DrawCardsPhase                     -- No Decisions, Next hand
    | PlayCardsPhase TS_Player           -- Each player plays a "BOP" and "SR" card, secretly
    | AgentsPhase                        -- Resolve Agents/Double Agents
    | AgentsReplacementPhase             -- Replace Agents
    | SocioEconomicImpactPhase TS_Player -- Players place tokens in priority order
    | RevealPhase                        -- Both Cards are Revealed
    | CounterActivityPhase               -- Players play counter-activity cards in priority order
    | BalanceOfPowerPhase                -- BOP shifts by value delta (Defcon 1 Ending)
    | SpaceRacePhase                     -- Higher Value goes forward, tie broken by symbol (bool)
    | SocioEconomicEventPhase            -- If Player has card in hand, get tokens equal to act
    | VictoryPhase                       -- Next Era; Evaluate; Defcon 1

data TS_State = TS_State
    { balanceOfPower :: Int
    , usSpaceRace :: Int
    , ruSpaceRace :: Int
    , spaceRaceLeader :: Maybe TS_Player
    , era :: Int
    , usPlayerHand :: [TS_Card]
    , ruPlayerHand :: [TS_Card]
    , usBOPField :: Maybe TS_Card
    , ruBOPField :: Maybe TS_Card
    , usSRField :: Maybe TS_Card
    , ruSRField :: Maybe TS_Card
    , usSETokens :: Int
    , ruSETokens :: Int
    , phase :: TS_Phase
    }
