module Q5 where 
    
import Cp
import Probability
import List
import BTree
import Nat

data Bag a = B [(a,Int)] deriving Show


singletonbag = B. singl . split id (const 1)

special f = map (id >< f) . unB

muB = B. concatMap gene . unB
    where gene = Cp.ap . swap .(id >< special.(*))

dist = D . uncurry special . split (divide . soma)  id 
    where soma = cataList ( either (const 0) (Cp.ap .((+).p2>< id ))) . unB 
          divide = curry (uncurry (/) . (toFloat >< toFloat) . swap)
       
instance Functor Bag where 
    fmap f = B . map (f >< id) . unB

instance Monad Bag where
x >= f = (muB . fmap f) x 
        where return = singletonbag

unB (B l) = l