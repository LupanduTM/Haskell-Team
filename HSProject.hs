{-# LANGUAGE OverloadedStrings #-}

module Main where

import Codec.Picture
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)
import Data.Char (isDigit)
import System.Environment (getArgs)
import System.IO (hFlush, stdout)

-- EAN-13 patterns

leftHandPatterns :: Map.Map Char String

leftHandPatterns = Map.fromList [

    ('0', "0001101"), ('1', "0011001"), ('2', "0010011"), ('3', "0111101"),

    ('4', "0100011"), ('5', "0110001"), ('6', "0101111"), ('7', "0111011"),

    ('8', "0110111"), ('9', "0001011")

    ]



rightHandPatterns :: Map.Map Char String

rightHandPatterns = Map.fromList [

    ('0', "1110010"), ('1', "1100110"), ('2', "1101100"), ('3', "1000010"),

    ('4', "1011100"), ('5', "1001110"), ('6', "1010000"), ('7', "1000100"),

    ('8', "1001000"), ('9', "1110100")

    ]
