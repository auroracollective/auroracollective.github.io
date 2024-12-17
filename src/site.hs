--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll
--import qualified Data.Set as S
--import           Text.Pandoc.Options
--------------------------------------------------------------------------------

{- pandocMathCompiler =
    let mathExtensions = [Ext_tex_math_dollars, Ext_tex_math_double_backslash,
                          Ext_latex_macros]
        defaultExtensions = writerExtensions defaultHakyllWriterOptions
        -- newExtensions = foldr S.insert defaultExtensions mathExtensions
        writerOptions = defaultHakyllWriterOptions {
                          -- writerExtensions = newExtensions,
                          writerHTMLMathMethod = MathJax ""
                        }
    in pandocCompilerWith defaultHakyllReaderOptions writerOptions

customPandocCompiler =
  pandocCompilerWith
    defaultHakyllWriterOptions
      { writerHtml5            = True
      , writerHighlight        = True
      , writerHighlightStyle   = pygments
      , writerHTMLMathMethod   = MathML Nothing
      , writerEmailObfuscation = NoObfuscation
      }  -}

main :: IO ()
main = hakyll $ do
    -- let baseurl = "http://127.0.0.1:8000/"
    -- Use the baseurl in your route and url functions
    -- For example:

    -- match "css/*" $ do
    --     route   $ setExtension "css" `composeRoutes` gsubRoute baseurl (const "")
    --     compile compressCssCompiler

    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "files/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "fonts/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile copyFileCompiler  -- compressCssCompiler

    match "scss/*" $ do
        route   idRoute
        compile copyFileCompiler  -- compressCssCompiler

    match "js/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "LICENSE.md" $ do
        route   idRoute
        compile copyFileCompiler

    match (fromList ["about.md", "people.md", "science.md", "advisory.md", "training.md", "data.md", "statistics.md", "experiments.md", "computing.md", "carpentries.md", "math.md", "thinking.md", "open.md", "visit.md"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    create ["lectures.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "lectures"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls


    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "main"                `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext
