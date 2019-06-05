{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Animal where

import Import
import Network.HTTP.Types
import Database.Persist.Postgresql

headers :: Handler ()
headers = do 
    addHeader "Access-Control-Allow-Origin" "*"
    addHeader "Access-Control-Allow-Methods" "*"
    addHeader "Access-Control-Allow-Headers" "*"

optionsAnimalR :: Handler ()
optionsAnimalR = headers

optionsAnimaisR :: Handler ()
optionsAnimaisR = headers


postAnimalR :: Handler TypedContent
postAnimalR = do 
    addHeader "Access-Control-Allow-Origin" "*"
    animal <- requireJsonBody :: Handler Animal
    animalid <- runDB $ insert animal 
    sendStatusJSON created201 (object ["resp" .= animalid])

getAnimaisR :: Handler TypedContent
getAnimaisR = do 
    headers
    animais <- runDB $ selectList [] [Asc AnimalNome]
    sendStatusJSON ok200 (object ["resp" .= animais])