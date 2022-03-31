{-|
Module      : Main
Description : An easy way to create tables with wrapped text in Markdown.
Copyright   : (c) Amy de Buitléir, 2020-2022
License     : BSD--3
Maintainer  : amy@nualeargais.ie
Stability   : experimental
Portability : POSIX

See <https://github.com/mhwombat/pandoc-columns> for information
on how to use this filter.
-}
import Text.Pandoc.Filters.Columns (formatColumns)
import Text.Pandoc.JSON                (toJSONFilter)

main :: IO ()
main = toJSONFilter formatColumns
