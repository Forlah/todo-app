module Main where

import TodoApp.Core as TD
import Database.PostgreSQL.Simple

localPG :: ConnectInfo
localPG =
  defaultConnectInfo
    { connectHost = "localhost",
      connectDatabase = "todos",
      connectUser = "postgres",
      connectPassword = ""
    }

main :: IO ()
main = do
  conn <- connect localPG
  putStrLn "Hello, Haskell!"
  TD.core conn
