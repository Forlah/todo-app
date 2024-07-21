{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric  #-}

module TodoApp.Models where

import GHC.Generics (Generic)
import Database.PostgreSQL.Simple (FromRow)
import Data.Text (Text)

data Todo = Todo {
    todoId :: Int,
    description :: Text
} deriving (Eq,Show,Generic, FromRow)
