module TypeClasses1 where
import qualified Prelude
import Prelude hiding (Num(..), Eq(..), Ord(..), map)

-- # Eq class with dictionaries

data Eq a = MkEqDict { (==) :: a -> a -> Bool }

-- instance Eq Bool where ...
dEqBool :: Eq Bool
dEqBool = MkEqDict eq
    where eq True True   = True
          eq False False = True
          eq _ _         = False


-- In real Haskell:
-- allEqual' :: Eq a => a -> a -> a -> Bool
-- allEqual' a b c = (==) a b && (==) b c 

-- How do we rewrite this with dictinoaries?
-- allEqual :: Eq a -> a -> a -> a
-- allEqual dict a b c = (==) dict a b && (==) dict b c

-- instance Eq a => Eq [a] where ...
dEqList :: Eq a -> Eq [a]
dEqList elDict = MkEqDict eq
    where eq [] []         = True
          eq (x:xs) (y:ys) = (==) elDict x y && eq xs ys
          eq _ _           = False

-- instance (Eq a, Eq b) => Eq (a, b) where ...
dEqPair :: Eq a -> Eq b -> Eq (a, b)
dEqPair aDict bDict = MkEqDict eq
    where eq (x1,y1) (x2,y2) = (==) aDict x1 x2 && (==) bDict y1 y2


-- # Num class

-- Our "primitives"
plusInt :: Int -> Int -> Int
plusInt = (Prelude.+)
mulInt :: Int -> Int -> Int
mulInt  = (Prelude.*)
negInt :: Int -> Int
negInt = Prelude.negate
integerToInt :: Integer -> Int
integerToInt = Prelude.fromInteger

-- Dictionary
data Num a = MkNumDict {
                (+) :: a -> a -> a,
                (*) :: a -> a -> a,
                negate :: a -> a
             }

-- square :: Num a => a -> a
-- square x = x * x

square :: Num a -> a -> a
square = undefined

dNumInt :: Num Int
dNumInt = MkNumDict plusInt mulInt negInt

-- squares :: (Num a, Num b) => a -> b -> (a, b)
squares :: Num a -> Num b -> a -> b -> (a,b)
squares dx dy x y = undefined


-- # Ord class

data Ord a = MkOrd { (<=) :: a -> a -> Bool,
                      eqD :: Eq a }


{- From Prelude:
compare :: Ord a => a -> a -> Ordering
compare x y = if x == y then EQ
                  else if x <= y
                          then LT
                          else GT
-}

compare :: Ord a -> a -> a -> Ordering
compare d x y = undefined
