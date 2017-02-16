{-# LANGUAGE InstanceSigs #-}
module HasMap where

import Prelude hiding (map)

-- map :: (a -> b) -> [a] -> [b]
mapMaybe :: (a -> b) -> Maybe a -> Maybe b
mapMaybe f Nothing = Nothing
mapMaybe f (Just x) = Just (f x)

data Tree a = Leaf a
            | Node (Tree a) (Tree a)

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree f (Leaf x) = Leaf (f x)
mapTree f (Node t1 t2) = Node (mapTree f t1) (mapTree f t2)

class HasMap g where
    map :: (a -> b) -> g a -> g b

instance HasMap [] where
    map :: (a -> b) -> [a] -> [b]
    map f [] = []
    map f (x:xs) = f x : map f xs


instance HasMap Maybe where
    map = mapMaybe

instance HasMap Tree where
    map = mapTree
