## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  echo = TRUE,
  eval = FALSE
)

## ----api-setup----------------------------------------------------------------
# # Open .Renviron file
# usethis::edit_r_environ()
# 
# # Add one of the following lines:
# # ANTHROPIC_API_KEY=your_key_here
# # OPENAI_API_KEY=your_key_here
# # GOOGLE_API_KEY=your_key_here
# 
# # Save and restart R session

## ----basic-gadget-------------------------------------------------------------
# library(jsmodule)
# 
# # Launch gadget with AI Assistant included
# jsBasicGadget()
# 
# # Navigate to "AI Assistant" tab

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
# # Development mode - users can configure in UI
# aiAssistantUI("ai", show_api_config = TRUE)  # Default
# 
# callModule(aiAssistant, "ai",
#   data = data,
#   data_label = data.label,
#   show_api_config = TRUE
# )

## ----prod-mode----------------------------------------------------------------
# # Production mode - API key from .Renviron only
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
#   # Define custom variable roles
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
#     "NCCTG lung cancer trial data.
#      Primary outcome: time to death (status/time).
#      Focus on performance status (ph.ecog) as predictor."
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
#     show_api_config = FALSE  # Use only .Renviron
#   )
# }

## ----dev-env------------------------------------------------------------------
# # No setup needed - defaults to development mode
# # Or explicitly set in .Renviron:
# # DEPLOYMENT_ENV=development

## ----prod-env-----------------------------------------------------------------
# # Add to .Renviron file:
# # DEPLOYMENT_ENV=production

## ----personal-use-------------------------------------------------------------
# # Store API key in .Renviron (user's home directory)
# # This keeps the key private to your user account
# # ANTHROPIC_API_KEY=your_key_here

## ----max-security-------------------------------------------------------------
# # 1. Store API key in .Renviron (never in code)
# usethis::edit_r_environ()
# # Add: ANTHROPIC_API_KEY=your_key
# 
# # 2. Use show_api_config = FALSE in production
# aiAssistantUI("ai", show_api_config = FALSE)
# 
# # 3. Never commit .Renviron to version control
# # Add to .gitignore:
# # .Renviron
# # .Renviron.local
# 
# # 4. Rotate API keys regularly (every 90 days recommended)
# 
# # 5. Monitor API usage through provider's dashboard

