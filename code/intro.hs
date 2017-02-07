module Intro where
import Prelude hiding (Either(..))

-- # Definitions and bindings

-- * Haskell uses the = sign to declare symbol *bindings*:

x = 2

-- * They are called variables, but they are not mutable boxes
--   * They are like JS's const (but on steroids)

-- x = 3  -- is this allowed?

-- * 'let' introduces local bindings

example0 = let x = 44 -- is this okay?
               z = x - 2
           in z * 2
           -- what is x here?

-- * Variables are order-independent

a =  if y
      then 'a'
      else 'b' -- we use the y defined below:
y = True

-- # Essence of programming in Haskell

-- * Everything is an expression
-- * Expressions evaluate to values
--    - What's the diff between expressions and values?
-- * Programming in Haskell: substituting equals by equals
--    - Lambda calculus for the win!

{-
example0 = let x = 44
               z = x - 2
           in z * 2
-->
         = let z = 44 - 2
           in z * 2
-->
         = (44 - 2) * 2
-->
         = 42 * 2
-->
         = 84
-}

-- # Every expression has a type

-- * E.g., intVal is a word-sized integer
intVal :: Int
intVal = 31 * (42 + 56)

-- * E.g., ii is an Arbitrarily large integer
ii :: Integer
ii = 31 * (42 + 56000000 * 1000)

-- * E.g., dbl is a double precision floating point
dbl = 3 * (4.2 + 5.6)

-- * E.g., chr is a unicode character
chr = 'a' :: Char

-- * E.g., str is a String = [Char]
str = "w00t" :: String

listOfInt :: [Int]
listOfInt = [1,2,3]

-- * E.g., truth is a Boolean
truth = True :: Bool

-- # Some remarks about types

-- * We didn't need to add type annotations: Haskell infers types
--   - Inspect types in GHCi with :t
--   - You should generally specify types anyway. Why?
-- * Is this the same thing as not having to specify types in JS?
--   - A: yes, B: no

-- * Haskell doesn't do any implicit conversions
--   - E.g., ii_x_dbl = ii + dbl :: ???

-- * Arithmetic operators + and * are overloaded (as are some other)

ii_add  = ii + 33    -- :: ?
dbl_add = dbl + 33.0 -- :: ?

-- * We'll talk about overloading more in the upcoming classes

-- # Functions

-- * Functions have "arrow types"
pos :: Integer -> Bool

-- * Function arguments separated by space not (,)'s
pos x = x > 0
-- * As in JS, you can just use lambdas instead:
gt :: Int -> Int -> Bool
gt = \x y -> x > y -- \xy.(x > y)

-- * Function application is like in lambda calculus:
is33pos = pos 33 -- True

-- * How you should NOT think about functions (or expressions):
--   - What does this function do?

-- * How you should think: what does this mean? Think math!
-- * In Haskell, f :: A -> B means:
--   - For every element x ∈ A,
--      f(x) = some element y = f(x) ∈ B or diverge

-- ## Multi-argument functions

-- * Functions can take multiple arguments

arith :: Int -> Int -> Int -> Int
arith x y z = x * (y + z)

-- * Function appication happens one argument at a time ("currying")

add x y = x + y
five = add 3 2 -- is the same as: (add 3) 2
add3 = add 3 -- :: Int -> Int
-- add3 y = 3 + y

-- * All Haskell functions take one argument
--   - Multi-argument functions just return funtions
--   - E.g.,
add :: Integer -> (Integer -> Integer)
--   - We usually ommit ()'s since -> is right-associative

add4Things :: Float -> (Float -> (Float -> (Float -> Float)))
add4Things x y z w = x + y + z + w + (1.0 :: Float)

-- # Tuples and lists

-- * Haskell has basic support for tuples
--   - Constructors: (), (,), (,,), ...

--   - E.g., tuples
unit   = ()            :: () -- kind of like void
tuple2 = (3, 'w')      :: (Int, Char)
tuple3 = (3, 'w', 3.3) :: (Int, Char, Double)

funAdd :: (Int, Int) -> Int
funAdd (x, y) = x+y

funAdd35 = funAdd (3, 5)

