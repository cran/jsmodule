## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  echo = TRUE,
  eval = FALSE
)

## ----api-setup----------------------------------------------------------------
# # .Renviron 파일 열기
# usethis::edit_r_environ()
# 
# # 다음 중 하나를 추가:
# # ANTHROPIC_API_KEY=your_key_here
# # OPENAI_API_KEY=your_key_here
# # GOOGLE_API_KEY=your_key_here
# 
# # 저장 후 R 세션 재시작

## ----basic-gadget-------------------------------------------------------------
# library(jsmodule)
# 
# # AI Assistant가 포함된 gadget 실행
# jsBasicGadget()
# 
# # "AI Assistant" 탭으로 이동

## ----standalone-app-----------------------------------------------------------
# library(shiny)
# library(jsmodule)
# library(survival)
# 
# ui <- fluidPage(
#   titlePanel("AI Statistical Assistant"),
#   aiAssistantUI("ai")
# )
# 
# server <- function(input, output, session) {
#   data <- reactive(colon)
#   data.label <- reactive(jstable::mk.lev(colon))
# 
#   callModule(aiAssistant, "ai",
#     data = data,
#     data_label = data.label
#   )
# }
# 
# shinyApp(ui, server)

## ----dev-mode-----------------------------------------------------------------
# # 개발 모드 - 사용자가 UI에서 설정 가능
# aiAssistantUI("ai", show_api_config = TRUE)  # 기본값
# 
# callModule(aiAssistant, "ai",
#   data = data,
#   data_label = data.label,
#   show_api_config = TRUE
# )

## ----prod-mode----------------------------------------------------------------
# # 프로덕션 모드 - .Renviron에서만 API 키 읽기
# aiAssistantUI("ai", show_api_config = FALSE)
# 
# callModule(aiAssistant, "ai",
#   data = data,
#   data_label = data.label,
#   show_api_config = FALSE
# )

## ----custom-varStruct---------------------------------------------------------
# server <- function(input, output, session) {
#   data <- reactive(lung)
#   data.label <- reactive(jstable::mk.lev(lung))
# 
#   # 변수 역할 정의
#   var_struct <- reactive({
#     list(
#       variable = names(lung),
#       Base = c("age", "sex", "ph.ecog"),
#       Event = "status",
#       Time = "time"
#     )
#   })
# 
#   callModule(aiAssistant, "ai",
#     data = data,
#     data_label = data.label,
#     data_varStruct = var_struct
#   )
# }

## ----analysis-context---------------------------------------------------------
# callModule(aiAssistant, "ai",
#   data = data,
#   data_label = data.label,
#   analysis_context = reactive({
#     "NCCTG 폐암 임상시험 데이터.
#      주요 결과: 사망까지의 시간 (status/time).
#      수행능력 점수(ph.ecog)를 예측 변수로 중점 분석."
#   })
# )

## ----production-deploy--------------------------------------------------------
# ui <- fluidPage(
#   aiAssistantUI("ai", show_api_config = FALSE)
# )
# 
# server <- function(input, output, session) {
#   callModule(aiAssistant, "ai",
#     data = data,
#     data_label = data.label,
#     show_api_config = FALSE  # .Renviron만 사용
#   )
# }

## ----dev-env------------------------------------------------------------------
# # 별도 설정 불필요 - 기본값이 개발 모드
# # 또는 .Renviron에 명시적으로 설정:
# # DEPLOYMENT_ENV=development

## ----prod-env-----------------------------------------------------------------
# # .Renviron 파일에 추가:
# # DEPLOYMENT_ENV=production

## ----personal-use-------------------------------------------------------------
# # .Renviron에 API 키 저장 (사용자 홈 디렉토리)
# # 사용자 계정에만 비공개로 유지됩니다
# # ANTHROPIC_API_KEY=your_key_here

## ----max-security-------------------------------------------------------------
# # 1. .Renviron에 API 키 저장 (코드에 절대 포함하지 않음)
# usethis::edit_r_environ()
# # 추가: ANTHROPIC_API_KEY=your_key
# 
# # 2. 프로덕션에서는 show_api_config = FALSE 사용
# aiAssistantUI("ai", show_api_config = FALSE)
# 
# # 3. .Renviron을 버전 관리에 커밋하지 않음
# # .gitignore에 추가:
# # .Renviron
# # .Renviron.local
# 
# # 4. API 키를 정기적으로 교체 (90일마다 권장)
# 
# # 5. 제공자의 대시보드를 통해 API 사용량 모니터링

