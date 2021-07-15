       copy "mfunit_prototypes.cpy".
       
       identification division.
       program-id. TestOption as "com.microfocus.cobol.function.TestOption".

       environment division.
       configuration section.

       data division.
       working-storage section.
       01 opt type Option[type Integer].
       copy "mfunit.cpy".
       procedure division.

       entry MFU-TC-PREFIX & "Left_Identity".
           *> Test code goes here.
           set opt to type Option[type Integer]::ooption(8)
           goback returning return-code
           .

      $region Test Configuration

       entry MFU-TC-SETUP-PREFIX & "Left_Identity".
           goback returning 0.

       entry MFU-TC-TEARDOWN-PREFIX & "Left_Identity".
           goback returning 0.

       entry MFU-TC-METADATA-SETUP-PREFIX & "Left_Identity".
           move "This is a example of a dynamic description"
               to MFU-MD-TESTCASE-DESCRIPTION
           move 10000 to MFU-MD-TIMEOUT-IN-MS
           move "smoke,dynmeta" to MFU-MD-TRAITS
           set MFU-MD-SKIP-TESTCASE to false
           goback.

      $end-region

       end program TestOption.
