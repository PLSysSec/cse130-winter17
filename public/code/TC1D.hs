module TypeClasses1 where
import qualified Prelude
import Prelude hiding (Num(..), Eq(..), Ord(..), map)

data Eq a = MkEq {
  (==) :: a -> a -> Bool
  }

dEqBool :: Eq Bool
dEqBool = MkEq eq
  where eq True True = True
        eq False False = True
        eq _ _ = False

allEqual :: Eq a -> a -> a -> a -> Bool
allEqual dict a b c = (==) dict a b && (==) dict b c 

eqListA :: Eq a -> Eq [a]
eqListA dictEl = MkEq eq
  where eq  [] [] = True
        eq (x:xs) (y:ys) = (==) dictEl x y && eq xs ys
        eq _ _ = False
        

allEqualInList :: Eq a -> [a] -> Bool
allEqualInList boo []     = True
allEqualInList boo (x:xs) = 
  foldl (\acc y -> acc && (==) boo y x) True xs

data Ord a = MkOrdDict (a -> a -> Bool)
                       (a -> a -> Bool)
                       (Eq a)

(<=) :: Ord a -> (a -> a -> Bool)
(<=) (MkOrdDict f _ _) = f
(<)  :: Ord a -> (a -> a -> Bool)
(<) (MkOrdDict _ s _) = s
eqD  :: Ord a -> Eq a
eqD (MkOrdDict _ _ t) = t

compare :: Ord a -> a -> a -> Ordering
compare ordDict x y = if (==) eqDict x y
                       then EQ
                       else if (<=) ordDict x y
                               then LT
                               else GT
  where eqDict = eqD ordDict
