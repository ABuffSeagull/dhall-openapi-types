let Prelude =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v23.0.0/Prelude/package.dhall
        sha256:397ef8d5cf55e576eab4359898f61a4e50058982aaace86268c62418d3027871

let Map = Prelude.Map

let MediaType = { Type = { schema : {} }, default.schema = {=} }

let Response =
      { Type =
          { description : Text
          , headers : Map.Type Text {}
          , content : Map.Type Text MediaType.Type
          , links : Map.Type Text {}
          }
      , default =
        { headers = Map.empty Text {}
        , content = Map.empty Text MediaType.Type
        , links = Map.empty Text {}
        }
      }

let Operation =
      { Type = { responses : Map.Type Text Response.Type }
      , default.responses = Map.empty Text Response.Type
      }

let Path =
      { Type = { get : Optional Operation.Type, post : Optional Operation.Type }
      , default = { get = None Operation.Type, post = None Operation.Type }
      }

let Info =
      { Type =
          { title : Text
          , version : Text
          , summary : Optional Text
          , description : Optional Text
          , termsOfService : Optional Text
          }
      , default =
        { summary = None Text
        , description = None Text
        , termsOfService = None Text
        }
      }

let OpenAPI =
      { Type =
          { openapi : Text, info : Info.Type, paths : Map.Type Text Path.Type }
      , default.paths = Map.empty Text Path.Type
      }

let openapi =
      OpenAPI::{
      , openapi = "3.1.0"
      , info = Info::{ title = "Test", version = "0.0.1" }
      , paths =
        [ { mapKey = "/get"
          , mapValue = Path::{
            , get = Some Operation::{
              , responses =
                [ { mapKey = "200", mapValue = Response::{ description = "" } }
                ]
              }
            }
          }
        ]
      }

in  openapi
