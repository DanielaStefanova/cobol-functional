       copy "mfunit_prototypes.cpy".
       
       identification division.
       program-id. TestEither as "com.microfocus.cobol.function.TestEither".

       environment division.
       configuration section.

       data division.
       working-storage section.
       78 Is-Left value "Is_Left".
       78 Is-Right value "Is_Right".
       78 Is-Right-Biased value "Is_Right_Biased".
       78 Test-FlatMap-Right value "Test_FlatMap_Right"
       copy "mfunit.cpy".
       procedure division.

       entry MFU-TC-PREFIX & Is-Left.
           *> Test left Either variable.
           declare justLeft = type Either[string, binary-long]::left("left")
           if justLeft::isLeft() and not justLeft::isRight()
               goback returning MFU-PASS-RETURN-CODE
           else
               goback returning MFU-FAIL-RETURN-CODE
           .

       entry MFU-TC-PREFIX & Is-Right.
           *> Test right Either variable.
           declare justRight = type Either[string, string]::right("right")
           if justRight::isRight() and not justRight::isLeft()
               goback returning MFU-PASS-RETURN-CODE
           else
               goback returning MFU-FAIL-RETURN-CODE
           .

       entry MFU-TC-PREFIX & Is-Right-Biased.
           *> Show that when right value is not null Either variable is right - right biased.
           declare justRight = type Either[string, string]::either("left", "right")
           if justRight::isRight() and not justRight::isLeft()
               goback returning MFU-PASS-RETURN-CODE
           else
               goback returning MFU-FAIL-RETURN-CODE
           .

       entry MFU-TC-PREFIX & Test-FlatMap-Right.
           *> Test flatMap.
           declare justRight = type Either[string, type Integer]::either("something went wrong", 5)
           declare intMapper as type Function[type Integer, type Either[string, type Integer]]
           set intMapper to delegate using val as type Integer
                         returning return-value as type Either[string, type Integer]
               if val = null
                   set return-value to type Either::left("null value")
               else
                   set return-value to type Either::right( type Integer::valueOf(1 + val))
               end-if
           end-delegate
           
           declare result as type Either[string, type Integer] = justRight::flatMap(null, intMapper)
           if result::isRight() and not result::isLeft()
               goback returning MFU-PASS-RETURN-CODE
           else
               goback returning MFU-FAIL-RETURN-CODE
           .


       end program TestEither.
