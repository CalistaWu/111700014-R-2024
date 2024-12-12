#install.packages("plumber")

library(plumber)

# dataset
students <- data.frame(
  id = integer(),
  name = character(),
  height = numeric(),
  weight = numeric(),
  stringsAsFactors = FALSE
)

# GET /students
#* @get /students
function() {
  return(students)
}

# POST /students
#* @post /students
#* @param name 學生姓名
#* @param height 身高 (cm)
#* @param weight 體重 (kg)
function(name, height, weight) {
  new_id <- ifelse(nrow(students) == 0, 1, max(students$id) + 1)
  new_student <- data.frame(
    id = new_id,
    name = name,
    height = as.numeric(height),
    weight = as.numeric(weight),
    stringsAsFactors = FALSE
  )
  students <<- rbind(students, new_student)
  return(new_student)
}

# PATCH /students/:id
#* @patch /students/<id>
#* @param name 新的姓名 (選填)
#* @param height 新的身高 (選填)
#* @param weight 新的體重 (選填)
function(id, name = NULL, height = NULL, weight = NULL) {
  id <- as.integer(id)
  idx <- which(students$id == id)
  if (length(idx) == 0) stop("Student not found!")
  
  if (!is.null(name)) students$name[idx] <- name
  if (!is.null(height)) students$height[idx] <- as.numeric(height)
  if (!is.null(weight)) students$weight[idx] <- as.numeric(weight)
  return(students[idx, ])
}

# DELETE /students/:id
#* @delete /students/<id>
function(id) {
  id <- as.integer(id)
  idx <- which(students$id == id)
  if (length(idx) == 0) stop("Student not found!")
  
  students <<- students[-idx, ]
  return(list(message = paste("Student with ID", id, "has been deleted.")))
}

# GET /plot
#* @get /plot
#* @serializer png
function() {
  if (nrow(students) == 0) stop("No students available to plot!")
  
  plot(students$height, students$weight, xlab = "Height", ylab = "Weight", main = "Height vs Weight")
}
