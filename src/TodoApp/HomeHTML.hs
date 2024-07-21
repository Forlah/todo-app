{-# LANGUAGE OverloadedStrings #-}
module TodoApp.HomeHTML where

import Data.Text.Lazy (Text)
import Lucid
import TodoApp.Models (Todo (description, todoId))

import qualified Data.Text as T


deleteBtn :: Int -> Html()
deleteBtn todoId = do
  let path = "/delete/" <> show todoId
  let link =  T.pack path
  a_ [href_ link , class_ "bg-red-500 text-xs text-white my-auto p-1 rounded"] "Delete"

homePageHtml :: [Todo] -> Text
page :: [Todo] -> Html ()
page todoList = do
  html_ $ do
    head_ $ do
      link_ [href_ "output.css" , rel_ "stylesheet"]
    body_  $ do
      div_ [class_ "m-auto w-1/2 mt-10 bg-gray-300 p-5 rounded md:w-[350px] lg:w-[500px]"] $ do
        h2_ [class_ "text-center text-xl font-bold"] "TodoApp"
        div_ [class_ "p-3"] $ do
          form_ [class_ "h-20", action_ "/addTodo", method_ "POST"] $ do
            input_ [ class_ "rounded h-8 px-2 w-full", type_ "text", name_ "todo_item", placeholder_ "Enter a todo item"]
            input_ [ class_ "bg-green-700 text-white h-8 w-full mt-6", type_ "submit", value_ "Add todo"]
        div_ [class_ ""] $ do
          ul_ [class_ "space-y-2"] $ mapM_ (\todo -> li_[class_ "bg-white p-2 shadow-md rounded"] $ div_ [class_ "space-x-3 flex justify-between"] $ do
            toHtml(description todo) 
            deleteBtn $ todoId todo
           )todoList 

homePageHtml todoList = do renderText(page todoList)