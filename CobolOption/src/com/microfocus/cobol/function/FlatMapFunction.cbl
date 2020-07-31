       delegate-id com.microfocus.cobol.function.FlatMapFunction using T U public.
       
       procedure division
                 using by value arg as T
                 returning return-value as type Option[U].
       
       end delegate.
