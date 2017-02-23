module TypeClasses1 where
import qualified Prelude
import Prelude hiding (Num(..), Eq(..), Ord(..), map)

-- # Eq class

class Eq a where
   (==) :: a -> a -> Bool

instance Eq Bool where
  True  == True  = True
  False == False = True
  _     == _     = False

allEqual :: Eq a => a -> a -> a -> Bool
allEqual a b c = (==) a b && (==) b c 

-- allEqual3 :: (Eq a, Eq b, Eq c) => a -> b -> c -> Bool
-- allEqual3 a b c =
--  let f = (==) a -- :: a -> Bool
--      f a
--  in True

instance Eq a => Eq [a] where
    []     == []     = True
    (x:xs) == (y:ys) = x == y && xs == ys
    _      == _      = False
-- exercise: redefine Eq for lists to be Hamming weight

allEqualInList :: Eq a => [a] -> Bool
allEqualInList []     = True
allEqualInList (x:xs) = 
  foldl (\acc y -> acc && y == x) True xs

instance (Eq a, Eq b) => Eq (a, b) where
  (x1, y1) == (x2, y2) = x1 == x2 && y1 == y2

-- # Num class

class Num a where
  (+) :: a -> a -> a
  (*) :: a -> a -> a
  negate :: a -> a
 
square :: Num a => a -> a
square x = x * x

instance Num Int where
 (+) = (Prelude.+)
 (*) = (Prelude.*)
 negate = Prelude.negate

instance Num Float where
 (+) = (Prelude.+)
 (*) = (Prelude.*)
 negate = Prelude.negate

squares :: (Num a, Num b) => a -> b -> (a, b)
squares x y = (square x, square y)


-- # Ord class

class Eq a => Ord a where
  (<=) :: a -> a -> Bool
  (<)  :: a -> a -> Bool

{-
instance Eq Int where
  (==) x y = False

instance Ord Int where
   x < y = False
   x <= y = True
-}

compare :: Ord a => a -> a -> Ordering
compare x y = if x == y then EQ
                  else if x <= y
                          then LT
                          else GT
