install.packages("data.table")
library(data.table)

# Create my_first_data_table
my_first_data_table <- data.table(x = c("a", "b", "c", "d", "e"), 
                                  y = c(1, 2, 3, 4, 5))  

# Create a data.table using recycling
DT <- data.table(a = c(1,2), b = LETTERS[1:4])

# Print the third row to the console
DT[3]

# Print the second and third row to the console without using commas
DT[2:3]

# Print the second to last row of DT using .N
DT[.N - 1]

# Print the column names of DT
colnames(DT)

# Print the number or rows and columns of DT
dim(DT)

# Print a new data.table containing rows 2, 2, and 3 of DT
DT[c(2, 2, 3)]

#What do you think is the output of DT[, B]?
DT[, b]

#Type D <- 5 in the console. What do you think is the output of DT[, .(D)] and DT[, D]
D <- 5 
DT[, .(D)] 
DT[ , D]


# Subset rows 1 and 3, and columns B and C
DT[c(1, 3), .(B, C)]

# Assign to ans the correct value
ans <- DT[, .(B, val = A * C)]
ans
# Fill in the blanks such that ans2 equals target
target <- data.table(B = c("a", "b", "c", "d", "e", 
                           "a", "b", "c", "d", "e"), 
                     val = as.integer(c(6:10, 1:5)))

ans2 <- DT[, .(B, val = c(C, A))]
