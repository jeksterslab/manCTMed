## ---- test-manCTMed-gen-data
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    message(text)
    testthat::test_that(
      text,
      {
        testthat::expect_true(
          TRUE
        )
      }
    )
  },
  text = "test-manCTMed-gen-data"
)
