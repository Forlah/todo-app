{-# LANGUAGE OverloadedStrings #-}
module TodoApp.HomeHTML where

import Data.Text.Lazy (Text)
import Lucid
import TodoApp.Models (Todo (description, todoId))

import qualified Data.Text as T
import Lucid.Base (TermRaw(termRaw))

todoRow :: Todo -> Html ()
todoRow todo =  do
  li_ [class_ "bg-white p-2 shadow-md rounded"] $ do
    div_ [class_ "space-x-3 flex justify-between" ] $ do
      span_ [class_ "text-black text-[13px] font-medium"] (toHtml (description todo) :: Html ())
      deleteBtn $ todoId todo

todoResults :: [Todo] -> Html ()
todoResults todosList = do
   div_ [class_ "", termRaw "id" "new-result"] $ do
          ul_ [class_ "space-y-2"] $ mapM_ todoRow todosList

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
      script_ [src_ "https://unpkg.com/htmx.org@2.0.1", integrity_ "sha384-QWGpdj554B4ETpJJC9z+ZHJcA/i59TyjxEPXiiUgN2WmTyV5OEZWCD6gQhgkdpB/", crossorigin_ "anonymous"] (""::Text)
    body_  $ do
      div_ [class_ "m-auto w-1/2 mt-10 bg-gray-300 p-5 rounded md:w-[350px] lg:w-[500px]"] $ do
        h2_ [class_ "text-center text-xl font-bold"] "TodoApp"
        div_ [class_ "p-3"] $ do
          form_ [class_ "h-20", termRaw "hx-post" "/addTodo" , termRaw "hx-target" "#new-result", termRaw "hx-swap" "outerHTML"] $ do
            input_ [ class_ "rounded h-8 px-2 w-full", type_ "text", name_ "todo_item", placeholder_ "Enter a todo item"]
            input_ [ class_ "bg-green-700 text-white h-8 w-full mt-6", type_ "submit", value_ "Add todo"]

        todoResults todoList


homePageHtml todoList = do renderText (page todoList)