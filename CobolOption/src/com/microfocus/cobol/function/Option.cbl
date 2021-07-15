      *>> <summary>
      *>> Class Option
      *>> </summary>
       class-id com.microfocus.cobol.function.Option using T public abstract.

       working-storage section.

       01 #NONE type None public static value new type None().

       method-id new private.
       end method.

       method-id map using T, U public abstract.
       procedure division using by value mapper as type Function[T, U]
                      returning return-value as type Option[U].
       end method.

       method-id flatMap using T, U public abstract.
       procedure division using by value mapper as type Function[T, type Option[U]]
                      returning return-value as type Option[U].
       end method.

       method-id filter using T public abstract.
       procedure division using by value predicate as type Predicate[T]
                      returning return-value as type Option[T].
       end method.

       method-id getOrElse using T public abstract.
       procedure division using by value def as T
                      returning return-value as T.
       end method.

       method-id isDefined public abstract.
       procedure division returning return-value as condition-value.
       end method.

       method-id some-value using T static.
       procedure division using by value val as T
                      returning return-value as type Option[T].
           if val = null
               raise new NullPointerException()
           else
               set return-value to new type Some(val)
           end-if
       end method.

       method-id none-value using T static.
       procedure division returning return-value as type Option[T].
           set return-value to #NONE
       end method.

       method-id ooption using T public static.
       procedure division using by value val as T
                      returning return-value as type Option[T].
           if val = null
               set return-value to type Option[T]::none-value()
           else
               set return-value to type Option[T]::some-value(val)
           end-if
       end method.

      *>> <summary>
      *>> Class None
      *>> </summary>
       class-id None final
           inherits type Option[T].

       method-id new public.
       end method.

       method-id map using T, U override.
       procedure division using by value mapper as type Function[T, U]
                      returning return-value as type Option[U].

           set return-value to type Option[T]::none-value()

       end method.

       method-id flatMap using T, U override.
       procedure division using by value mapper as type Function[T, type Option[U]]
                      returning return-value as type Option[U].

           set return-value to type Option[T]::none-value()

       end method.

       method-id filter using T override.
       procedure division using by value predicate as type Predicate[T]
                      returning return-value as type Option[T].

           set return-value to #NONE

       end method.

       method-id getOrElse using T override.
       procedure division using by value def as T
                      returning return-value as T.

           set return-value to def

       end method.

       method-id isDefined override.
       procedure division returning return-value as condition-value.

           set return-value to false

       end method.

       end class.

      *>> <summary>
      *>> Class Some
      *>> </summary>
       class-id Some final
           inherits type Option[T].

       01 #value T.

       method-id new public.
       procedure division using by value val as T.

           set #value to val

       end method.

       method-id map using T, U override.
       procedure division using by value mapper as type Function[T, U]
                      returning return-value as type Option[U].

           declare mapped = run mapper(#value)
           set return-value to type Option[T]::some-value(mapped)

       end method.

       method-id flatMap using T, U override.
       procedure division using by value mapper as type Function[T, type Option[U]]
                      returning return-value as type Option[U].

            set return-value to run mapper(#value)

       end method.

       method-id filter using T override.
       procedure division using by value predicate as type Predicate[T]
                      returning return-value as type Option[T].

           declare result = run predicate(#value)
           if true
               set return-value to self 
           else
               set return-value to type Option::none-value()
           end-if
       end method.

       method-id getOrElse using T override.
       procedure division using by value def as T
                      returning return-value as T.

           set return-value to def

       end method.

       method-id isDefined override.
       procedure division returning return-value as condition-value.

           set return-value to false

       end method.

       iterator-id SomeIterator using T static private.

       01 #value T.
       01 #hasNext condition-value value true.

       procedure division using by value item as T,
                       yielding retn as T.
           set retn to item
           stop iterator
       end iterator.

       end class.

       end class.
