       class-id com.microfocus.cobol.function.TestUtil public.

       working-storage section.

       method-id new public
       end method.
           
       method-id incrementOne public static.
       procedure division using val as type Integer
           returning return-value as type Integer.
           if val = null
               set return-value to -1
           else if val = 2
               set return-value to null
           else
               set return-value to type Integer::valueOf(1 + val)
           end-if
       end method.
       
       method-id plusOne public.
       procedure division using val as type Integer
                                returning return-value as type Integer.
           if val = null
               set return-value to null
           else
               set return-value to type Integer::valueOf(1 + val)
           end-if
       end method.
           
       end class.
