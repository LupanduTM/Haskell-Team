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
    leftHandGPatterns :: Map.Map Char String
leftHandGPatterns = Map.fromList [
    ('0', "0100111"), ('1', "0110011"), ('2', "0011011"), ('3', "0100001"),
    ('4', "0011101"), ('5', "0111001"), ('6', "0000101"), ('7', "0010001"),
    ('8', "0001001"), ('9', "0010111")
    ]

firstDigitEncoding :: Map.Map Char String
firstDigitEncoding = Map.fromList [
    ('0', "LLLLLL"), ('1', "LLGLGG"), ('2', "LLGGLG"), ('3', "LLGGGL"),
    ('4', "LGLLGG"), ('5', "LGGLLG"), ('6', "LGGGLL"), ('7', "LGLGLG"),
    ('8', "LGLGGL"), ('9', "LGGLGL")
    ]
