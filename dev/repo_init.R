# project name ---------------------------------------------
library("usethis")
library("sinew")
library("available")
available::available("siyuan")

# cheack list -------------------------------------------------------------
#remotes::install_github("DataStrategist/amitFuncs")
amitFuncs::packageMakerList()

# project init -------------------------------------------------------------
golem::create_golem(path = "~/Desktop/siyuan")

# golem: 01_start.R ------------------------------------------------------------
usethis::edit_file("dev/01_start.R")


# Rstudio & github ------------------------------------------------------------
# Use git 
usethis::use_pipe()
usethis::use_git()
# + + Set Proxy =============================
system("env | grep -i proxy")
Sys.setenv(http_proxy="http://127.0.0.1:60323")
Sys.setenv(https_proxy="http://127.0.0.1:60323")
system("env | grep -i proxy")

# + + use github ==============================
usethis::use_github(protocol = "https")
system("git push -u origin master")

# + + Unset Proxy =============================
Sys.unsetenv("http_proxy")
Sys.unsetenv("https_proxy")
system("env | grep -i proxy")


# analysis fold ==============================
rrtools::use_analysis(location = "top_level",
                      template = "paper.Rmd",
                      data_in_git = TRUE)
# drake ==============================
fs::dir_create("drake")
fs::file_create("drake/set_up.R")
fs::file_create("drake/plan.R")

# paper Rmd init -------------------------------------------------------------
fs::dir_delete("analysis/paper")
rmarkdown::draft(here::here("analysis", "paper.Rmd"),
                 template = "elsevier_article",
                 package = "rticles")
# + + update YAML -------------------------------------------------------------

# title: Short Paper
# author:
#   - name: Alice Anonymous
#     email: alice@example.com
#     affiliation: Some Institute of Technology
#     footnote: 1
# address:
#   - code: Some Institute of Technology
#     address: Department, Street, City, State, Zip
# bibliography: ./../../references.bib




# 解决函数 定义文件, 自动识别引入包的名字 -------------------------------------------------------------
# 1. usethis::use_r("vec_detect_keep")
# 2. run function in global env
# 3. select function name then use addin:createOxygen or ctrl + f


# 增添依赖包到 description file -------------------------------------------------------------
sinew::makeImport("R", format = "description") %>% 
  stringr::str_remove("Imports: ") %>% 
  manuscriptsJX::string2vector(",") %>% 
  purrr::walk(~ usethis::use_package(.x))

# 设置 install and restart 时自动编译文档 或者执行以下命令 -------------------------------------------------------------
devtools::check()
devtools::document()
devtools::build()
devtools::install()

# 检查代码规范化 -------------------------------------------------------------
goodpractice::gp()

# pkgdown -------------------------------------------------------------
usethis::use_pkgdown()
usethis::use_pipe()
pkgdown::build_site()

