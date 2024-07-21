{-# LANGUAGE OverloadedStrings #-}

module TodoApp.Core where

import Web.Scotty
import TodoApp.HomeHTML
import TodoApp.Models
import Database.PostgreSQL.Simple
import Data.Text.Lazy (Text)
import Lucid

errorPage :: Html()
errorPage = do
  h2_ "Empty Todo name not allowed ."

homeHandler :: Connection -> ActionM ()
homeHandler conn = do
  todoList <- (liftIO $ query_ conn "select * from todo_list") :: ActionM [Todo]
  html $ homePageHtml todoList

addTodoHandler :: Connection -> ActionM ()
addTodoHandler conn = do
  todoItem <- formParam "todo_item"
  liftIO $ putStrLn todoItem
  if not (null todoItem) then do
    let result = execute conn "INSERT INTO todo_list (description) VALUES (?)" (Only todoItem)
    n <- liftIO result
    if n > 0
    then
      redirect "/"
    else
     text "error occurred"
  else
    html $ renderText errorPage

deleteTodoHandler :: Connection -> ActionM ()
deleteTodoHandler conn = do
  todoId <- pathParam ("todoId" :: Text) :: ActionM Text
  let result = execute conn "DELETE FROM todo_list where todoId = ?" (Only todoId)
  n <- liftIO result
  if n > 0
    then
      redirect "/"
  else
    text "error occurred"

serveR :: ActionM ()
serveR = do
  setHeader "content-type" "text"
  file "/Users/folaoyewole/Haskell/todo-app/src/output.css"
  
core :: Connection -> IO ()
core conn = scotty 5000 $ do
  get "/" $ homeHandler conn
  post "/addTodo" $ addTodoHandler conn
  get "/delete/:todoId" $ deleteTodoHandler conn
  get "/output.css" serveR 

test :: IO ()
test = putStrLn "Hi there!"
