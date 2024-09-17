
Select (q.prox - q.numero) As falta, q.*
  From (
  
  Select a.id As numero,
               (Select Min(b.id)
                  From ENC7_USUARIO b
                 Where b.id > a.id) As prox
          From ENC7_USUARIO a
--         Where a.id < 9500
         
         ) q
 Where (q.prox - q.numero) > 1
 Order By (q.prox - q.numero) Desc