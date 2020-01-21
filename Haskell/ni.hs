{-Kevin Doyle
    15350806-}

plus :: Int -> [Int] -> [Int] -> [Int]
times :: Int -> [Int] -> [Int] -> [Int]

plus base x y = beginAdding base x y 0

times base x y = startMul base x y 0

beginAdding base x y carry 
 | x == [] && y == [] = if carry == 0 then [] else carry : []
 | x == [] = mod (head [0] + head y + carry) base : beginAdding base x (tail y) (quot (head [0] + head y + carry) base)
 | y == [] = mod (head x + head [0] + carry) base : beginAdding base (tail x) y (quot (head x + head [0] + carry) base)
 | otherwise = mod (head x + head y + carry) base : beginAdding base (tail x) (tail y) (quot (head x + head y + carry) base)

{- For this section of how to calculate times I got stuck so this bit I have in here is through help from a classmates code on the times section -}
multScalar base x y carry
 |x == [] = if carry == 0 then [] else carry : []
 |otherwise = mod (head x * y + carry) base : multScalar base (tail x) y (quot (head x * y + carry) base)
multOut base x y
 |y == [] = []
 |otherwise = plus base (multScalar base x (head y) 0) (multOut base (0:x) (tail y))
startMul base x y index
 |(drop index (multOut base (take (index + 1) x) (take (index + 1) y))) == [] = []
 |otherwise = (head (drop index (multOut base (take (index + 1) x) (take (index + 1) y)))) : startMul base x y (index +1)
 