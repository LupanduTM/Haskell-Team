{-# LANGUAGE OverloadedStrings #-}

module Main where

import Codec.Picture
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)
import Data.Char (isDigit)
import System.Environment (getArgs)
import System.IO (hFlush, stdout)
