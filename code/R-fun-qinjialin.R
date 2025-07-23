#作业部分

##1.关于函数的学习

###1.1
a <- data.frame(
  a1 = c(2, 4, 6),
  a2 = c(3, 5, 8),
  a3 = c(4, 1, 9)
)

head(a)

###1.2
pmin_result <- pmin(a$a1, a$a2, a$a3)

list(pmin = pmin_result)

###1.3
pmin_apply <- function(...) {  
  apply(cbind(...), 1, min)  
}

list(pmin_apply = pmin_apply(a$a1, a$a2, a$a3))

###1.4
pmin_for <- function(...) {
  data <- as.data.frame(list(...))
  result <- numeric(nrow(data))
  for (i in 1:nrow(data)) {
    result[i] <- min(data[i, ])
  }
  result
}

list(pmin_for = pmin_for(a))

###1.5
install.packages("bench")
library(bench)
bench::mark(base=pmin(a$a1,a$a2,a$a3),
            pmin_apply=pmin_apply(a),
            pmin_for=pmin_for(a)
)


##2.关于merge的理解

###2.1
Sys.setlocale(category = "LC_ALL", locale = "Chinese")
b1 <- data.frame(
  name_b1 = c("文", "颜", "唐", "黄"),
  score = c(95, 96, 97, 98)
)


b2 <- data.frame(
  name_b2 = c("文", "颜"),
  github = c("uuu1016", "yanyutong111")
)

head(b1)
head(b2)

###2.2
merged_data <- merge(b1, b2, by.x = "name_b1", by.y = "name_b2")

print(merged_data)

###2.3
install.packages("dplyr")
library(dplyr)

result <- b1 %>%
  inner_join(b2, by = c("name_b1" = "name_b2"))
  
print(result)

###2.4
Sys.setlocale(category = "LC_ALL", locale = "Chinese")
`%merge%` <- function(b1, b2) {
  res <- merge(b1, b2, by.x = "name_b1", by.y = "name_b2")
  rownames(res) <- res$name_b1
  res <- res[, c("score", "github")]
  
  print(res)

}

b1 %merge% b2