{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Produto where

import Import
import Network.HTTP.Types
import Database.Persist.Postgresql

headers :: Handler ()
headers = do 
    addHeader "Access-Control-Allow-Origin" "*"
    addHeader "Access-Control-Allow-Methods" "*"
    addHeader "Access-Control-Allow-Headers" "*"

optionsProdutoR :: Handler ()
optionsProdutoR = headers

optionsProdutosR :: Handler ()
optionsProdutosR = headers

postProdutoR :: Handler TypedContent
postProdutoR = do 
    addHeader "Access-Control-Allow-Origin" "*"
    produto <- requireJsonBody :: Handler Produto
    pid <- runDB $ insert produto 
    sendStatusJSON created201 (object ["resp" .= pid])

getProdutosR :: Handler TypedContent
getProdutosR = do 
    headers
    produtos <- runDB $ selectList [] [Asc ProdutoNome]
    sendStatusJSON ok200 (object ["resp" .= produtos])