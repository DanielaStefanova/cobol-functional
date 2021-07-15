       class-id com.microfocus.cobol.function.Parent using T public abstract.

       method-id map using U abstract.
       procedure division using by value mapper as type MapFunction
                      returning return-value as type Parent[U].
       end method.

       method-id nested-value using T static.
       procedure division using by value val as T
                      returning return-value as type Parent[T].
           if val = null
               raise new NullPointerException()
           else
               set return-value to new type Nested[T](val)
           end-if
       end method.

       method-id filter using T abstract.
       procedure division using by value predicate as type Predicate
                      returning return-value as type Parent[T].
       end method.

       class-id Nested using T final
                       inherits type Parent[T].
       01 #value T.

       method-id new public.
       procedure division using by value val as T.

           set #value to val

       end method.

       method-id map using U override.
       procedure division using by value mapper as type MapFunction
                      returning return-value as type Parent[U].

           declare mapped = run mapper(#value)
           set return-value to type Parent[T]::nested-value(mapped)

       end method.

       method-id filter using T override.
       procedure division using by value predicate as type Predicate
                      returning return-value as type Parent[T].

           if run predicate(#value)
               set return-value to self 
           end-if
       end method.

       end class.

       end class.

