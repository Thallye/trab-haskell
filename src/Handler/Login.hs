{-# START_FILE Dispatch.hs #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Login where

import Import
import Network.HTTP.Types
import Database.Persist.Postgresql
import Foundation
import Yesod

headers :: Handler ()
headers = do 
    addHeader "Access-Control-Allow-Origin" "*"
    addHeader "Access-Control-Allow-Methods" "*"
    addHeader "Access-Control-Allow-Headers" "*"

optionsLoginR :: Handler ()
optionsLoginR = headers



optionsCadastroR :: Handler ()
optionsCadastroR = headers

--postLoginR :: Handler TypedContent
--postLoginR = do 
--    addHeader "Access-Control-Allow-Origin" "*"
--    usuario <- requireJsonBody :: Handler Usuario
--    usoid <- runDB $ insert usuario
--    sendStatusJSON created201 (object ["resp" .= usoid])

--postLogoutR :: Handler TypedContent
--postLogoutR = do 
--    addHeader "Access-Control-Allow-Origin" "*"
--    usuarios <- requireJsonBody :: Handler Login
--    pidout <- runDB $ insert produto 
--    sendStatusJSON created201 (object ["resp" .= pid])

getLoginR :: Handler TypedContent
getLoginR = do 
    headers
    usuarios <- runDB $ selectList [] [Asc UsuarioNome]
    sendStatusJSON ok200 (object ["resp" .= usuarios])
   
postCadastroR :: Handler TypedContent
postCadastroR = do
    addHeader "Access-Control-Allow-Origin" "*"
    usuario <- requireJsonBody :: Handler Usuario
    cadastroid <- runDB $ insert usuario
    sendStatusJSON created201 (object ["resp" .= cadastroid])