{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Home where

import Import
import Network.HTTP.Types
import Database.Persist.Postgresql

headers :: Handler ()
headers = do 
    addHeader "Access-Control-Allow-Origin" "*"
    addHeader "Access-Control-Allow-Methods" "*"
    addHeader "Access-Control-Allow-Headers" "*"

optionsHomeR :: Handler ()
optionsHomeR = headers



getHomeR :: Handler TypedContent
getHomeR = do 
    headers
    home <- runDB $ selectList [] [Asc ProdutoNome]
    sendStatusJSON ok200 (object ["resp" .= home])