-- * Haskell has basic support for homogeneous lists
--   - Constructors: (:) | []
myIntList'' = [1,2,3] :: [Int]
-- same as consing things:
myIntList''' = 1:2:3:[]
-- (:) :: Int -> [Int] -> [Int]
-- (:) 3 [] == 3:[] == [3]

-- * Cons (:) is used to add elements to the list; ++ can be used to
-- concatenate lists:
concatenatedList = [1,2,3] ++ [4,5,6]

-- * Empty lists
myEmptyBoolList :: [Bool]
myEmptyBoolList = []
myEmptyCharList :: [Char]
myEmptyCharList = []

-- * Haskell does not have support for heterogenous lists
--   - E.g., myHeteroList = [1, 'w'] :: ???

-- # Abstract data types

-- * The 'data' keyword declares user-defined data types
data PairT = PairC Int Int 
             deriving Show -- means you can print types
--  - New type: PairT
--  - Value/data constructor: PairC
--  - A value of this type contains two Int's
myPair :: PairT
myPair = PairC 3 4

-- * One type can have multiple constructors
data Point = Cartesian Double Double
           | Polar Double Double
           deriving Show

point1, point2 :: Point
point1 = Cartesian 3.3 2.2
point2 = Polar 0.1 3.14

data Color = Red | Green | Blue | Indigo | Violet deriving Show
myRed = Red :: Color

-- ## Using ADTs

-- * Constructors are like functions, can partially apply:

myPair' :: Int -> PairT
myPair' = PairC 3

-- * Case statements can be used to "de-construct" values with
-- patterns

getX :: PairT -> Int
getX pair = case pair of
               PairC x y -> x

-- E.g., convert point to cartesian:
toCartesian :: Point -> Point
toCartesian point = case point of
                      Polar r theta -> Cartesian (r * cos theta)
                                                 (r * sin theta)
                      -- Cartesian x y -> Cartesian x y -- or, less verbose:
                      pt@(Cartesian _ _) -> pt

-- We can define a tiny language with addition and multiplication:
data Expr = AddExpr Expr Expr
          | MulExpr Expr Expr
          | ConstExpr Int
          deriving Show

eval :: Expr -> Int
eval (ConstExpr n) = n
eval (AddExpr e1 e2) = eval e1 + eval e2
eval (MulExpr e1 e2) = eval e1 * eval e2

-- ## Pattern matching beyond case

-- * Can use patterns instead of variables beyond case
--   - E.g., when defining functions:
toCartesian' :: Point -> Point
toCartesian' (Polar r theta) = Cartesian (r * cos theta)
                                         (r * sin theta)
toCartesian' x = x

--   - E.g., in a let block
getY pair = let (PairC _ y) = pair in y

-- * The order of pattern matching matters
--   - E.g., What happens if we swap order?
factorial' 0 = 1
factorial' n = n * (factorial' (n-1))

-- * You can alternatively guard definitions:
factorial'' n | isLT0 n = 1
factorial'' n | otherwise = n * (factorial'' (n-1))

-- * Guards are just predicates
isLT0 :: Int -> Bool
isLT0 = (<=0)

-- ## Recursive datatypes

-- * Datatypes can be defined recursively
--   - E.g., int list:

data IntList = INil | ICons Int IntList
             deriving Show -- ^^^^^^^

myEmptyIntList = INil :: IntList

myIntList = ICons 1 (ICons 2 (ICons 3 myEmptyIntList)) :: IntList

sumOfIntList :: IntList -> Int
sumOfIntList INil = 0
sumOfIntList (ICons x xs) = x + (sumOfIntList xs)
{- Solution:
sumOfIntList INil = error "Empty list"
sumOfIntList (ICons x INil) = x
sumOfIntList (ICons x xs) = x + sumOfIntList xs
-}

six :: Bool
six = sumOfIntList myIntList == 6

-- ## Polymorphic datatypes

-- * I want a list of Char's or String's or Point's
--   - Define separate datatype for each: crazy!

data CharList = CNil | CCons Char CharList deriving Show

-- * May want to have functions that work on any kind of lists
--   - Solution: parametrized types
-- * Types can have parameters (kind of like functions)
data List a = Nil | Cons a (List a) deriving Show
                  --     ^  ^^^^^^
--   - Here, List itself takes an argument: type variable a.
--   - Can use type variable a in constructor

--   - Cons and Nil work on any types:
myIntList' :: List Int
myIntList' = Cons 1 (Cons 2 (Cons 3 Nil))

myCharList' :: List Char
myCharList' = Cons 'a' (Cons 'b' (Cons 'c' Nil))

llength :: List a -> Int
llength = undefined
{- Solution:
llength Nil = 0
llength (Cons x xs) = 1 + llength xs
-}

myList'len :: Bool
myList'len =  3 == llength myIntList' &&
              3 == llength myCharList'

-- ## Polymorphic datatypes with multiple parameters

-- * Can have multiple type variables

data Either a b = Left a | Right b
                deriving Show

safeDiv :: Int -> Int -> Either String Int
safeDiv _ 0 = myErr
safeDiv x y = Right $ x `div` y

-- * What is the type of:
--myErr :: ???
myErr = Left "You can't divide by zero, silly."

-- # Lazyness

-- * Definitions of symbols evauated ony when needed
--   -  E.g., safe division:
safeDiv' x y =
  let q = div x y        -- safe as q never evaluated if y == 0
  in if y == 0 then 0 else q

-- * Infinite data structures
posInts = [1..] :: [Int]

-- * Custom control "primitives"
--   - E.g., if:
if' b x y = case b of
              True -> x
              _    -> y
--   - E.g., loop forever:
forever x = forever x
--   - What doe the following mean?
exampleF = if' True 3 (forever 4)

-- ## Laziness FTW: undefined and error

-- * Can leave things as undefined -- sometimes called bottom

thisVarIsUndef = undefined
soIsThisVar    = error "leaving this undefined for now, fixme later"

-- * Because Haskell is lazy, it won't throw up unless you use them

-- * Why might this be useful?

-- * Note: This is not how you should raise exceptions in Haskell!


-- # Bindings with where clauses

-- * Recall that let x = ... in ... can be used to bind variable x within local scope

-- * Let can be used whenever you need to create block scope; 'let's are expressions

-- * Sometimes you want more flexiblity; therein comes the 'where' clauses:

cmpSquare x y  |  y > z    =  "bigger :)"
               |  y == z   =  "same :|"
               |  y < z    =  "smaller :("
    where z = x*x

-- * Note that z is in scope of the function there

-- * General: where clause associated with function equations or case expressions
