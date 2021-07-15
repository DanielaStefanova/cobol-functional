      *>> <summary>
      *>> Class Either
      *>> </summary>
       class-id com.microfocus.cobol.function.Either using L, R public abstract.

       working-storage section.

       procedure division.

       method-id isLeft public abstract.
       procedure division returning return-value as condition-value.
       end method.
           
       method-id isRight public abstract.
       procedure division returning return-value as condition-value.
       end method.
       
       method-id map using L, R, T, U public abstract.
       procedure division using by value mapperLeft as type Function[L, T],
                                         mapperRight as type Function[R, U]
                      returning return-value as type Either[T, U].
       end method.
           
       method-id flatMap using L, R, T, U public abstract.
       procedure division using by value mapperLeft as type Function[L, type Either[T, U]],
                                         mapperRight as type Function[R, type Either[T, U]]
                      returning return-value as type Either[T, U].
       end method.
           
       method-id either using L, R public static.
       procedure division using by value left-value as L
                                         right-value as R 
       returning return-value as type Either[L, R].
            if right-value = null
               set return-value to type Either[L, R]::left(left-value) 
            else
               set return-value to type Either[L, R]::right(right-value)   
            end-if
       end method. 

       method-id left using L, R public static.
       procedure division using by value val as L
                          returning return-value as type Either[L, R].
            set return-value to new type Left(val) 
       end method. 

       method-id right using L, R public static.
       procedure division using by value val as R
                          returning return-value as type Either[L, R].
            set return-value to new type Right(val) 
       end method. 

      *>> <summary>
      *>> Class Left
      *>> </summary>
       class-id Left final
           inherits type Either[L, R].

       working-storage section.

       01 #left-value L protected.

       method-id new.
       procedure division using by value left-value as L.
          set #left-value to left-value
       end method.
       
       method-id isLeft override.
       procedure division returning return-value as condition-value.
           set return-value to true
       end method.
           
       method-id isRight override.
       procedure division returning return-value as condition-value.
           set return-value to false
       end method.
           
       method-id map using L, R, T, U override.
       procedure division using by value mapperLeft as type Function[L, T],
                                         mapperRight as type Function[R, U]
                      returning return-value as type Either[T, U].
           declare mapped = run mapperLeft(#left-value)
           set return-value to type Either[T, U]::left(mapped)
       end method.

       method-id flatMap using L, R, T, U override.
       procedure division using by value mapperLeft as type Function[L, type Either[T, U]],
                                         mapperRight as type Function[R, type Either[T, U]]
                      returning return-value as type Either[T, U].
           set return-value to run mapperLeft(#left-value)
       end method.

       end class.

      *>> <summary>
      *>> Class Right
      *>> </summary>
       class-id Right final
           inherits type Either[L, R].

       working-storage section.

       01 #right-value R protected.

       method-id new.
       procedure division using by value right-value as R.
          set #right-value to right-value
       end method.

       method-id isLeft override.
       procedure division returning return-value as condition-value.
           set return-value to false
       end method.
           
       method-id isRight override.
       procedure division returning return-value as condition-value.
           set return-value to true
       end method.
           
       method-id map using L, R, T, U override.
       procedure division using by value mapperLeft as type Function[L, T],
                                         mapperRight as type Function[R, U]
                      returning return-value as type Either[T, U].
           declare mapped = run mapperRight(#right-value)
           set return-value to type Either[T, U]::right(mapped)
       end method.

       method-id flatMap using L, R, T, U override.
       procedure division using by value mapperLeft as type Function[L, type Either[T, U]],
                                         mapperRight as type Function[R, type Either[T, U]]
                      returning return-value as type Either[T, U].
           set return-value to run mapperRight(#right-value)
       end method.

       end class.


       end class.
