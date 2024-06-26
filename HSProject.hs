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

-- Validate EAN-13 input
validateEAN13 :: String -> Bool
validateEAN13 code = length code == 13 && all isDigit code

-- Encode EAN-13 digits into barcode pattern
encodeEAN13 :: String -> String
encodeEAN13 (x:xs) =
    let encoding = fromMaybe "LLLLLL" $ Map.lookup x firstDigitEncoding
        leftPart = zipWith encodeLeftDigit (take 6 xs) encoding
        rightPart = map encodeRightDigit (drop 6 xs)
    in "101" ++ concat leftPart ++ "01010" ++ concat rightPart ++ "101"
  where
    encodeLeftDigit d e
        | e == 'L' = fromMaybe "" $ Map.lookup d leftHandPatterns
        | e == 'G' = fromMaybe "" $ Map.lookup d leftHandGPatterns
    encodeRightDigit d = fromMaybe "" $ Map.lookup d rightHandPatterns
encodeEAN13 _ = error "Invalid EAN-13 code length"

-- Create barcode image
createBarcodeImage :: String -> Image Pixel8
createBarcodeImage code = generateImage pixelRenderer imgWidth imgHeight
  where
    pattern = encodeEAN13 code
    moduleWidth = 2
    moduleHeight = 100
    quietZoneWidth = 9
    imgWidth = quietZoneWidth * 2 + length pattern * moduleWidth
    imgHeight = moduleHeight

    pixelRenderer x y
        | x < quietZoneWidth || x >= imgWidth - quietZoneWidth = 255
        | pattern !! ((x - quietZoneWidth) `div` moduleWidth) == '1' = 0
        | otherwise = 255

-- Main function
main :: IO ()
main = do
    args <- getArgs
    case args of
        [ean13] -> 
            if validateEAN13 ean13
            then do
                let img = createBarcodeImage ean13
                saveBmpImage "ean13.bmp" (ImageY8 img)
                putStrLn "EAN-13 barcode image created: ean13.bmp"
            else
                putStrLn "Invalid EAN-13 code."
        _ -> putStrLn "Usage: generateBarcode <13-digit EAN-13 code>"
        
